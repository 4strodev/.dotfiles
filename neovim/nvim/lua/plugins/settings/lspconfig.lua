local M = {}

local ctx = require('config.keymaps').new()
M.keymaps = ctx

local bufopts = { noremap = true, silent = true }

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
ctx:buffer_map('n', 'gD', vim.lsp.buf.declaration, bufopts)
ctx:buffer_map('n', 'gd', "<CMD>Lspsaga goto_definition<CR>", bufopts)
ctx:buffer_map('n', 'gi', vim.lsp.buf.implementation, bufopts)
ctx:buffer_map({ 'n', 'i' }, '<C-k>', function() require('lsp_signature').toggle_float_win() end, bufopts)
ctx:buffer_map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
ctx:buffer_map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
ctx:buffer_map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
ctx:buffer_map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
ctx:buffer_map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
ctx:buffer_map('n', 'gr', "<CMD>Lspsaga finder<CR>", bufopts)
ctx:buffer_map('n', '<space>fd', function() vim.lsp.buf.format { async = true } end, bufopts)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
ctx:map('n', '<space>ee', vim.diagnostic.open_float, opts)
ctx:map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
ctx:map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
ctx:map('n', '<space>qq', vim.diagnostic.setloclist, opts)

local setup_keymaps = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

    ctx:apply_buffer(bufnr)
end

local setup_highlight = function(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

        vim.api.nvim_create_autocmd("CursorHold", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd("CursorHoldI", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    setup_keymaps(client, bufnr)
    setup_highlight(client, bufnr)
end

-- Build jdtls runtimes from every JDK installed with asdf.
local function asdf_java_runtimes()
    local runtimes, seen = {}, {}
    local root = vim.fn.expand("~/.asdf/installs/java")
    for _, dir in ipairs(vim.fn.glob(root .. "/*", false, true)) do
        -- "adoptopenjdk-21.0.13+9.0.LTS" -> 21, "temurin-8.0.402" -> 8
        local major = vim.fn.fnamemodify(dir, ":t"):match("%-(%d+)")
        if major and not seen[major] and vim.fn.executable(dir .. "/bin/javac") == 1 then
            seen[major] = true
            table.insert(runtimes, {
                name = "JavaSE-" .. (major == "8" and "1.8" or major),
                path = dir,
            })
        end
    end
    -- the newest JDK is the default
    table.sort(runtimes, function(a, b)
        local function n(r) return tonumber(r.name:match("(%d+%.?%d*)$")) end
        return n(a) > n(b)
    end)
    if runtimes[1] then runtimes[1].default = true end
    return runtimes
end

-- jdtls itself needs a newer JDK (1.63 requires Java 25+) than the projects it
-- analyses, and `java` on PATH follows .tool-versions (e.g. 21). Pick the
-- newest JDK >= 25 to run the server; project JDKs come from `runtimes` above.
local JDTLS_MIN_JAVA = 25
local function jdtls_java_executable()
    local homes = vim.fn.glob("/usr/lib/jvm/*", false, true)
    vim.list_extend(homes, vim.fn.glob(vim.fn.expand("~/.asdf/installs/java/*"), false, true))
    local best, best_major
    for _, home in ipairs(homes) do
        local java = home .. "/bin/java"
        local f = io.open(home .. "/release")
        local major
        if f then
            major = tonumber(f:read("*a"):match('JAVA_VERSION="(%d+)'))
            f:close()
        end
        if major and major >= JDTLS_MIN_JAVA and vim.fn.executable(java) == 1
            and (not best_major or major > best_major) then
            best, best_major = java, major
        end
    end
    return best
end

function M.setup()
    local mason = require('mason')
    --local mason_dap = require('mason-nvim-dap')
    local mason_lspconfig = require('mason-lspconfig')
    local util = require("lspconfig.util");

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            on_attach(client, event.buf)
        end
    })

    -- Auto signature help while typing. Uses its own LspAttach hook, so it
    -- attaches to every server regardless of per-server on_attach overrides.
    require('lsp_signature').setup({
        bind = true,
        floating_window = true,
        -- Get out of the way when the nvim-cmp completion menu is visible.
        check_completion_visible = true,
        hint_enable = false, -- prefer the float over inline virtual text
        handler_opts = { border = "rounded" },
        toggle_key = nil,    -- toggling is bound to <C-k> in setup_keymaps
    })

    ctx:apply()

    vim.lsp.config("jdtls", {
        -- Same as nvim-lspconfig's default cmd, plus --java-executable.
        cmd = function(dispatchers, config)
            local data_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace"
            if config.root_dir then
                data_dir = data_dir .. "/" .. vim.fn.fnamemodify(config.root_dir, ":p:h:t")
            end
            local cmd = { "jdtls", "-data", data_dir }
            local java = jdtls_java_executable()
            if java then
                vim.list_extend(cmd, { "--java-executable", java })
            end
            for a in string.gmatch(os.getenv("JDTLS_JVM_ARGS") or "", "%S+") do
                table.insert(cmd, "--jvm-arg=" .. a)
            end
            return vim.lsp.rpc.start(cmd, dispatchers, {
                cwd = config.cmd_cwd,
                env = config.cmd_env,
                detached = config.detached,
            })
        end,
        settings = {
            java = {
                configuration = {
                    runtimes = asdf_java_runtimes(),
                },
                format = {
                    enabled = true,
                    settings = {
                        url = "style.xml"
                    }
                }
            }
        }
    })

    vim.lsp.config('ts_ls', {
        on_attach = function(client, bufnr)
            local root_dir = client.config.root_dir

            -- helper: check if a file exists
            local function exists(path)
                return util.path.exists(util.path.join(root_dir, path))
            end

            -- disable ts_ls formatting if Prettier is present
            if exists("node_modules/.bin/prettier")
                or exists("prettier.config.js")
                or exists(".prettierrc")
                or exists(".prettierrc.js")
                or exists(".prettierrc.json")
                or exists(".prettierrc.yaml")
                or exists(".prettierrc.yml") then
                client.server_capabilities.documentFormattingProvider = false
            end
            on_attach(client, bufnr)
        end,
    })

    vim.lsp.config('lua_ls', {
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which Lua version you're using
                    version = 'LuaJIT',
                    -- Setup your runtime path so lua_ls knows where to find lua files
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of runtime files and your config
                    library = {
                        -- This adds neovim runtime files to the workspace library
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        -- Also add your config lua files
                        [vim.fn.stdpath('config') .. '/lua'] = true,
                    },
                    checkThirdParty = false, -- optional: disables third-party checks popup
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })

    local extension_path = vim.fn.stdpath("data")
        .. "/mason/packages/sonarlint-language-server/extension"

    require("sonarqube").setup({
        lsp = {
            cmd = {
                vim.fn.exepath("java"),
                "-jar",
                extension_path .. "/server/sonarlint-ls.jar",
                "-stdio",
                "-analyzers",
                extension_path .. "/analyzers/sonargo.jar",
                extension_path .. "/analyzers/sonarhtml.jar",
                extension_path .. "/analyzers/sonariac.jar",
                extension_path .. "/analyzers/sonarjava.jar",
                extension_path .. "/analyzers/sonarjavasymbolicexecution.jar",
                extension_path .. "/analyzers/sonarjs.jar",
                extension_path .. "/analyzers/sonarphp.jar",
                extension_path .. "/analyzers/sonarpython.jar",
                extension_path .. "/analyzers/sonartext.jar",
                extension_path .. "/analyzers/sonarxml.jar",
            },
        },
        javascript = {
            enabled = true,
            clientNodePath = vim.fn.exepath("node")
        },
    })

    mason.setup()
    mason_lspconfig.setup({
        ensure_installed = { "clangd", "lua_ls", "ts_ls" },
    })
end

return M
