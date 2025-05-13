* {{ sku|USD|foundation_models.text_embedding.v1|string }}: Cost of processing per 1,000 tokens.
* {{ sku|USD|foundation_models.text_embedding.v1|string }} / 1,000: Cost of processing per one token.

2,000 × ({{ sku|USD|foundation_models.text_embedding.v1|string }} / 1,000) = {% calc [currency=USD] 2000 × {{ sku|USD|foundation_models.text_embedding.v1|number }} / 1000 %}

Total: {% calc [currency=USD] 2000 × {{ sku|USD|foundation_models.text_embedding.v1|number }} / 1000 %}.