Расчет стоимости использования диска:

> 720 × 100 × {{ sku|RUB|compute.filesystem.ssd.v1|string }} = {% calc [currency=RUB] 720 × 100 × {{ sku|RUB|compute.filesystem.ssd.v1|number }} %}

Где:
* 720 — количество часов в 30 днях.
* 100 — объем диска (в ГБ).
* {{ sku|RUB|compute.filesystem.ssd.v1|string }} — стоимость часа использования 1 ГБ диска (в час).
