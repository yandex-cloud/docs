  > 720 × ({% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} + {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %}) + 100&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }} = {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}))) + 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %}
  >
  > Итого: {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}))) + 100 × {{ sku|RUB|mdb.cluster.network-hdd.ch|month|number }} %} — стоимость использования кластера в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ CH }}.
  * {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
  * {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.