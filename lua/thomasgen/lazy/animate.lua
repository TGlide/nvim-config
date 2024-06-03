return {
	'echasnovski/mini.animate',
	version = false,
	enabled = false,
	config = function()
		require('mini.animate').setup({
			cursor = {
				enable = false
			}
		})
	end
}
