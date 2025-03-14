| Параметры модели                  | Количество юнитов</br>в 1 токене  | Цена за 1000 токенов,</br>вкл. НДС |
|-----------------------------------|:------------:|-----------------------------------------|
| {{ gpt-lite }}, синхронный режим       | 1       | {{ sku|RUB|foundation_models.text_generation.v1|string }} |
| {{ gpt-lite }}, асинхронный режим      | 0,5     | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} |
| {{ gpt-pro }}, синхронный режим        | 6       | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} |
| {{ gpt-pro }}, асинхронный режим       | 3       | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} |
| Модель, дообученная в {{ ml-platform-name }}, синхронный режим  | 6 | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} |
| Модель, дообученная в {{ ml-platform-name }}, асинхронный режим | 3 | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation.v1|number }}) × 100) / 100 %} |
| {{ llama }} 8b^1^, синхронный режим       | 1       | {{ sku|RUB|foundation_models.text_generation_alt.v1|string }} |
| {{ llama }} 8b, асинхронный режим      | 0,5     | {% calc [currency=RUB] round((0,5 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} |
| {{ llama }} 70b^1^, синхронный режим      | 6       | {% calc [currency=RUB] round((6 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} |
| {{ llama }} 70b, асинхронный режим     | 3       | {% calc [currency=RUB] round((3 × {{ sku|RUB|foundation_models.text_generation_alt.v1|number }}) × 100) / 100 %} |
