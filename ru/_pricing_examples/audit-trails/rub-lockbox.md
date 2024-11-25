> (2 × 7&nbsp;000 / 100&nbsp;000) × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = 0,14 × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = {% calc [currency=RUB] 0,14 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}
>
> Итого: {% calc [currency=RUB] 0,14 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}

Где:

* 2 — количество доставляемых событий при одном обращении к секрету.
* 7&nbsp;000 — количество обращений к секрету.
* {{ sku|RUB|audit-trails.events.data_plane.v1|string }} — цена за доставку 100&nbsp;000 событий.
* 100&nbsp;000 — делим, чтобы привести количество событий к единице тарификации.