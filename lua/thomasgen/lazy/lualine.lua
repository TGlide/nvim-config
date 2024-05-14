local function setup_macro_refresh(lualine)
    vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
            lualine.refresh({
                place = { "statusline" },
            })
        end,
    })
    vim.api.nvim_create_autocmd("RecordingLeave", {
        callback = function()
            local timer = vim.loop.new_timer()
            timer:start(
                50,
                0,
                vim.schedule_wrap(function()
                    lualine.refresh({
                        place = { "statusline" },
                    })
                end)
            )
        end,
    })
end

local function macro_recording_status()
    local function current_status()
        local register = vim.fn.reg_recording()
        return register == "" and "" or "RECORDING @" .. register
    end
    return { "macro-recording", fmt = current_status }
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        vim.opt.laststatus = 0
    end,
    config = function()
        vim.opt.laststatus = 3

        local lualine = require("lualine")
        setup_macro_refresh(lualine)

        local function heart()
            return [[♥ ]]
        end

        -- custom theme
        -- local custom_rose_pine = require 'lualine.themes.rose-pine'
        local p = require("rose-pine.palette")
        local config = require("rose-pine.config")

        local bg_base = p.base
        if config.options.styles.transparency then
            bg_base = "NONE"
        end

        local custom_rose_pine = {
            normal = {
                a = { bg = p.rose, fg = p.base, gui = "bold" },
                b = { bg = p.overlay, fg = p.rose },
                c = { bg = '#2C232E', fg = p.text },
            },
            insert = {
                a = { bg = p.foam, fg = p.base, gui = "bold" },
                b = { bg = p.overlay, fg = p.foam },
                c = { bg = '#252834', fg = p.text },
            },
            visual = {
                a = { bg = p.iris, fg = p.base, gui = "bold" },
                b = { bg = p.overlay, fg = p.iris },
                c = { bg = '#292436', fg = p.text },
            },
            replace = {
                a = { bg = p.pine, fg = p.base, gui = "bold" },
                b = { bg = p.overlay, fg = p.pine },
                c = { bg = '#1C2231', fg = p.text },
            },
            command = {
                a = { bg = p.love, fg = p.base, gui = "bold" },
                b = { bg = p.overlay, fg = p.love },
                c = { bg = '#2C1F2E', fg = p.text },
            },
            inactive = {
                a = { bg = bg_base, fg = p.muted, gui = "bold" },
                b = { bg = bg_base, fg = p.muted },
                c = { bg = bg_base, fg = p.muted },
            },
        }


        lualine.setup({
            options = {
                theme = custom_rose_pine,
                component_separators = "",
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha" },
            },
            sections = {
                lualine_a = {
                    { "mode", separator = { left = "", right = "" }, right_padding = 2 },
                    macro_recording_status(),
                },
                lualine_b = {
                    "branch",
                    "diff",
                    "diagnostics",
                },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "filetype" },
                lualine_y = { "progress" },
                lualine_z = {
                    {
                        "location",
                        separator = { left = "" },
                        left_padding = 2
                    },
                    {
                        heart,
                        separator = { right = "" },
                    }
                },
            },
            extensions = { "nvim-tree", "fzf" },
        })
    end,
}
