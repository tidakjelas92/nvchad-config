-- https://www.reddit.com/r/neovim/comments/16qls9t/comment/k20hwx9/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.cmd [[match TrailingWhitespace /\s\+$/]]
vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.list = false
    vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Whitespace" })
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.list = true
    vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })
  end,
})
