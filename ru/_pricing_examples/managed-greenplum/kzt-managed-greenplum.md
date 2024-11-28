Расчет стоимости для стандартных хостов:

> 3 × (8&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|string }} + 32&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v3.ram|string }}) = {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %}
>
> Итого: {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %} — стоимость часа работы стандартных хостов.

  Где:
  
  * 3 — количество стандартных хостов.
  * 8 — количество vCPU.
  * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
  * 32 — объем RAM одного стандартного хоста (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости для выделенных хостов:

> 3 × (8&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }} + 32&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|string }}) = {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %}
>
> Итого: {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} — стоимость часа работы выделенных хостов.

  Где:
  
  * 3 — количество выделенных хостов.
  * 8 — количество vCPU.
  * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }} — стоимость часа использования 100% vCPU.
  * 32 — объем RAM одного выделенного хоста (в гигабайтах).
  * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости хранилища и итоговой стоимости:

> (720 × {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %} + 3 × (100 × {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|string }})) + (720 × {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} + 3 × (50 × {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|string }})) = {% calc [currency=KZT] (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|number }}) %}
>
> Итого: {% calc [currency=KZT] (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|number }}) %} — стоимость использования кластера в течение 30 дней.

  Где:
  
  * 720 — количество часов в 30 днях.
  * {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v3.ram|number }}) %} — стоимость часа работы стандартных хостов.
  * 3 — количество хостов.
  * 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах) для стандартных хостов.
  * {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|string }} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
  * {% calc [currency=KZT] 3 * (8 * {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|KZT|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} — стоимость часа работы выделенных хостов.
  * 50 — объем хранилища на локальных SSD-дисках (в гигабайтах) для выделенных хостов.
  * {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|string }} — стоимость месяца использования 1 ГБ хранилища на локальных SSD-дисках.