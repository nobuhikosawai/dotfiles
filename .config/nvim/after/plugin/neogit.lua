if (not pcall(require, 'neogit')) then
  return
end

require('neogit').setup {
  integrations = {
    diffview = true
  }
}
