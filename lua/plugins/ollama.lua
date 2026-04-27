return {
	"nomnivore/ollama.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	-- All the user commands added by the plugin
	cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

	keys = {
		-- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
		{
			"<leader>oo",
			":<c-u>lua require('ollama').prompt()<cr>",
			desc = "ollama prompt",
			mode = { "n", "v" },
		},

		{
			"<leader>ai",
			":<c-u>lua require('ollama').prompt()<cr>",
			desc = "ollama prompt",
			mode = { "n", "v" },
		},

		-- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
		{
			"<leader>oG",
			":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
			desc = "ollama Generate Code",
			mode = { "n", "v" },
		},
	},

	---@type Ollama.Config
	opts = {
		model = "gemma2:9b-instruct-q4_K_M",
		url = "http://127.0.0.1:11434",

		use_visual_selection = true,
		input_label = "> ",

		options = {
			num_gpu = 35,
			num_ctx = 32768,
			num_predict = 2048,
			temperature = 0.2,
			top_k = 40,
			top_p = 0.9,
			repeat_penalty = 1.1,
		},
		prompts = {
			Ask_About_Code_Russian = {
				prompt = "У меня есть следующий вопрос: $input\n\n про этот фрагмент кода:\n```$ftype\n$sel```",
				input_label = "Q",
			},
			Explain_Code_Russian = {
				prompt = "Объясни следующий код: \n```$ftype\n$sel\n```",
				input_label = "> ",
				model = "gemma2:9b-instruct-q4_K_M",
				action = "display",
			},
			Improve_Code_Russian = {
				prompt = "Предложи, как улучшить следующий код: \n```$ftype\n$sel\n```",
				input_label = "> ",
				model = "gemma2:9b-instruct-q4_K_M",
				action = "display",
			},
			Simplify_Code_Russian = {
				prompt = "Упрости код на языке: $ftype чтобы его можно было проще понимать и читать "
						.. "Ответ ТОЛЬКО в таком формате:\n```$ftype\n<твой код>\n```"
						.. "\n\n```$ftype\n$sel```",
				action = "replace",
			},
			Generate_Code_Russian = {
				prompt = "Сгенерируй код на языке $ftype который выполняет следующее: $input\n\n"
						.. "Ответ ТОЛЬКО в таком формате:\n```$ftype\n<твой код>\n```",
				action = "insert",
			},
		},
	},
}
