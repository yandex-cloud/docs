> 3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|string }} = {% calc [currency=KZT] 3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|number }} %}
> 20 000 / 10 000 × {{ sku|KZT|lockbox.api.v1.get|string }} = {% calc [currency=KZT] 20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }} %}

> Итого: {% calc [currency=KZT] 3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|number }} %} + {% calc [currency=KZT] 20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }} %} = {% calc [currency=KZT] (3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|number }}) + (20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }}) %} — стоимость использования {{ lockbox-name }} за один месяц, вкл. НДС.

Где:
* 3 × 5 — количество версий всех секретов.
* 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|string }} — цена за хранение одной версии секрета в месяц (вкл. НДС). 720 — количество часов в месяц, зафиксированное для удобства расчетов.
* 20 000 — количество операций `get`.
* {{ sku|KZT|lockbox.api.v1.get|string }} — цена за 10 000 операций `get`, вкл. НДС.