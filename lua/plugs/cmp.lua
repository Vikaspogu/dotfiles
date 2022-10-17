-- nvim-cmp setup
local luasnip = require "luasnip"
local cmp = require 'cmp'
cmp.setup {
  completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
  experimental = { native_menu = false, ghost_text = false },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[Buffer]",
        luasnip = "[Snip]",
        nvim_lua = "[Lua]",
        treesitter = "[Treesitter]",
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_prev_item(),
    ['<C-k>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = "treesitter" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "spell" },
    { name = "emoji" },
    { name = "calc" },
  },
}

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
