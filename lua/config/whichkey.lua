local M = {}

local whichkey = require "which-key"
local legendary = require "legendary"
local next = next

local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap_f = nil -- File search
  local keymap_p = nil -- Project search

  keymap_f = {
    name = "Find",
    f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
    d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
    b = { "cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
    m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
    o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
    g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
    c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
    w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  }

  keymap_p = {
    name = "Project",
    p = { "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>", "List" },
    s = { "<cmd>lua require'telescope'.extensions.repo.list{}<cr>", "Search" },
  }

  local keymap = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
    -- ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },

    a = {
      name = "Attempt",
      n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
      i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
      r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
      d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
      c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
      s = { "<Cmd>Telescope attempt<Cr>", "Search" },
    },

    b = {
      name = "Buffer",
      c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
      f = { "<Cmd>BDelete! this<Cr>", "Force Close Buffer" },
      D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
      b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
      p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
      m = { "<Cmd>JABSOpen<Cr>", "Menu" },
    },

	f = keymap_f,
    p = keymap_p,

    j = {
      name = "Jump",
      a = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add File" },
      m = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "UI Menu" },
      c = { "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", "Command Menu" },
    },
    ["0"] = { "<Cmd>2ToggleTerm<Cr>", "ToggleTerm 2" },
    ["1"] = { "<Cmd>lua require('harpoon.ui').nav_file(1) <Cr>", "File 1" },
    ["2"] = { "<Cmd>lua require('harpoon.ui').nav_file(2) <Cr>", "File 2" },
    ["3"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(1)<Cr>", "Terminal 1" },
    ["4"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(2)<Cr>", "Terminal 2" },
    ["5"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,1)<Cr>", "Command 1" },
    ["6"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,2)<Cr>", "Command 2" },

    r = {
      name = "Refactor",
      i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
      b = { [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]], "Extract Block" },
      B = { [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]], "Extract Block to File" },
      P = {
        [[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
        "Debug Print",
      },
      p = {
        [[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
        "Debug Print Variable",
      },
      c = { [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]], "Debug Cleanup" },
    },

    s = {
      name = "Search",
      w = { [[ <Esc><Cmd>lua require("telescope").extensions.arecibo.websearch()<CR>]], "Web" },
    },

    v = {
      name = "Vimspector",
      G = { "<cmd>lua require('config.vimspector').generate_debug_profile()<cr>", "Generate Debug Profile" },
      I = { "<cmd>VimspectorInstall<cr>", "Install" },
      U = { "<cmd>VimspectorUpdate<cr>", "Update" },
      R = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to Cursor" },
      c = { "<cmd>call vimspector#Continue()<cr>", "Continue" },
      i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
      o = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
      s = { "<cmd>call vimspector#Launch()<cr>", "Start" },
      t = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
      u = { "<cmd>call vimspector#StepOut()<cr>", "Step Out" },
      S = { "<cmd>call vimspector#Stop()<cr>", "Stop" },
      r = { "<cmd>call vimspector#Restart()<cr>", "Restart" },
      x = { "<cmd>VimspectorReset<cr>", "Reset" },
      H = { "<cmd>lua require('config.vimspector').toggle_human_mode()<cr>", "Toggle HUMAN mode" },
    },

    x = {
      name = "External",
      d = { "<cmd>lua require('utils.term').docker_client_toggle()<CR>", "Docker" },
      p = { "<cmd>lua require('utils.term').project_info_toggle()<CR>", "Project Info" },
      s = { "<cmd>lua require('utils.term').system_info_toggle()<CR>", "System Info" },
      c = { "<cmd>lua require('utils.term').cht()<CR>", "Cheatsheet" },
      i = { "<cmd>lua require('utils.term').interactive_cheatsheet_toggle()<CR>", "Interactive Cheatsheet" },
    },

    z = { 
      name = "System",
      -- c = { "<cmd>PackerCompile<cr>", "Compile" },
      c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      -- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
      -- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
      x = { "<cmd>Telescope cder<cr>", "Change Directory" },
      e = { "!!$SHELL<CR>", "Execute line" },
      W = { "<cmd>lua require('utils.session').toggle_session()<cr>", "Toggle Workspace Saving" },
      w = { "<cmd>lua require('utils.session').list_session()<cr>", "Restore Workspace" },
      z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
    },

    g = {
      name = "Git",
      b = { "<cmd>GitBlameToggle<CR>", "Blame" },
      c = { "<cmd>lua require('utils.term').git_commit_toggle()<CR>", "Conventional Commits" },
      p = { "<cmd>Git push<CR>", "Push" },
      s = { "<cmd>Neogit<CR>", "Status - Neogit" },
      S = { "<cmd>Git<CR>", "Status - Fugitive" },
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
      g = { "<cmd>lua require('telescope').extensions.gh.gist()<CR>", "Gist" },
      z = { "<cmd>lua require('utils.term').git_client_toggle()<CR>", "Git TUI" },
      h = { name = "Hunk" },
      t = { name = "Toggle" },
      x = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Switch Branch" },
    },
  }
  whichkey.register(keymap, opts)
  legendary.bind_whichkey(keymap, opts, false)
end

local function visual_keymap()
  local keymap = {
    g = {
      name = "Git",
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
    },

    r = {
      name = "Refactor",
      f = { [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract Function" },
      F = {
        [[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
        "Extract Function to File",
      },
      v = { [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract Variable" },
      i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
      r = { [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]], "Refactor" },
      d = { [[<cmd>lua require('refactoring').debug.print_var({})<cr>]], "Debug Print Var" },
    },
  }

  whichkey.register(keymap, v_opts)
  legendary.bind_whichkey(keymap, v_opts, false)
end

local function code_keymap()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      vim.schedule(CodeRunner)
    end,
  })

  function CodeRunner()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local fname = vim.fn.expand "%:p:t"
    local keymap_c = {} -- normal key map
    local keymap_c_v = {} -- visual key map

    if ft == "python" then
      keymap_c = {
        name = "Code",
        -- r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
        -- r = { "<cmd>update<CR><cmd>TermExec cmd='python3 %'<cr>", "Run" },
        i = { "<cmd>cexpr system('refurb --quiet ' . shellescape(expand('%'))) | copen<cr>", "Inspect" },
        r = {
          "<cmd>update<cr><cmd>lua require('utils.term').open_term([[python3 ]] .. vim.fn.shellescape(vim.fn.getreg('%'), 1), {direction = 'float'})<cr>",
          "Run",
        },
        m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
      }
    elseif ft == "lua" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>luafile %<cr>", "Run" },
      }
    elseif ft == "go" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>GoRun<cr>", "Run" },
      }
    elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
        r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
        i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
        F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
        u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
        R = { "<cmd>lua require('config.neotest').javascript_runner()<cr>", "Choose Test Runner" },
        -- s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
        -- t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
      }
    elseif ft == "java" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
        v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
        t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
        n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
      }
      keymap_c_v = {
        name = "Code",
        v = { "<cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
        m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
      }
    end

    if fname == "package.json" then
      keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
      keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
      -- keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
      -- keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
    end

    if fname == "Cargo.toml" then
      keymap_c.u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" }
    end

    if next(keymap_c) ~= nil then
      local k = { c = keymap_c }
      local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      whichkey.register(k, o)
      legendary.bind_whichkey(k, o, false)
    end

    if next(keymap_c_v) ~= nil then
      local k = { c = keymap_c_v }
      local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      whichkey.register(k, o)
      legendary.bind_whichkey(k, o, false)
    end
  end
end

function M.setup()
  normal_keymap()
  visual_keymap()
  code_keymap()
end

return M
