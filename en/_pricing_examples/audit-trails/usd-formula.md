> (17,000 / 100,000) × {{ sku|USD|audit-trails.events.data_plane.v1|string }} = 0.17 × {{ sku|USD|audit-trails.events.data_plane.v1|string }} = {% calc [currency=USD] 0,17 × {{ sku|USD|audit-trails.events.data_plane.v1|number }} %}
>
> Total: {% calc [currency=USD] 0,17 × {{ sku|USD|audit-trails.events.data_plane.v1|number }} %}