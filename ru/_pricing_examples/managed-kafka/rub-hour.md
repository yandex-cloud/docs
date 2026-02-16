Расчет стоимости для хостов-брокеров {{ KF }}:

> 3 × (2&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} + 8&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.kafka.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %}
> 
> Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %} — стоимость часа работы хостов-брокеров {{ KF }}.

Где:
* 3 — количество хостов-брокеров {{ KF }}.
* 2 — количество vCPU.
* {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
* 8 — объем RAM одного хоста (в гигабайтах).
* {{ sku|RUB|mdb.cluster.kafka.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости хранилища для хостов-брокеров {{ KF }}:

> 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }} = {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %}
>
> Итого: {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %} — стоимость хранилища для хостов-брокеров {{ KF }}.

Где:
* 3 — количество хостов-брокеров {{ KF }}.
* 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
* {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

Расчет стоимости для хостов {{ ZK }}:

> 3 × (2&nbsp;×&nbsp;{{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|string }} + 4&nbsp;×&nbsp;{{ sku|RUB|mdb.zk.kafka.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %}
>
> Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.

Где:
* 3 — количество хостов {{ ZK }}.
* 2 — количество vCPU.
* {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|string }} — стоимость часа использования 50% vCPU.
* 4 — объем RAM одного хоста (в гигабайтах).
* {{ sku|RUB|mdb.zk.kafka.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 50% vCPU.

Расчет стоимости хранилища для хостов {{ ZK }}:

> 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }} = {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %}
>
> Итого: {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.

Где:
* 3 — количество хостов {{ ZK }}.
* 10 — объем хранилища на сетевых SSD-дисках (в гигабайтах).
* {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых SSD-дисках.

Расчет итоговой стоимости:

> 720 × ({% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %} + {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %}) + {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %} + {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %} = {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }}) %}
>
> Итого: {% calc [currency=RUB] 720 × ((3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.kafka.v3.ram|number }}) %} — стоимость часа работы хостов-брокеров {{ KF }}.
* {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|RUB|mdb.zk.kafka.v3.ram|number }}) %} — стоимость часа работы хостов {{ ZK }}.
* {% calc [currency=RUB] 3 × 100 × {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|number }} %} — стоимость хранилища для хостов-брокеров {{ KF }}.
* {% calc [currency=RUB] 3 × 10 × {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|number }} %} — стоимость хранилища для хостов {{ ZK }}.