> 1 × {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|string }} + {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|string }} + 2 × {{ sku|RUB|interconnect.trunk.hosted_connections.v1|string }} = {% calc [currency=RUB] 1 × {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|number }} + {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|number }} + 2 × {{ sku|RUB|interconnect.trunk.hosted_connections.v1|number }} %}
>
> Итого: {% calc [currency=RUB] {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|number }} + {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|number }} + 2 × {{ sku|RUB|interconnect.trunk.hosted_connections.v1|number }} %} - стоимость использования транкового подключения с одним физическим портом **10GBASE-LR**, объёмом трафика **300 ТБ** и **двумя** приватными соединениями.

Где:
* 1 — количество физических портов **10GBASE-LR** в транковом подключении.
* {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|string }} — стоимость использования физических портов **10GBASE-LR** в транковом подключении за месяц.
* {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|string }} — стоимость объема данных **300 ТБ** в транковом подключении за месяц.
* 2 — количество приватных соедиенией в транковом подключении.
* {{ sku|RUB|interconnect.trunk.hosted_connections.v1|string }} — стоимость использования одного приватного или публичного соединения за месяц.
