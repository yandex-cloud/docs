#|
|| **Модель** | **Цена за 1000 токенов в синхронном режиме,</br>вкл. НДС** | **Цена за 1000 токенов в асинхронном режиме,</br>вкл. НДС** ||
|| {{ gpt-lite }} | {{ sku|RUB|foundation_models.text_generation.v1|string }} | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5 или младше | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5.1 | {% calc [currency=RUB] round((2 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ^1^ | {% calc [currency=RUB] round((1 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ^1^ ||
|| {{ llama }} 8B | {{ sku|RUB|foundation_models.text_generation_alt.v1|string }} | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ||
|| {{ llama }} 70B | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ||
|| Qwen3 235B | {% calc [currency=RUB] round((2,5 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ^1^ | — ||
|| gpt-oss-120b | {% calc [currency=RUB] round((1,5 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} | — || 
|| gpt-oss-20b | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} | — || 
|#

^1^ Цена указана с учетом действующей скидки 50%. 