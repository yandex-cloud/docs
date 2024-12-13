> 720 × {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.mysql.v3.ram|number }}) %} + 3 × (100&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}) = {% calc [currency=KZT] 720 × (3 × (2 × {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.mysql.v3.ram|number }})) + 3 × (100 × {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|number }}) %}
>
> Итого: {% calc [currency=KZT] 720 × (3 × (2 × {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.mysql.v3.ram|number }})) + 3 × (100 × {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.mysql.v3.ram|number }}) %} — стоимость часа работы хостов {{ MY }}.
* 3 — количество хостов {{ MY }}.
* 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
* {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.