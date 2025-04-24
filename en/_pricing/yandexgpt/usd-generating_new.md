#|
|| **Model** | **Cost per 1,000 tokens, synchronous mode,</br>without VAT** | **Cost per 1,000 tokens, asynchronous mode,</br>without VAT** ||
|| {{ gpt-lite }} | {{ sku|USD|foundation_models.text_generation.v1|string }} | {% calc [currency=USD] 0,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} ||
|| {{ gpt-pro }} | {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} | {% calc [currency=USD] round((3 × {{ sku|USD|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| Model fine-tuned in {{ ml-platform-name }} | {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} |  {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} ||
|| {{ llama }} 8B | {{ sku|USD|foundation_models.text_generation_alt.v1|string }} | {% calc [currency=USD] 0,5 × {{ sku|USD|foundation_models.text_generation_alt.v1|number }} %} ||
|| {{ llama }} 70B | {% calc [currency=USD] 6 × {{ sku|USD|foundation_models.text_generation_alt.v1|number }} %} | {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation_alt.v1|number }} %} ||
|#