local vscode = {}

function vscode.setup(variant)
    variant = variant or 'dark'
    require('vscode').load(variant)
end

return vscode
