Расчет стоимости для хостов {{ CH }}:

> 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|string }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %}
>
> Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ CH }}.

Где:
* 3 — количество хостов {{ CH }}.
* 2 — количество vCPU.
* {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
* 8 — объем RAM одного хоста {{ CH }} (в гигабайтах).
* {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости хранилища для хостов {{ CH }}:

> 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }} = {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %}
>
> Итого: {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %} — стоимость использования кластера в течение 30 дней.

Где:
* 3 — количество хостов {{ CH }}.
* 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
* {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

Расчет стоимости для хостов {{ ZK }}:

> 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|string }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %}
>
> Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.

Где:
* 3 — количество хостов {{ ZK }}.
* 2 — количество vCPU.
* {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|string }} — стоимость часа использования 50% vCPU.
* 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
* {{ sku|RUB|mdb.zk.clickhouse.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 50% vCPU.

Расчет стоимости хранилища для хостов {{ ZK }}:

> 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }} = {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %}
>
> Итого: {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.

Где:
* 3 — количество хостов {{ ZK }}.
* 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
* {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.

Расчет итоговой стоимости:

> 720 × ({% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} + {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %}) + {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %} + {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %} = {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }}) %}
>
> Итого: {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ CH }}.
* {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
* {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %} — стоимость хранилища для хостов {{ CH }}.
* {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.ch|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.