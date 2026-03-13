* Number of prompt and response tokens: 115 + 1,500 = 1,615.
* Price per 1,000 tokens for the {{ gpt-pro }} 5 model, asynchronous mode: {{ sku|USD|aistudio.text_generation.input_tokens.async.yandexgpt-5-pro|number }}.
* Number of units per token for the {{ gpt-pro }} 5 model, asynchronous mode: 3.
* Total number of units in usage details: 1,615 × 3 = 4,845.

Total: ({{ sku|USD|aistudio.text_generation.input_tokens.async.yandexgpt-5-pro|number }} / 1,000 tokens) × 1,615 tokens = {% calc [currency=USD] {{ sku|USD|aistudio.text_generation.input_tokens.async.yandexgpt-5-pro|number }} / 1000 × 1615 %}.