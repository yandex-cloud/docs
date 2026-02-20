#|
|| **Модель** | **Цена за 1000 входящих токенов,</br>вкл. НДС** | **Цена за 1000 исходящих токенов,</br>вкл. НДС** ||
|| Alice AI LLM      | {% calc [currency=RUB] round((1,25 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((5 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5.1 | {% calc [currency=RUB] round((2 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((2 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5   | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-lite }}    | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|#
