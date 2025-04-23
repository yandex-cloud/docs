* Количество токенов в промте и ответе: 225 + 525 = 750.
* Количество юнитов в 1 токене для модели {{ gpt-lite }} в синхронном режиме: 1.
* Общее количество юнитов в детализации потребления: 750.

({{ sku|KZT|foundation_models.text_generation.v1|string }} / 1000 юнитов) × 750 юнитов = {% calc [currency=KZT] ({{ sku|KZT|foundation_models.text_generation.v1|number }} / 1000) × 750 %}