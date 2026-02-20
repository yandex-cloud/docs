#|
|| **Модель** | **Цена за 1000 входящих токенов,</br>вкл. НДС** | **Цена за 1000 исходящих токенов,</br>вкл. НДС** ||
|| Alice AI LLM      | {% calc [currency=KZT] round((1,25 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=KZT] round((5 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5.1 | {% calc [currency=KZT] round((2 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=KZT] round((2 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-pro }} 5   | {% calc [currency=KZT] round((3 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=KZT] round((3 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|| {{ gpt-lite }}    | {% calc [currency=KZT] round((0,5 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} | {% calc [currency=KZT] round((0,5 × {{ sku|KZT|foundation_models.text_generation.v1|number }}) × 100) / 100 %} ||
|#
