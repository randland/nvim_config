return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<cr>", { noremap = true })
    end,
  },
  {
    "tpope/vim-fugitive",
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,        -- Enable inline blame for the current line
        current_line_blame_opts = {
          delay = 10,                   -- Delay before blame appears (in milliseconds)
          virt_text_pos = 'eol',          -- Position blame text at the end of the line
        },
        current_line_blame_formatter = '    <author>, <author_time:%Y-%m-%d> - <summary>',
      })
      vim.keymap.set('n', '<leader>gb', function()
        require('gitsigns').toggle_current_line_blame()
      end, { desc = "Toggle Git Blame for Current Line" })

      local function open_commit_url()
        local Job = require('plenary.job')

        -- Get the absolute path of the current file and the current line number
        local file_path = vim.fn.expand('%:p')
        local line_number = vim.api.nvim_win_get_cursor(0)[1]

        if file_path == "" then
          vim.notify("No file path found for the current buffer", vim.log.levels.ERROR)
          return
        end

        -- Check if the file has uncommitted changes
        Job:new({
          command = 'git',
          args = { 'diff', '--name-only', file_path },
          on_exit = function(diff_job)
            local diff_output = diff_job:result()

            if #diff_output > 0 then
              vim.schedule(function()
                vim.notify("File has uncommitted changes. Please commit or stash changes before running this command.", vim.log.levels.WARN)
              end)
              return
            end

            -- Run `git blame` to get the commit hash for the specific line
            Job:new({
              command = 'git',
              args = { 'blame', '-L', line_number .. ',' .. line_number, '--porcelain', file_path },
              on_exit = function(blame_job)
                local output = blame_job:result()

                -- Extract the commit hash from the first line of the `git blame` output
                local commit_hash = output[1] and output[1]:match("^(%w+)")
                if not commit_hash then
                  vim.schedule(function()
                    vim.notify("Could not determine commit hash for this line", vim.log.levels.ERROR)
                  end)
                  return
                end

                -- Get the repository URL
                Job:new({
                  command = 'git',
                  args = { 'remote', 'get-url', 'origin' },
                  on_exit = function(remote_job)
                    local url = table.concat(remote_job:result(), "")
                    if url == "" then
                      vim.schedule(function()
                        vim.notify("Could not determine repository URL", vim.log.levels.ERROR)
                      end)
                      return
                    end

                    -- Convert SSH URLs to HTTPS if necessary
                    url = url:gsub("git@github.com:", "https://github.com/")
                    url = url:gsub("%.git$", "")

                    -- Construct the commit URL
                    local commit_url = url .. "/commit/" .. commit_hash

                    -- Open the URL in the default browser
                    vim.schedule(function()
                      vim.fn.jobstart({ "xdg-open", commit_url }, { detach = true })  -- Linux (xdg-open)
                      -- vim.fn.jobstart({ "open", commit_url }, { detach = true })     -- macOS (open)
                      -- vim.fn.jobstart({ "start", commit_url }, { detach = true })    -- Windows (start)
                      vim.notify("Opening commit URL in browser: " .. commit_url, vim.log.levels.INFO)
                    end)
                  end,
                }):start()
              end,
            }):start()
          end,
        }):start()
      end

      local function open_pr_url()
        local Job = require('plenary.job')

        -- Get the absolute path of the current file and the current line number
        local file_path = vim.fn.expand('%:p')
        local line_number = vim.api.nvim_win_get_cursor(0)[1]

        if file_path == "" then
          vim.notify("No file path found for the current buffer", vim.log.levels.ERROR)
          return
        end

        -- Check if the file has uncommitted changes
        Job:new({
          command = 'git',
          args = { 'diff', '--name-only', file_path },
          on_exit = function(diff_job)
            local diff_output = diff_job:result()

            if #diff_output > 0 then
              vim.schedule(function()
                vim.notify("File has uncommitted changes. Please commit or stash changes before running this command.", vim.log.levels.WARN)
              end)
              return
            end

            -- Run `git blame` to get the commit hash for the specific line
            Job:new({
              command = 'git',
              args = { 'blame', '-L', line_number .. ',' .. line_number, '--porcelain', file_path },
              on_exit = function(blame_job)
                local output = blame_job:result()

                -- Extract the commit hash from the first line of the `git blame` output
                local commit_hash = output[1] and output[1]:match("^(%w+)")
                if not commit_hash then
                  vim.schedule(function()
                    vim.notify("Could not determine commit hash for this line", vim.log.levels.ERROR)
                  end)
                  return
                end

                -- Retrieve repository information using `gh repo view`
                Job:new({
                  command = 'gh',
                  args = { 'repo', 'view', '--json', 'nameWithOwner' },
                  on_exit = function(repo_job)
                    local repo_result = table.concat(repo_job:result(), "")
                    if repo_result == "" then
                      vim.schedule(function()
                        vim.notify("Could not determine repository information", vim.log.levels.ERROR)
                      end)
                      return
                    end

                    -- Schedule JSON decoding to avoid async restriction
                    vim.schedule(function()
                      local repo_info = vim.fn.json_decode(repo_result)
                      local repo_name = repo_info.nameWithOwner

                      -- Use the GitHub API to find the PR associated with the commit
                      Job:new({
                        command = 'gh',
                        args = { 'api', '/repos/' .. repo_name .. '/commits/' .. commit_hash .. '/pulls', '--jq', '.[0].html_url' },
                        on_exit = function(api_job)
                          local pr_url = table.concat(api_job:result(), "")

                          vim.schedule(function()
                            -- Check if a PR URL was found
                            if pr_url ~= "" then
                              -- Open the URL in the default browser
                              vim.fn.jobstart({ "xdg-open", pr_url }, { detach = true })  -- Linux (xdg-open)
                              -- vim.fn.jobstart({ "open", pr_url }, { detach = true })     -- macOS (open)
                              -- vim.fn.jobstart({ "start", pr_url }, { detach = true })    -- Windows (start)
                              vim.notify("Opening PR URL in browser: " .. pr_url, vim.log.levels.INFO)
                            else
                              vim.notify("No PR found for this commit or commit is not part of a PR", vim.log.levels.WARN)
                            end
                          end)
                        end,
                      }):start()
                    end)
                  end,
                }):start()
              end,
            }):start()
          end,
        }):start()
      end

      vim.keymap.set('n', '<leader>gc', open_commit_url, { desc = "Copy GitHub PR URL to clipboard" })
      vim.keymap.set('n', '<leader>gp', open_pr_url, { desc = "Copy GitHub PR URL to clipboard" })
    end,
    on_attach = function()
      -- Set the blame color to a mid-tone gray between the hybrid.vim background and foreground
      vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '98b9d9f', italic = true })
    end,
  },
}
