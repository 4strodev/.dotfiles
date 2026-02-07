vim.fn.setreg("e", ":enew\npggdd:silent! %s/\\\\/\\\\\\\\/g\n:silent! %s/\\\"/\\\\\"/g\n:silent! %s/\\n/\\\\n/g\n:silent! %s/\\t/\\\\t/g\ngg0y$:bdel! | bp\n:noh\n")
