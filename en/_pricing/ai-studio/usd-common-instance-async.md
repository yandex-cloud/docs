#|
|| **Model** | **Price per 1,000 input tokens,</br>without VAT** | **Price per 1,000 output tokens,</br>without VAT** ||
|| Alice AI LLM | {% calc [currency=USD] 1,25 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} | {% calc [currency=USD] 5 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} ||
|| {{ gpt-pro }} 5.1 | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} + 0,000027 %} | {% calc [currency=USD] 2 × {{ sku|USD|foundation_models.text_generation.v1|number }} + 0,000027 %} ||
|| {{ gpt-pro }} 5 | {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} | {% calc [currency=USD] 3 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} ||
|| {{ gpt-lite }} | {% calc [currency=USD] 0,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} | {% calc [currency=USD] 0,5 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} ||
|#
