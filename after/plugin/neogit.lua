local neogit = require('neogit')

vim.keymap.set('n', '<leader>go', function() 
    neogit.open()
end)
