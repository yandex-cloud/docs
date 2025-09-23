* Количество токенов в промте и ответе: 1020 + 30 = 1050.
* Цена за 1000 токенов для модели, дообученной в {{ ml-platform-name }}, в синхронном режиме: {% calc [currency=KZT] 6 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %}.
* Количество юнитов в 1 токене для модели, дообученной в {{ ml-platform-name }}, в синхронном режиме: 6.
* Общее количество юнитов в детализации потребления: 1050 × 6 = 6300.

Итого: ({{ sku|KZT|foundation_models.text_generation_alt.v1|string }} / 1000 юнитов) × 6300 юнитов = {% calc [currency=KZT] {{ sku|KZT|foundation_models.text_generation_alt.v1|number }} / 1000 × 6300 %} **или** ({% calc [currency=KZT] 6 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} / 1000 токенов) × 1050 токенов = {% calc [currency=KZT] 6 × {{ sku|KZT|foundation_models.text_generation.v1|number }} / 1000 × 1050 %}.
