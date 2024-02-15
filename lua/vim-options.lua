vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set wildignore+=*/.git*,*/tags,*/vendor/*")
-- vim.cmd("set termguicolors")
vim.cmd("set list")
vim.cmd("se number")
vim.cmd([[set listchars=tab:\ ,trail:␠,extends:>,precedes:<]])

vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>x", ":x<CR>", { noremap = true })
vim.keymap.set("n", "<leader>X", ":x<CR>", { noremap = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<leader>W", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { noremap = true })

vim.keymap.set("n", "<leader>d", '"+d', { noremap = true })
vim.keymap.set("n", "<leader>D", '"+D', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { noremap = false })
vim.keymap.set("n", "Y", 'y$', { noremap = true })

vim.keymap.set("n", "<leader>-", ":split<cr><c-w>j", { noremap = true })
vim.keymap.set("n", "<leader>_", ":split<cr><c-w>j", { noremap = true })

vim.keymap.set("n", "<leader>|", ":vsplit<cr><c-w>l", { noremap = true })
vim.keymap.set("n", "<leader>_", ":vsplit<cr><c-w>l", { noremap = true })

vim.keymap.set("n", "<leader><left>", "<c-w><left>", { noremap = true })
vim.keymap.set("n", "<leader><right>", "<c-w><right>", { noremap = true })
vim.keymap.set("n", "<leader><up>", "<c-w><up>", { noremap = true })
vim.keymap.set("n", "<leader><down>", "<c-w><down>", { noremap = true })

vim.keymap.set("n", "<leader>cf", ":!echo % | wl-copy<cr><cr>", { noremap = true })
vim.keymap.set("n", "<leader>cl", ":!echo %:<c-r>=line('.')<cr> | wl-copy<cr><cr>", { noremap = true })

vim.keymap.set("n", "<leader>cp", "yap<S-}>p", { noremap = true })

vim.keymap.set("n", "<leader>o", "o<esc>k", { noremap = true })
vim.keymap.set("n", "<leader>O", "O<esc>j", { noremap = true })

vim.keymap.set("n", "<leader>rf", ":w<cr>:VtrSendCommandToRunner dox-do bundle exec rspec -f documentation <c-r>=expand('%')<cr><cr>", { noremap = true })
vim.keymap.set("n", "<leader>rl", ":w<cr>:VtrSendCommandToRunner dox-do bundle exec rspec -f documentation <c-r>=expand('%')<cr>:<c-r>=line('.')<cr><cr>", { noremap = true })
vim.keymap.set("n", "<leader>rt", ":w<cr>:VtrSendCommandToRunner dox-do bundle exec rake test TEST=<c-r>=expand('%')<cr><cr>", { noremap = true })

vim.keymap.set("n", "<leader>rc", ":w<cr>:VtrSendCommandToRunner dox-do rubocop --config .rubocop.ci.yml --display-cop-names --extra-details --display-style-guide --force-exclusion $(git diff --name-only --diff-filter=AM origin/master..HEAD -- '*.rb' '*.rake' '*.jbuilder')<cr><cr>", { noremap = true })
vim.keymap.set("n", "<leader>rb", ":w<cr>:VtrSendCommandToRunner ruby <c-r>=expand('%')<cr><cr>", { noremap = true })
vim.keymap.set("n", "<leader>r!", ":w<cr>:VtrSendCommandToRunner !!!<cr>", { noremap = true })

vim.keymap.set("n", "<leader>=", "=ae", { noremap = false })


