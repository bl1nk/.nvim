setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal noexpandtab

" Format on save
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)

