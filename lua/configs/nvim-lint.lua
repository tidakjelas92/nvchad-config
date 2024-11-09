local present, lint = pcall(require, "lint")

if not present then
  return
end

local gdlint_bin = vim.fn.resolve(vim.fn.stdpath "data" .. "/mason/bin/gdlint")

lint.linters_by_ft = {
  gdscript = { "gdlint" },
}
lint.linters.gdlint.cmd = gdlint_bin

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
