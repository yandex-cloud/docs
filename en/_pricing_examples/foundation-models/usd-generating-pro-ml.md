The cost is calculated as follows:

* Number of prompt and response tokens: 1,020 + 30 = 1,050
* Price per 1,000 tokens for the model fine-tuned in {{ ml-platform-name }}, synchronous mode: {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation.v1|number }} %}
* Number of units per token for the model fine-tuned in {{ ml-platform-name }}, synchronous mode: 6
* Total number of units in usage details: 1,050 × 6 = 6,300

Total: ({{ sku|USD|foundation_models.text_generation_alt.v1|string }} / 1,000 units) × 6,300 units = {% calc [currency=USD] {{ sku|USD|foundation_models.text_generation_alt.v1|number }} / 1000 × 6300 %} **or** ({% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} / 1,000 tokens) × 1,050 tokens = {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 1050 %}.
