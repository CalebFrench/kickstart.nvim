-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
          openai_fim_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'OPENWEBUI_API_KEY',
            name = 'Ollama',
            end_point = 'https://ai.external.calebmfrench.com/ollama/api/generate',
            model = 'qwen2.5-coder:1.5b',
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
        },
      }
      require('blink-cmp').setup {
        keymap = {
          -- Manually invoke minuet completion.
          ['<A-y>'] = require('minuet').make_blink_map(),
        },
        sources = {
          -- Enable minuet for autocomplete
          default = { 'lsp', 'path', 'buffer', 'snippets', 'minuet' },
          -- For manual completion only, remove 'minuet' from default
          providers = {
            minuet = {
              name = 'minuet',
              module = 'minuet.blink',
              async = true,
              -- Should match minuet.config.request_timeout * 1000,
              -- since minuet.config.request_timeout is in seconds
              timeout_ms = 3000,
              score_offset = 50, -- Gives minuet higher priority among suggestions
            },
          },
        },
        -- Recommended to avoid unnecessary request
        completion = { trigger = { prefetch_on_insert = false } },
      }
    end,
  },
  { 'nvim-lua/plenary.nvim' },
}
