#|
|| | **Alice AI LLM** | **{{ gpt-pro }} 5.1** | **Qwen3 235B** ||
|| Tokens per request | 164 | 164 | 248 ||
|| Tokens per response | 22 | 22 | 39 ||
|| Request cost | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 164 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 164 %} | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 248 %} ||
|| Response cost | {% calc [currency=USD] 10 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 22 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 22 %} | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 39 %} ||
|| Total | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 164 + 10 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 22 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 186 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 119 %} | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 287 %} ||
|#