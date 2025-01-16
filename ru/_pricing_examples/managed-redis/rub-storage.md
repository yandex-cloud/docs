> 720 × {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.redis.v3.ram|number }}) %} + 3 × (100&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.network-nvme.redis|month|string }}) = {% calc [currency=RUB] 720 × (3 × (2 × {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.redis.v3.ram|number }})) + 3 × (100 × {{ sku|RUB|mdb.cluster.network-nvme.redis|month|number }}) %}
>
> Итого: {% calc [currency=RUB] 720 × (3 × (2 × {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.redis.v3.ram|number }})) + 3 × (100 × {{ sku|RUB|mdb.cluster.network-nvme.redis|month|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.redis.v3.ram|number }}) %} — стоимость часа работы хостов {{ VLK }}.
* 3 — количество хостов {{ VLK }}.
* 100 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
* {{ sku|RUB|mdb.cluster.network-nvme.redis|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.