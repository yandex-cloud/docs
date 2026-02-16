> (17&nbsp;000 / 100&nbsp;000) × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = 0,17 × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = {% calc [currency=RUB] 0,17 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}
>
> Итого: {% calc [currency=RUB] 0,17 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}