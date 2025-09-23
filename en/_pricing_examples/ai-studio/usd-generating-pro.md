The cost is calculated as follows:

* Number of prompt and response tokens: 115 + 1,500 = 1,615.
* Price per 1,000 tokens for the {{ gpt-pro }} model, asynchronous mode: {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} %}.
* Number of units per token for the {{ gpt-pro }} model, asynchronous mode: 3.
* Total number of units in usage details: 1,615 × 3 = 4,845.

Total: ({% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} / 1,000 tokens) × 1,615 tokens = {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 1615 %}.