* Количество токенов в промте и ответе: 115 + 1500 = 1615.
* Цена за 1000 токенов для модели {{ gpt-pro }} в асинхронном режиме: {% calc [currency=KZT] 3 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %}.
* Количество юнитов в 1 токене для модели {{ gpt-pro }} в асинхронном режиме: 3.
* Общее количество юнитов в детализации потребления: 1615 × 3 = 4845.

Итого: ({% calc [currency=KZT] 3 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} / 1000 токенов) × 1615 токенов = {% calc [currency=KZT] 3 × {{ sku|KZT|foundation_models.text_generation.v1|number }} / 1000 × 1615 %}, округляя до целого значения, {% calc [currency=KZT] round(3 × {{ sku|KZT|foundation_models.text_generation.v1|number }} / 1000 × 1615 × 100) / 100 %}.