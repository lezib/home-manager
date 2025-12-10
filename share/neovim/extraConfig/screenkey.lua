-- Configuration du plugin screenkey.nvim
require("screenkey").setup({
  -- Options de configuration (exemple)
  clear_after = 2000, -- Cache après 2000ms d'inactivité
  position = "bottom", -- Position de la fenêtre
  hide_modes = { "i" }, -- Cacher les touches en mode Insertion
})

-- Définir un raccourci pour basculer Screenkey
-- vim.keymap.set("n", "<leader>ks", function()
--   require("screenkey").toggle()
-- end, { desc = "Toggle Screenkey" })
