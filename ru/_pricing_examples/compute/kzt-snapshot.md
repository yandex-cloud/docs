> 1440 × 20 × {{ sku|KZT|compute.snapshot|string }} = {% calc [currency=KZT] 1440 × 20 × {{ sku|KZT|compute.snapshot|number }} %}
>
> Итого: {% calc [currency=KZT] 1440 × 20 × {{ sku|KZT|compute.snapshot|number }} %} — стоимость хранения снимка объемом 20 ГБ в течение 60 дней.

Где:
* 1440 — количество часов в 60 днях.
* 20 — объем снимка (в ГБ).
* {{ sku|KZT|compute.snapshot|string }} — стоимость хранения 1 ГБ снимка в час.
