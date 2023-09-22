-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Move between open buffers.
lvim.keys.normal_mode["<C-n>"] = ":bnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":bprev<CR>"
lvim.keys.normal_mode["x"] = "\"_x"

-- Split Window
lvim.keys.normal_mode["ss"] = ":split<CR>"
lvim.keys.normal_mode["sv"] = ":vsplit<CR>"

-- New tab
lvim.keys.normal_mode["te"] = ":tabedit<CR>"

