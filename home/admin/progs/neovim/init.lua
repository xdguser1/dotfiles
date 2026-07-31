-----------------------
--  Global arguments  --
------------------------
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.hlsearch       = true
vim.opt.cursorline     = true

vim.opt.list      = true
vim.opt.listchars = {
    space = '∙',
    tab   = '~~'
}

vim.opt.expandtab   = true
vim.opt.foldmethod  = 'indent'
vim.opt.shiftwidth  = 4
vim.opt.smarttab    = true
vim.opt.softtabstop = 0
vim.opt.tabstop     = 8
vim.opt.mouse       = ''


--------------
--  Keymap  --
--------------
-- Special functions
function makeEmptyGenerator(relative)
    return (function ()
        local index = vim.fn.line('.') + relative
        vim.api.nvim_buf_set_lines(0, index, index, false, {''})
    end)
end

-- Function keymaps
vim.keymap.set('n', '<space>', makeEmptyGenerator(-1))
vim.keymap.set('n', '<enter>', makeEmptyGenerator(0))

-- Arrows
vim.keymap.set('', '<up>',    'k', { remap = true; })
vim.keymap.set('', '<down>',  'j', { remap = true; })
vim.keymap.set('', '<left>',  'h', { remap = true; })
vim.keymap.set('', '<right>', 'l', { remap = true; })

vim.keymap.set('', '<C-up>',    '<C-W>k', { remap = true; })
vim.keymap.set('', '<C-down>',  '<C-W>j', { remap = true; })
vim.keymap.set('', '<C-left>',  '<C-W>h', { remap = true; })
vim.keymap.set('', '<C-right>', '<C-W>l', { remap = true; })

vim.keymap.set('', '<S-A-up>',    '<C-W>K', { remap = true; })
vim.keymap.set('', '<S-A-down>',  '<C-W>J', { remap = true; })
vim.keymap.set('', '<S-A-left>',  '<C-W>H', { remap = true; })
vim.keymap.set('', '<S-A-right>', '<C-W>L', { remap = true; })

---------------------
--  Coc extension  --
---------------------
-- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua
vim.opt.backup      = false
vim.opt.writebackup = false
vim.opt.updatetime  = 1000
vim.opt.signcolumn  = 'yes'

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = {
    silent           = true,
    noremap          = true,
    expr             = true,
    replace_keycodes = false
}
vim.keymap.set('i', '<TAB>',   'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set('i', '<S-TAB>', 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', opts)

vim.keymap.set('i', '<c-j>',     '<Plug>(coc-snippets-expand-jump)')
vim.keymap.set('i', '<c-space>', 'coc#pum#visible() ? coc#pum#confirm() : coc#refresh()', { silent = true, expr = true })

vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

vim.keymap.set('n', 'gd', '<Plug>(coc-definition)',      { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)',  { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)',      { silent = true })

for c in string.gmatch('ivn', '.') do
    vim.keymap.set(c, "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, nowait = true, expr = true })
    vim.keymap.set(c, "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-f>"', { silent = true, nowait = true, expr = true })
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
local opts_coc = {silent = true, nowait = true, expr = true}
vim.keymap.set('n', 'K', '<CMD>lua _G.show_docs()<CR>', { silent = true })

vim.api.nvim_create_augroup('CocGroup', {})
vim.api.nvim_create_autocmd('CursorHold', {
    group = 'CocGroup',
    command = 'silent call CocActionAsync("highlight")',
    desc = 'Highlight symbol under cursor on CursorHold'
})

vim.keymap.set('n', 'grn', '<Plug>(coc-rename)',           { silent = true })
vim.keymap.set('x', 'gf',  '<Plug>(coc-format-selected)',  { silent = true })
vim.keymap.set('',  'gz',  '<Cmd>CocCommand explorer<CR>', { silent = true })

----------------
--  Gitsigns  --
----------------
require('gitsigns').setup({
    signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true
    },
    auto_attach             = true,
    attach_to_untracked     = false,
    current_line_blame      = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text           = true,
        virt_text_pos       = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay               = 1000,
        ignore_whitespace   = false,
        virt_text_priority  = 100,
        use_focus           = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',

    sign_priority    = 6,
    update_debounce  = 100,
    status_formatter = nil,   -- Use default
    max_file_length  = 40000, -- Disable if file is longer than this (in lines)
    preview_config   = {
        -- Options passed to nvim_open_win
        style    = 'minimal',
        relative = 'cursor',
        row      = 0,
        col      = 1
    },
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts        = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', 'ghs', gitsigns.stage_hunk)
        map('n', 'ghr', gitsigns.reset_hunk)

        map('v', 'ghs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('v', 'ghr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('n', 'ghS', gitsigns.stage_buffer)
        map('n', 'ghR', gitsigns.reset_buffer)
        map('n', 'ghp', gitsigns.preview_hunk)
        map('n', 'ghi', gitsigns.preview_hunk_inline)

        map('n', 'ghb', function()
            gitsigns.blame()
        end)

        map('n', 'ghd', gitsigns.diffthis)

        map('n', 'ghD', function()
            gitsigns.diffthis('~')
        end)

        map('n', 'ghQ', function() gitsigns.setqflist('all') end)
        map('n', 'ghq', gitsigns.setqflist)

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
    end
})

-------------
--  Marks  --
-------------
require('marks').setup({
    default_mappings   = true,
    builtin_marks      = { '.', '<', '>', '^' },
    cyclic             = true,
    force_write_shada  = false,
    refresh_interval   = 250,
    sign_priority      = {
        lower    = 10,
        upper    = 15,
        builtin  = 8,
        bookmark = 20
    },
})

-------------
--  Tabby  --
-------------
local theme = {
    fill        = 'TabLineFill',
    head        = 'TabLine',
    current_tab = 'TabLineSel',
    tab         = 'TabLine',
    win         = 'TabLine',
    tail        = 'TabLine',
}
require('tabby').setup({
    line = function(line)
        return {
            {
                { '  ', hl = theme.head },
                line.sep('', theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
                local hl = tab.is_current() and theme.current_tab or theme.tab
                return {
                    line.sep('', hl, theme.fill),
                    tab.is_current() and '' or '',
                    tab.name(),
                    tab.number(),
                    line.sep('', hl, theme.fill),
                    hl     = hl,
                    margin = ' '
                }
            end),
            line.spacer(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                return {
                    line.sep('', theme.win, theme.fill),
                    win.is_current() and '' or '',
                    win.buf_name(),
                    line.sep('', theme.win, theme.fill),
                    hl     = theme.win,
                    margin = ' '
                }
            end),
            {
                line.sep('', theme.tail, theme.fill),
                { '  ', hl = theme.tail },
            },
            hl = theme.fill,
        }
    end,
})

------------------
--  Illuminate  --
------------------
-- default configuration
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'treesitter',
        'lsp',
        'regex',
    },
    delay = 100,
    filetype_overrides = {},
    filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
    },
    filetypes_allowlist              = {},
    modes_denylist                   = {},
    modes_allowlist                  = {},
    providers_regex_syntax_denylist  = {},
    providers_regex_syntax_allowlist = {},
    under_cursor                     = true,
    large_file_cutoff                = 10000,
    large_file_overrides             = nil,
    min_count_to_highlight           = 1,
    should_enable                    = function(bufnr) return true end,
    case_insensitive_regex           = false,
    disable_keymaps                  = false,
})

---------------
--  Lualine  --
---------------
require('lualine').setup({
    options = {
        icons_enabled = true,
        theme         = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar     = {},
        },

        ignore_focus         = {},
        always_divide_middle = true,
        always_show_tabline  = true,
        globalstatus         = true,

        refresh = {
            statusline   = 1000,
            tabline      = 1000,
            winbar       = 1000,
            refresh_time = 16, -- ~60fps
            events       = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },
    sections = {
        lualine_a = {'mode', 'lsp_status'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

---------------
--Treesitter --
---------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

------------------------
--  Other extensions  --
------------------------
-- Colorscheme
vim.cmd[[colorscheme tokyonight-storm]]

-- Diffview
vim.keymap.set('n', 'gD', '<Cmd>DiffviewOpen<CR>')

-- CCC
require('ccc').setup({
    highlighter = {
        auto_enable = true,
        lsp = true,
    },
})

-- Range hightlight
require('range-highlight').setup({ 
    highlight = {
        group = 'Visual',
        priority = 10,
        -- if you want to highlight empty line, set it to true
        to_eol = false,
    },
    -- disable range highlight, if the cmd is matched here. Value here does not accept shorthand
    excluded = { cmd = { 'substitute' } },
    debounce = {
        -- how long to debounce, set to 0 to disable
        wait = 100,
    },
})

-- Surround nvim
require('nvim-surround').setup()

-- EasyAlign
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

-- Undo glow
require('highlight-undo').setup()

-- Matchup
require('match-up').setup({
    treesitter = {
        stopline = 500
    }
})

-- Hop
local hop = require('hop')
local directions = require('hop.hint').HintDirection
hop.setup()
vim.keymap.set('', 'f', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap=true })
vim.keymap.set('', 'F', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap=true })
vim.keymap.set('', 't', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap=true })
vim.keymap.set('', 'T', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap=true })
vim.keymap.set({ 'n', 'x', 'o'}, '-', '<Cmd>HopWord<CR>')

-- Undotree
vim.keymap.set('n', 'gl', vim.cmd.UndotreeToggle)
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffAutoOpen = false

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', 'gbf', telescope.find_files)
vim.keymap.set('n', 'gbr', telescope.live_grep)
vim.keymap.set('n', 'gbb', telescope.buffers)
