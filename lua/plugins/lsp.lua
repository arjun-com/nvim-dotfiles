local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

  	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  	nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')

  -- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		if vim.lsp.buf.format then
      		vim.lsp.buf.format()
    	elseif vim.lsp.buf.formatting then
      		vim.lsp.buf.formatting()
    	end
  	end, { desc = 'Format current buffer with LSP' })
end

local servers = {
	"tsserver",
	"tailwindcss",
	"html",
	"lua_ls",
	"gopls",
	"pyright",
	"rust_analyzer"
}

local caps = vim.lsp.protocol.make_client_capabilities()
for _, lsp in ipairs(servers) do
  	require('lspconfig')[lsp].setup {
    	on_attach = on_attach,
    	capabilities = caps,
  	}
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
	view = {
		entries = "native"
  	},
  	snippet = {
    	expand = function(args)
      		luasnip.lsp_expand(args.body)
    	end,
  	},
  	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
    	},
    	['<Tab>'] = cmp.mapping(function(fallback)
      		if cmp.visible() then
        		cmp.select_next_item()
      		elseif luasnip.expand_or_jumpable() then
        		luasnip.expand_or_jump()
      		else
        		fallback()
      		end
    	end, { 'i', 's' }),
    	['<S-Tab>'] = cmp.mapping(function(fallback)
      		if cmp.visible() then
        		cmp.select_prev_item()
      		elseif luasnip.jumpable(-1) then
        		luasnip.jump(-1)
      		else
        		fallback()
      		end
    	end, { 'i', 's' }),
  	},
  	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = "neorg" },
  	},
}
