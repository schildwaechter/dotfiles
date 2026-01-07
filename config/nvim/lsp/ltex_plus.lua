local custom_words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/all.utf-8.add", "r"):lines() do
  table.insert(custom_words, word)
end

return {
  cmd = { "ltex-ls-plus" },
  filetypes = { "bib", "tex", "markdown" },
  root_markers = { { ".git" } },
  settings = {
    ltex = {
      enabled = { "latex", "tex" },
      dictionary = {
        ["de-DE"] = custom_words,
        ["en-US"] = custom_words,
        ["en-GB"] = custom_words,
        ["no-NO"] = custom_words,
      }
    },
  },
}
