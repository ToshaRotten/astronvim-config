-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

	"andweeb/presence.nvim",
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},

	-- == Examples of Overriding Plugins ==

	-- customize alpha options
	{
		"goolord/alpha-nvim",
		opts = function(_, opts)
			-- customize the dashboard header
			-- opts.section.header.val = {
			--   " █████  ███████ ████████ ██████   ██████",
			--   "██   ██ ██         ██    ██   ██ ██    ██",
			--   "███████ ███████    ██    ██████  ██    ██",
			--   "██   ██      ██    ██    ██   ██ ██    ██",
			--   "██   ██ ███████    ██    ██   ██  ██████",
			--   " ",
			--   "    ███    ██ ██    ██ ██ ███    ███",
			--   "    ████   ██ ██    ██ ██ ████  ████",
			--   "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
			--   "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
			--   "    ██   ████   ████   ██ ██      ██",
			-- }
			opts.section.header.val = {
				"@@@@@@@    @@@@@@   @@@@@@@  @@@@@@@  @@@@@@@@  @@@  @@@  ",
				"@@@@@@@@  @@@@@@@@  @@@@@@@  @@@@@@@  @@@@@@@@  @@@@ @@@  ",
				"@@!  @@@  @@!  @@@    @@!      @@!    @@!       @@!@!@@@  ",
				"!@!  @!@  !@!  @!@    !@!      !@!    !@!       !@!!@!@!  ",
				"@!@!!@!   @!@  !@!    @!!      @!!    @!!!:!    @!@ !!@!  ",
				"!!@!@!    !@!  !!!    !!!      !!!    !!!!!:    !@!  !!!  ",
				"!!: :!!   !!:  !!!    !!:      !!:    !!:       !!:  !!!  ",
				":!:  !:!  :!:  !:!    :!:      :!:    :!:       :!:  !:!  ",
				"::   :::  ::::: ::     ::       ::     :: ::::   ::   ::  ",
				" :   : :   : :  :      :        :     : :: ::   ::    :   ",
			}

			return opts
		end,
	},

	-- You can disable default plugins as follows:
	{ "max397574/better-escape.nvim", enabled = false },

	-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
	{
		"L3MON4D3/LuaSnip",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom luasnip configuration such as filetype extend or custom snippets
			local luasnip = require("luasnip")
			luasnip.filetype_extend("javascript", { "javascriptreact" })
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.nvim-autopairs")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom autopairs configuration such as custom rules
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			npairs.add_rules(
				{
					Rule("$", "$", { "tex", "latex" })
					-- don't add a pair if the next character is %
							:with_pair(cond.not_after_regex("%%"))
					-- don't add a pair if  the previous character is xxx
							:with_pair(
								cond.not_before_regex("xxx", 3)
							)
					-- don't move right when repeat character
							:with_move(cond.none())
					-- don't delete if the next character is xx
							:with_del(cond.not_after_regex("xx"))
					-- disable adding a newline when you press <cr>
							:with_cr(cond.none()),
				},
				-- disable for .vim files, but it work for another filetypes
				Rule("a", "a", "-vim")
			)
		end,
	},

	require("tabnine").setup({
		disable_auto_comment = true,                         -- Отключает автоматические комментарии от Tabnine
		accept_keymap = "<Tab>",                             -- Клавиша для принятия предложения (по умолчанию <Tab>)
		dismiss_keymap = "<C-]>",                            -- Клавиша для отклонения предложения
		debounce_ms = 800,                                   -- Задержка перед показом предложений
		suggestion_color = { gui = "#808080", cterm = 244 }, -- Цвет предложений
		exclude_filetypes = { "TelescopePrompt", "NvimTree" }, -- Исключить типы файлов
		log_file_path = nil,                                 -- Абсолютный путь к файлу логов Tabnine
	}),

	-- Добавляем LSP-сервер для Go (gopls) в mason-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"gopls",
			},
		},
	},

	-- Настройка gopls для увеличения ширины строк
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							formatting = {
								gofumpt = false,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		opts = {
			shell = "kitty",
			size = 20,
			direction = "float",
			close_on_exit = true,
			start_in_insert = true,
			float_opts = {
				border = "single",
				width = 120,
				height = 30,
			},
		},
	},

	-- Добавляем отладчик Delve (go) в mason-nvim-dap
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {
				"go", -- Это установит Delve
			},
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- Установите в false, чтобы показывать скрытые файлы
					hide_git_ignored = true,
					hide_hidden = true,
				},
			},
		},
	},
}
