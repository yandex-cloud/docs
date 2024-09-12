  > 3 × (2&nbsp;×&nbsp;{{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|string }} + 4&nbsp;×&nbsp;{{ sku|KZT|mdb.zk.clickhouse.v3.ram|string }}) = {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|KZT|mdb.zk.clickhouse.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
  
  Где:
  * 3 — количество хостов {{ ZK }}.
  * 2 — количество vCPU.
  * {{ sku|KZT|mdb.zk.clickhouse.v3.cpu.c50|string }} — стоимость часа использования 50% vCPU.
  * 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
  * {{ sku|KZT|mdb.zk.clickhouse.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 50% vCPU.