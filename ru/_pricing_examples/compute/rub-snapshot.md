> 1440 × 20 × {{ sku|RUB|compute.snapshot|string }} = {% calc [currency=RUB] 1440 × 20 × {{ sku|RUB|compute.snapshot|number }} %}
>
> Итого: {% calc [currency=RUB] 1440 × 20 × {{ sku|RUB|compute.snapshot|number }} %} — стоимость хранения снимка объемом 20 ГБ в течение 60 дней.

Где:
* 1440 — количество часов в 60 днях.
* 20 — объем снимка (в ГБ).
* {{ sku|RUB|compute.snapshot|string }} — стоимость хранения 1 ГБ снимка в час.
