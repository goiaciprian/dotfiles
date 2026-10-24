return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {},
  keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Search files" },
      { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Search files (Ctrl+P)" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live search" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Open buffers search" },
    }
}
