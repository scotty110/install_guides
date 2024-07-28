-- Belongs ~/.vim/lsp_config.lua

lspconfig = require'lspconfig'
completion_callback = require'completion'.on_attach

lspconfig.pyright.setup{on_attach=completion_callback}
