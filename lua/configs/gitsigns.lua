local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "<leader>gj", function()
      if vim.wo.diff then
        return "<leader>gj"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Next hunk" })

    map("n", "<leader>gk", function()
      if vim.wo.diff then
        return "<leader>gk"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Prev hunk" })

    -- Actions
    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
    map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage hunk" })
    map("n", "<leader>gR", gs.reset_buffer, { desc = "Reser buffer" })
    map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, { desc = "Git blame" })
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
    map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
    map("n", "<leader>gD", function()
      gs.diffthis("~")
    end, { desc = "Diff this ~" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
  end,
})
