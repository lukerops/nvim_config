return {
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    after_cursor_filter_length = 20,
    provider = 'openai_fim_compatible',
    provider_options = {
      openai_fim_compatible = {
	model = "qwen2.5-coder:1.5b",
	end_point = "http://localhost:11434/v1/completions",
	name = "Ollama",
	stream = true,
	api_key = 'SHELL',
	optional = {
	  stop = nil,
	  max_tokens = nil,
	}
      }
    }
  },
}
