> 3 × 5 × {{ sku|KZT|lockbox.storage.v1.active_secrets|month|string }} = {% calc [currency=KZT] 3 × 5 × {{ sku|KZT|lockbox.storage.v1.active_secrets|month|number }} %}
> 20 000 / 10 000 × {{ sku|KZT|lockbox.api.v1.get|string }} = {% calc [currency=KZT] 20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }} %}

> Итого: {% calc [currency=KZT] 3 × 5 × {{ sku|KZT|lockbox.storage.v1.active_secrets|month|number }} %} + {% calc [currency=KZT] 20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }} %} = {% calc [currency=KZT] (3 × 5 × {{ sku|KZT|lockbox.storage.v1.active_secrets|month|number }}) + (20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }}) %} — стоимость использования {{ lockbox-name }} за один месяц, вкл. НДС.

Где:
* 3 × 5 — количество версий всех секретов.
* {{ sku|KZT|lockbox.storage.v1.active_secrets|month|string }} — цена за хранение одной версии секрета в месяц, вкл. НДС.
* 20 000 — количество операций `get`.
* {{ sku|KZT|lockbox.api.v1.get|string }} — цена за 10 000 операций `get`, вкл. НДС.