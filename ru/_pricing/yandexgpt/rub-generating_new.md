#|
|| **Модель** | **Цена за 1000 токенов в синхронном режиме,</br>вкл. НДС** | **Цена за 1000 токенов в асинхронном режиме,</br>вкл. НДС** ||
|| {{ gpt-lite }} | {{ sku|RUB|foundation_models.text_generation.v1|string }} | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| Модель, дообученная в {{ ml-platform-name }} | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} |  {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ llama }} 8B | {{ sku|RUB|foundation_models.text_generation_alt.v1|string }} | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ||
|| {{ llama }} 70B | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} ||
|#