#|
|| | **Alice AI LLM** | **{{ gpt-pro }} 5.1** | **Qwen3 235B** ||
|| Tokens per request | 82 | 82 | 116 ||
|| Tokens per response | 37 | 37 | 60 ||
|| Request cost | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 82 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 82 %} | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 116 %} ||
|| Response cost | {% calc [currency=USD] 10 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 37 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 37 %} | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 60 %} ||
|| Total | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 82 + 10 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 37 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 37 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 119 %} | {% calc [currency=USD] 2,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} / 1000 × 176 %} ||
|#