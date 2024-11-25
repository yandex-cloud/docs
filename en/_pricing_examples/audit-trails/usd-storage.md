> ((25,000 - 1,000) / 100,000) × {{ sku|USD|audit-trails.events.data_plane.v1|string }} = 0.24 × {{ sku|USD|audit-trails.events.data_plane.v1|string }} = {% calc [currency=USD] 0,24 × {{ sku|USD|audit-trails.events.data_plane.v1|number }} %}
>
> Total: {% calc [currency=USD] 0,24 × {{ sku|USD|audit-trails.events.data_plane.v1|number }} %}

Where:

* 25,000: Total number of delivered {{ objstorage-name }} events.
* 1,000: Number of delivered management events that are not billed.
* {{ sku|USD|audit-trails.events.data_plane.v1|string }}: Price of delivering 100,000 events.
* 100,000: Divisor to reduce the number of events to a billing unit.