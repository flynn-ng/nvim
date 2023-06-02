local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
    'lua_ls'
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    cmd = { 'lua-language-server' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
}

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    -- format on save
    lsp.buffer_autoformat()
end)

lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

lsp.setup()

-- Flutter Tools setup
local dart_lsp = lsp.build_options('dartls', {})

require("flutter-tools").setup({
    decorations = {
        statusline = {
            device = true,
        },
    },
    lsp = {
        capabilities = dart_lsp.capabilities,
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = { "D:\\dev\\flutter", "$HOME/AppData/Local/Pub/Cache" },
            renameFilesWithClasses = "promt",
            enableSnippets = true,
            updateImportsOnRename = true,
        }
    },
    widget_guides = {
        enabled = true,
    },
    closing_tags = {
        highlight = "ErrorMsg",
        prefix = ">> ",
        enabled = true,
    },
})
