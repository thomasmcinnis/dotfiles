-- [[ UI modifications ]]
-- Globals
vim.g.have_nerd_font = true

-- Custom hover for signature, hover, diagnostics
local float = { focusable = false, style = "minimal", border = "single", source = true }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
---@type vim.diagnostic.Opts.Float
vim.diagnostic.config({ float })

-- LSP Progress indicator
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
vim.api.nvim_create_autocmd("LspProgress", {
    desc = "Show visual spinner for lsp loading the workspace",
    callback = function(ev)
        local spinner_idx = math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner_frames + 1
        vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
                notif.icon = ev.data.params.value.kind == "end" and " " or spinner_frames[spinner_idx]
            end,
        })
    end,
})

-- Define the fixed width for the 'codecompanion' buffer type
-- // TODO: fix this so it doesn't effect other winodows
--
-- vim.api.nvim_create_autocmd("WinResized", {
--     pattern = "*",
--     callback = function()
--         local win_id = vim.fn.win_getid(vim.fn.bufwinnr("CodeCompanion"))
--         if win_id ~= -1 and vim.api.nvim_win_is_valid(win_id) then
--             vim.api.nvim_win_set_width(win_id, 60)
--         end
--     end,
-- })


-- CodeCompanion Progress indicator
local cc_spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local cc_timers = {}
local cc_message = {}
local cc_icon = " "
local cc_title = "CodeCompanion"

vim.api.nvim_create_autocmd("User", {
    pattern = { "CodeCompanionRequest*" },
    callback = function(ev)
        local request_id = ev.data.id
        local event

        if ev.match == "CodeCompanionRequestStarted" then
            event = "active"
            cc_message[request_id] = "Processing request"
        elseif ev.match == "CodeCompanionRequestStreaming" then
            event = "active"
            cc_message[request_id] = "Streaming response"
        elseif ev.match == "CodeCompanionRequestFinished" then
            event = "complete"
        end

        -- Active notifications (pending/streaming) share the same ID
        local notification_id = event == "active"
            and request_id
            or request_id .. "_complete"

        -- Stop any existing timer for this request
        if cc_timers[request_id] then
            cc_timers[request_id]:stop()
            cc_timers[request_id]:close()
            cc_timers[request_id] = nil
        end

        -- For the completion event, hide the active notification
        if event == "complete" then
            Snacks.notifier.hide(request_id)

            -- Show completion notification
            Snacks.notifier.notify("✓ Request complete", vim.log.levels.SUCCESS, {
                id = notification_id,
                title = cc_title,
                icon = cc_icon,
                timeout = 1000
            })
        else
            -- For active events (pending/streaming)
            -- Create or update the notification
            Snacks.notifier.notify(cc_message[request_id], vim.log.levels.INFO, {
                id = notification_id,
                title = cc_title,
                icon = cc_icon,
                timeout = false
            })

            cc_timers[request_id] = vim.uv.new_timer()
            cc_timers[request_id]:start(80, 80, vim.schedule_wrap(function()
                local spinner_idx = math.floor(vim.uv.hrtime() / (1e6 * 80)) % #cc_spinner_frames + 1
                local current_message = cc_spinner_frames[spinner_idx] .. " " .. cc_message[request_id]
                Snacks.notifier.notify(current_message, vim.log.levels.INFO, {
                    id = notification_id,
                    title = cc_title,
                    icon = cc_icon,
                    timeout = false
                })
            end))
        end
    end
})


-- Highligt text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Open help docs in a vertical split to the right with a width of 80 columns
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L | vertical resize 80",
})

-- [[ Basic settings ]]
-- Editor options
local options = {
    number = true,
    relativenumber = true,
    signcolumn = "yes:1",
    mouse = "a",
    wrap = false,
    ignorecase = true,
    smartcase = true,
    hlsearch = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    scrolloff = 10,
    cursorline = false,
    inccommand = "split",
    laststatus = 2,
    foldlevel = 99,
    foldlevelstart = 99,
    foldenable = true,
    background = "",
}

for k, v in pairs(options) do
    vim.o[k] = v
end

-- [[ Clipboard configuration ]]
--
-- Make capital Y and P for using system clipboard
vim.keymap.set({ "n", "v" }, "Y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "P", '"+p', { desc = "Put from system clipboard" })

-- WSL specific
if vim.fn.has("wsl") == 1 then
    local clip_ex_path = vim.fn.executable("clip.exe")
    if clip_ex_path == 1 then
        vim.g.clipboard = {
            name = "win_clipboard",
            copy = {
                ["+"] = "clip.exe",
                ["*"] = "clip.exe",
            },
            paste = {
                ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            },
            cache_enabled = 0,
        }
    else
        vim.notify("clip.exe not found in $PATH. No system clipboard saving possible", vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_autocmd("BufRead", {
    pattern = { "*.sld", "*.sls", "*.sps" },
    command = "setfiletype scheme",
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "*.sld", "*.sls", "*.sps" },
    command = "setfiletype scheme",
})

vim.g["conjure#mapping#doc_word"] = false

-- set tab to 3 space when entering a buffer with .lua file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.vue" },
    callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
    end
})
