* {{ sku|RUB|foundation_models.text_embedding.v1|string }} — стоимость обработки 1000 токенов.
* {{ sku|RUB|foundation_models.text_embedding.v1|string }} / 1000 — стоимость обработки 1 токена.

2000 × ({{ sku|RUB|foundation_models.text_embedding.v1|string }} / 1000) = {% calc [currency=RUB] 2000 × {{ sku|RUB|foundation_models.text_embedding.v1|number }} / 1000 %}

Итого: {% calc [currency=RUB] 2000 × {{ sku|RUB|foundation_models.text_embedding.v1|number }} / 1000 %}.