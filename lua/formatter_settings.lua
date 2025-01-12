local conform = require("conform")

conform.setup({
	formatters = {
		prettier = {
			prepend_args = {
				"--print-width",
				"79",
			},
		},
		clang_format = {
			prepend_args = { "--style=file", "--fallback-style=LLVM" },
		},
		stylua = {
			prepend_args = {
				"--column-width",
				"79", -- Line width limit
			},
		},
		ruff_format = {
			command = "ruff",
			args = { "format", "--quiet", "-" },
		},
		ruff = {
			command = "ruff",
			args = { "check", "--fix", "--quiet", "-" },
		},
		latexindent = {
			command = "latexindent",
			stdin = true,
			append_args = function()
				return { "-m" }
			end,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "ruff_format", "ruff" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettier", stop_after_first = true },
		tex = { "latexindent" },
		bazel = { "buildifier" },
		bzl = { "buildifier" },
		markdown = { "prettier" },
		json = { "prettier" },
		cmake = { "cmake_format" },
		cpp = { "clang_format" },
		gd = { "gdformat" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
})
vim.keymap.set({ "n", "v" }, "<leader>ft", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
