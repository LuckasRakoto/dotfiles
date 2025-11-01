return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "VonHeikemen/lsp-zero.nvim",
  },
  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})
    require("mason").setup()
    local lsp_zero = require("lsp-zero")
    lsp_zero.format_on_save({
        format_opts = {
            async = false,
            timeout_ms = 10000,
        },
        servers = {
            ['clangd'] = { 'c', 'cpp' },
            ['gopls'] = { 'go' },
        }
    })

    require('mason-lspconfig').setup({
      ensure_installed = {
          "ts_ls",
          "lua_ls",
          "jedi_language_server",
          "gopls",
          "rust_analyzer",
          "glsl_analyzer",
          "clangd",
          "cmake",
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
          })
        end,
        lua_ls = function()
          require('lspconfig').lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT'
                },
                diagnostics = {
                  globals = { 'vim', 'love' },
                },
                workspace = {
                  library = {
                    vim.env.VIMRUNTIME,
                  }
                },
              }
            }
          })
        end,
        clangd = function()
            require('lspconfig').clangd.setup({
                capabilities = capabilities,
                cmd={
                    "clangd",
                    "--fallback-style=none",
                }
            })
        end
      }
    })

    local cmp = require('cmp')
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    require('luasnip.loaders.from_vscode').lazy_load({paths = {"./snippets/"}})

    cmp.setup({
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })
  end
}
