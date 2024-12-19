return {
	"goolord/alpha-nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local function getLen(str, start_pos)
			local byte = string.byte(str, start_pos)
			if not byte then
				return nil
			end

			return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
		end

		local function colorize(header, header_color_map, colors)
			for letter, color in pairs(colors) do
				local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
				vim.api.nvim_set_hl(0, color_name, color)
				colors[letter] = color_name
			end

			local colorized = {}

			for i, line in ipairs(header_color_map) do
				local colorized_line = {}
				local pos = 0

				for j = 1, #line do
					local start = pos
					pos = pos + getLen(header[i], start + 1)

					local color_name = colors[line:sub(j, j)]
					if color_name then
						table.insert(colorized_line, { color_name, start, pos })
					end
				end

				table.insert(colorized, colorized_line)
			end

			return colorized
		end

		local alpha_c = function()
			local alpha = require("alpha")

			local dashboard = require("alpha.themes.dashboard")

			local header = {
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████                                   ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
				[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
			}

			local color_map = {
				[[ WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWWWWWWWWWW ]],
				[[ RRRRWWWWWWWWWWWWWWWWRRRRRRRRRRRRRRRRWWWWWWWWWWWWWWWWBBPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBBWWWWWWWWWWWW ]],
				[[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPPPHHHHHHHHHHHHHHHHHHHHHHHHHHPPPPPPBBWWWWWWWWWW ]],
				[[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPHHHHHHHHHHHHFFHHHHFFHHHHHHHHHHPPPPBBWWWWWWWWWW ]],
				[[ OOOORRRRRRRRRRRRRRRROOOOOOOOOOOOOOOORRRRRRRRRRRRRRBBPPHHHHFFHHHHHHHHHHHHHHHHHHHHHHHHHHHHPPBBWWWWWWWWWW ]],
				[[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHHHBBBBHHHHFFHHHHPPBBWWBBBBWWWW ]],
				[[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMBBHHHHHHHHPPBBBBMMMMBBWW ]],
				[[ YYYYOOOOOOOOOOOOOOOOYYYYYYYYYYYYYYYYOOBBBBBBBBOOOOBBPPHHHHHHHHHHHHFFHHHHBBMMMMMMBBHHHHHHPPBBMMMMMMBBWW ]],
				[[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBMMMMBBBBOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMMMMMBBBBBBBBMMMMMMMMBBWW ]],
				[[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBBBMMMMBBBBBBPPHHHHHHFFHHHHHHHHHHBBMMMMMMMMMMMMMMMMMMMMMMMMBBWW ]],
				[[ GGGGYYYYYYYYYYYYYYYYGGGGGGGGGGGGGGGGYYYYBBBBMMMMBBBBPPHHHHHHHHHHHHHHFFBBMMMMMMMMMMMMMMMMMMMMMMMMMMMMBB ]],
				[[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBMMMMBBPPHHFFHHHHHHHHHHHHBBMMMMMMCCBBMMMMMMMMMMCCBBMMMMBB ]],
				[[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBBBBBPPHHHHHHHHHHHHHHHHBBMMMMMMBBBBMMMMMMBBMMBBBBMMMMBB ]],
				[[ UUUUGGGGGGGGGGGGGGGGUUUUUUUUUUUUUUUUGGGGGGGGGGGGBBBBPPHHHHHHHHHHFFHHHHBBMMRRRRMMMMMMMMMMMMMMMMMMRRRRBB ]],
				[[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPHHFFHHHHHHHHHHBBMMRRRRMMBBMMMMBBMMMMBBMMRRRRBB ]],
				[[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPPPHHHHHHHHHHHHHHBBMMMMMMBBBBBBBBBBBBBBMMMMBBWW ]],
				[[ VVVVUUUUUUUUUUUUUUUUVVVVVVVVVVVVVVVVUUUUUUUUUUUUBBBBBBPPPPPPPPPPPPPPPPPPPPBBMMMMMMMMMMMMMMMMMMMMBBWWWW ]],
				[[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMMMBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWW ]],
				[[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMBBBBWWBBMMMMBBWWWWWWWWWWBBMMMMBBWWBBMMMMBBWWWWWWWW ]],
				[[ WWWWVVVVVVVVVVVVVVVVWWWWWWWWWWWWWWWWVVVVVVVVVVBBBBBBBBWWWWBBBBBBWWWWWWWWWWWWWWBBBBBBWWWWBBBBWWWWWWWWWW ]],
			}

			local colors = {
				["W"] = { fg = "#1e1e2e" }, -- Using Base color
				["C"] = { fg = "#cdd6f4" }, -- Using Text color
				["B"] = { fg = "#11111b" }, -- Using Crust color
				["R"] = { fg = "#f38ba8" }, -- Using Red color
				["O"] = { fg = "#fab387" }, -- Using Peach color
				["Y"] = { fg = "#f9e2af" }, -- Using Yellow color
				["G"] = { fg = "#a6e3a1" }, -- Using Green color
				["U"] = { fg = "#89b4fa" }, -- Using Blue color
				["P"] = { fg = "#f9e2af" }, -- Using Yellow color (as specified in original)
				["H"] = { fg = "#f5c2e7" }, -- Using Pink color
				["F"] = { fg = "#f38ba8" }, -- Using Red color
				["M"] = { fg = "#6c7086" }, -- Using Overlay0 color
				["V"] = { fg = "#b4befe" }, -- Using Lavender color
			}

			dashboard.section.header.val = header
			dashboard.section.header.opts = {
				hl = colorize(header, color_map, colors),
				position = "center",
			}

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", "<Cmd>ene <CR>"),
				dashboard.button("SPC p f", "  Find file"),
				dashboard.button("SPC w q", "  Quit"),
			}
			for _, a in ipairs(dashboard.section.buttons.val) do
				a.opts.width = 49
				a.opts.cursor = -2
			end

			alpha.setup(dashboard.config)
		end

		alpha_c()
	end,
}
