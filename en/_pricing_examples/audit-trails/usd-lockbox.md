> (2 × 7,000 / 100,000) × {{ sku|USD|audit-trails.events.data_plane.v1|string }} = 0.14 × {{ sku|USD|audit-trails.events.data_plane.v1|string }} = {% calc [currency=USD] 0,14 × {{ sku|USD|audit-trails.events.data_plane.v1|number }} %}
>
> Total: {% calc [currency=USD] 0,14 × {{ sku|USD|audit-trails.events.data_plane.v1|number }} %}

Where:

* 2: Number of events delivered per a single access to a secret.
* 7,000: Number of times the secret is accessed.
* {{ sku|USD|audit-trails.events.data_plane.v1|string }}: Price of delivering 100,000 events.
* 100,000: Divisor to reduce the number of events to a billing unit.