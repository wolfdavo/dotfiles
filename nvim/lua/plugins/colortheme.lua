-- return {
--   "navarasu/onedark.nvim",
--   name = "onedark",
--   priority = 1000,
--   config = function()
--     require("onedark").setup {
--       style = "darker"
--     }
--     require("onedark").load()
--
--   end
-- }

return {
  'scottmckendry/cyberdream.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('cyberdream').setup {
      -- Enable transparent background
      transparent = true,
    }
    require('cyberdream').load()
  end,
}
