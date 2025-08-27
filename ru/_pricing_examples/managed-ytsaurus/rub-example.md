#### Настраиваемые компоненты

Расчет стоимости для exec-ноды:

> 8 × {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} %} + 32 × {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} = {% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %}
>
> Итого: {% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} — стоимость часа работы exec-ноды.

Где:
* 8 — количество vCPU одной exec-ноды.
* {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
* 32 — объем RAM одной exec-ноды (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.

Расчет стоимости для tablet-ноды:

> 3 × (8 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы tablet-нод.

Где:
* 3 — количество tablet-нод.
* 8 — количество vCPU одной tablet-ноды.
* {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
* 16 — объем RAM одной tablet-ноды (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.

Расчет стоимости хранилищ для кластера:

> 3 × 2048 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.hdd.v1|month|number }} %} + 3 × 465 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Итого: {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилищ на нереплицируемых SSD-дисках и сетевых HDD-дисках.

Где:
* 3 — количество дисков с типом `HDD`.
* 2048 — размер одного HDD-диска (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.storage.hdd.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
* 3 — количество дисков с типом `Нереплицируемый SSD`.
* 465 — размер одного нереплицируемого SSD-диска (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.

#### Служебные компоненты

Расчет стоимости для master-ноды:

> 3 × (4 × {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.cpu.v3|number }} %} + 12 × {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %} — стоимость часа работы master-нод.

Где:
* 3 — количество master-нод.
* 4 — количество vCPU одной master-ноды.
* {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
* 12 — объем RAM одной master-ноды (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.master-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.

Расчет стоимости для system-ноды:

> 2 × (24 × {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.cpu.v3|number }} %} + 64 × {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %} — стоимость часа работы system-нод.

Где:
* 2 — количество system-нод.
* 24 — количество vCPU одной system-ноды.
* {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
* 64 — объем RAM одной system-ноды (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.system-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.

Расчет стоимости для proxy-ноды:

> 2 × (4 × {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %} — стоимость часа работы proxy-нод.

Где:
* 2 — количество proxy-нод.
* 4 — количество vCPU одной proxy-ноды.
* {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
* 8 — объем RAM одной proxy-ноды (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.proxy-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.

Расчет стоимости для служебной tablet-ноды:

> 2 × (8 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы служебных tablet-нод.

Где:
* 2 — количество tablet-нод.
* 8 — количество vCPU одной tablet-ноды.
* {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
* 16 — объем RAM одной tablet-ноды (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.tablet-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.

Расчет стоимости хранилища для exec-ноды:

> 93 × 1 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Итого: {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для exec-ноды.

Где:
* 93 — размер хранилища на нереплицируемых SSD-дисках (в гигабайтах).
* 1 — количество нереплицируемых SSD-дисков.
* {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.

Расчет стоимости хранилища для служебных storage-нод:

> 3 × 93 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Итого: {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для служебных storage-нод.

Где:
* 3 — количество дисков.
* 93 — размер одного нереплицируемого SSD-диска (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.

Расчет стоимости для storage-ноды:

> 6 × (8 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.ram.v3|number }} %}) + 3 × (4 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.ram.v3|number }} %}) = {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %} — стоимость часа работы storage-нод.

Где:
* 6 — количество storage-нод для `SSD` / `Нереплицируемый SSD`.
* 3 — количество storage-нод для `HDD`.
* 8 — количество vCPU одной storage-ноды для `SSD` / `Нереплицируемый SSD`.
* 4 — количество vCPU одной storage-ноды для `HDD`.
* {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} %} — стоимость часа использования 1 vCPU.
* 8 — объем RAM одной storage-ноды для `SSD` / `Нереплицируемый SSD` / `HDD` (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.storage-nodes.ram.v3|number }} %} — стоимость часа использования 1 ГБ RAM.

Расчет стоимости хранилища со служебными дисками:

> 93 × 6 × {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Итого: {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках.

Где:
* 6 — количество служебных дисков.
* 93 — размер одного нереплицируемого SSD-диска (в гигабайтах).
* {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования 1 ГБ хранилища на нереплицируемых SSD-дисках.

#### Расчет итоговой стоимости

> 720 × ({% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} + {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %}) + {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}  = {% calc [currency=RUB] 720 × (8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 ×{{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Итого: {% calc [currency=RUB] 720 × (8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 ×{{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* {% calc [currency=RUB] 8 × {{ sku|RUB|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|RUB|yt.compute-nodes.ram.v3|number }} %} — стоимость часа работы exec-ноды.
* {% calc [currency=RUB] 3 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы tablet-нод.
* {% calc [currency=RUB] 3 × (4 × {{ sku|RUB|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|RUB|yt.master-nodes.ram.v3|number }}) %} — стоимость часа работы master-нод.
* {% calc [currency=RUB] 2 × (24 × {{ sku|RUB|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|RUB|yt.system-nodes.ram.v3|number }}) %} — стоимость часа работы system-нод.
* {% calc [currency=RUB] 2 × (4 × {{ sku|RUB|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.proxy-nodes.ram.v3|number }}) %} — стоимость часа работы proxy-нод.
* {% calc [currency=RUB] 2 × (8 × {{ sku|RUB|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|RUB|yt.tablet-nodes.ram.v3|number }}) %} — стоимость часа работы служебных tablet-нод.
* {% calc [currency=RUB] 6 × (8 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|RUB|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|RUB|yt.storage-nodes.ram.v3|number }}) %} — стоимость часа работы storage-нод.
* {% calc [currency=RUB] 3 × 2048 × {{ sku|RUB|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилищ на нереплицируемых SSD-дисках и сетевых HDD-дисках.
* {% calc [currency=RUB] 93 × 1 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для exec-ноды.
* {% calc [currency=RUB] 3 × 93 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках для служебных storage-нод.
* {% calc [currency=RUB] 93 × 6 × {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} — стоимость месяца использования хранилища на нереплицируемых SSD-дисках.
