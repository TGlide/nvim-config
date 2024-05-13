local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
	  "eslint",
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

 local cmp = require('cmp')
 local cmp_select = { behavior = cmp.SelectBehavior.Select }

 cmp.setup({
	 snippet = {
		 expand = function(args)
			 require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		 end,
	 },
	 mapping = cmp.mapping.preset.insert({
		 ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		 ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		 ['<C-y>'] = cmp.mapping.confirm({ select = true }),
		 ["<C-Space>"] = cmp.mapping.complete(),
	 }),
	 sources = cmp.config.sources({
		 { name = 'nvim_lsp' },
		 { name = 'luasnip' }, -- For luasnip users.
	 }, {
		 { name = 'buffer' },
	 })
 })
