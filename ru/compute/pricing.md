---
editable: false
---

# Правила тарификации для {{ compute-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ compute-short-name }} {#rules}

Расчет стоимости использования {{ compute-name }} учитывает:
* Вычислительные ресурсы ВМ:
  * тип и количество ядер (vCPU);
  * количество графических ускорителей (GPU);
  * объем памяти (RAM).
* Операционные системы.
* Тип и объем хранилища:
  * диски;
  * образы;
  * снимки.
* Объем исходящего трафика.
* Публичный IP-адрес.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

Цены за месяц использования формируются из расчета 720 часов в месяц.

### Использование виртуальных машин {#instance}

Стоимость машины зависит от выделенных вычислительных ресурсов, операционной системы и времени использования. Подключаемые диски и использование сети оплачиваются отдельно.

Стоимость рассчитывается за время использования виртуальной машины, начиная с момента запуска (перехода в статус `RUNNING`) и до полной остановки. Время, которое ВМ была выключена, не тарифицируется.

ВМ автоматически запускается после создания.

При создании ВМ можно указать публичный IP-адрес для нее.

О тарифах за использование внешнего IP-адреса читайте в разделе [{#T}](../vpc/pricing.md) документации сервиса {{ vpc-full-name }}.

#### Вычислительные ресурсы {#instance-resources}

При создании ВМ указывается количество ядер процессора (vCPU), количество графических ускорителей ([GPU](concepts/gpus.md)), базовый уровень производительности ядра и объем оперативной памяти (RAM) в ГБ. Подробнее читайте в разделе [{#T}](concepts/performance-levels.md).

Базовый уровень производительности ядра зависит от выбранной [платформы](concepts/vm-platforms.md).

{{ price-per-hour-count-per-second }}

#### Операционные системы {#instance-os}

Использование операционной системы на ВМ также тарифицируется. Стоимость зависит от лицензии на операционную систему и количества вычислительных ресурсов. В том числе влияет то, какой тип использования ядра выбран для ВМ.

{{ price-per-hour-count-per-second }}

#### Использование лицензий Microsoft {#license-microsoft}

Правила использования лицензий Microsoft описаны в разделе [{#T}](../microsoft/licensing.md).

{% if region == "ru" %}

#### Пример расчета стоимости {#example-of-cost-calculation}

Сравним стоимость ВМ для [платформы](concepts/vm-platforms.md) Intel Broadwell c разным [уровнем производительности vCPU](concepts/performance-levels.md).

Созданы две ВМ с операционной системой Linux:
* 5% vCPU и 1 ГБ RAM;
* 100% vCPU и 1 ГБ RAM.

Обе ВМ работали в течение 30 дней.

Расчет стоимости для ВМ с 5% vCPU при цене часа использования ядра процессора, равной 0,1932 ₽, и цене часа использования 1 ГБ оперативной памяти, равной 0,2441 ₽:
>5% vCPU = 0,1932 ₽/час * 30 дней * 24 часа = 139,1040 ₽
>
>1 ГБ RAM = 0,2441 ₽/час * 30 дней * 24 часа = 175,7520 ₽
>
>Итого: 314,8560 ₽

Расчет стоимости для ВМ со 100% vCPU при цене часа использования ядра процессора, равной 0,7017 ₽, и цене часа использования 1 ГБ оперативной памяти, равной 0,2441 ₽:
>1 vCPU = 0,7017 ₽/час * 30 дней * 24 часа = 505,2240 ₽
>
>1 ГБ RAM = 0,2441 ₽/час * 30 дней * 24 часа = 175,7520 ₽
>
>Итого: 680,9760 ₽

Таким образом, стоимость ВМ с 5% vCPU почти в два раза ниже стоимости машины со 100% vCPU.

{% endif %}

### Использование хранилища (диски, снимки и образы) {#disk}

При создании диска указывается его размер — объем блочного хранилища, которое занимает диск. На стоимость услуги влияет время между созданием и удалением диска, объем диска и тип диска, который выбирается при создании.

Диски тарифицируются независимо от того, запущена ВМ или нет.

Если вы создали образ или снимок, то хранение этого объекта оплачивается отдельно — исходя из его объема.

Цена указывается за 1 месяц использования. Тарификация посекундная.

### Использование {{ ig-name }} {#instance-groups}

Использование компонента {{ ig-name }} не тарифицируется. Вы можете создавать группы ВМ, пользоваться хранилищем и вычислительными ресурсами в рамках [доступных лимитов](concepts/limits.md).

Все остальные услуги {{ yandex-cloud }}, например, создание ВМ или выделение внешних IP-адресов, [тарифицируются обычным образом](../billing/pricing.md). Исходящий трафик [тарифицируется](#prices-traffic) аналогично другим сервисам.

### Использование выделенных хостов {#dedicated-hosts}

Стоимость выделенного хоста зависит от его типа (модель процессора, количество ядер и оперативной памяти) и не зависит от количества ВМ, запущенных на нем.

Существуют конфигурации выделенных хостов с локальными SSD-дисками, воспользоваться ими можно после согласования через службу поддержки. Если локальные диски есть в конфигурации хоста, они будут оплачиваться, даже если вы их не используете.

vCPU и память ВМ, запущенных на выделенном хосте, не тарифицируются.

Использование дополнительных ресурсов, например, образов из {{ marketplace-name }} или сетевых дисков, тарифицируется обычным образом.

Цена указывается за 1 час использования (для локальных дисков — за месяц). Тарификация посекундная.

## Цены {#prices}

{% if region != "int" %}

{% note alert %}

С 22 марта 2022 года повышаются цены на продукты и лицензии Microsoft, с 13 апреля 2022 года — на остальные ресурсы {{ compute-name }}, [подробнее об этом читайте в блоге](https://cloud.yandex.ru/blog/posts/2022/03/pricing-update-march-2022/). С новыми ценами можно ознакомиться в таблицах ниже.

{% endnote %}

{% endif %}

### Вычислительные ресурсы ВМ {#prices-instance-resources}

{% if region == "ru" %}

| **Intel Broadwell** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 5% | {{ sku|RUB|compute.vm.cpu.c05|string }} | 0,31 ₽ | {{ sku|RUB|compute.vm.cpu.c05.preemptible|string }} | 0,19 ₽ |
| vCPU 20% | {{ sku|RUB|compute.vm.cpu.c20|string }} | 0,88 ₽ | {{ sku|RUB|compute.vm.cpu.c20.preemptible|string }} | 0,27 ₽ |
| vCPU 100% | {{ sku|RUB|compute.vm.cpu.c100|string }} | 1,12 ₽ | {{ sku|RUB|compute.vm.cpu.c100.preemptible|string }} | 0,34 ₽ |
| 1 GPU Nvidia V100 | {{ sku|RUB|compute.vm.gpu.gpu-standard|string }} | 249,52 ₽ | {{ sku|RUB|compute.vm.gpu.gpu-standard.preemptible|string }} | 62,40 ₽ |
| 1 vGPU Nvidia V100 | {{ sku|RUB|compute.vm.gpu.vgpu-standard.v1|string }} | 62,40 ₽ | {{ sku|RUB|compute.vm.gpu.vgpu-standard.v1.preemptible|string }} | 15,60 ₽ |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram|string }} | 0,39 ₽ | {{ sku|RUB|compute.vm.ram.preemptible|string }} | 0,12 ₽ |

<br>

| **Intel Cascade Lake** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 5% | {{ sku|RUB|compute.vm.cpu.c05.v2|string }} | 0,16 ₽ | {{ sku|RUB|compute.vm.cpu.c05.preemptible.v2|string }} | 0,10 ₽ |
| vCPU 20% | {{ sku|RUB|compute.vm.cpu.c20.v2|string }} | 0,49 ₽ | {{ sku|RUB|compute.vm.cpu.c20.preemptible.v2|string }} | 0,16 ₽ |
| vCPU 50% | {{ sku|RUB|compute.vm.cpu.50.v2|string }} | 0,72 ₽ | {{ sku|RUB|compute.vm.cpu.c50.preemptible.v2|string }} | 0,22 ₽ |
| vCPU 100% | {{ sku|RUB|compute.vm.cpu.c100.v2|string }} | 1,19 ₽ | {{ sku|RUB|compute.vm.cpu.c100.preemptible.v2|string }} | 0,32 ₽ |
| 1 GPU Nvidia V100 | {{ sku|RUB|compute.vm.gpu.gpu-standard.v2|string }} | 249,52 ₽ | {{ sku|RUB|compute.vm.gpu.gpu-standard.preemptible.v2|string }} | 62,40 ₽ |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram.v2|string }} | 0,31 ₽ | {{ sku|RUB|compute.vm.ram.preemptible.v2|string }} | 0,07 ₽ |

<br>

| **Intel Ice Lake** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 20% | {{ sku|RUB|compute.vm.cpu.c20.v3|string }} | 0,44 ₽ | {{ sku|RUB|compute.vm.cpu.c20.preemptible.v3|string }} | 0,14 ₽ |
| vCPU 50% | {{ sku|RUB|compute.vm.cpu.c50.v3|string }} | 0,64 ₽ | {{ sku|RUB|compute.vm.cpu.c50.preemptible.v3|string }} | 0,20 ₽ |
| vCPU 100% | {{ sku|RUB|compute.vm.cpu.c100.v3|string }} | 1,05 ₽ | {{ sku|RUB|compute.vm.cpu.c100.preemptible.v3|string }} | 0,29 ₽ |
| 1 GPU Nvidia T4 | {{ sku|RUB|compute.vm.gpu.standard.v3-t4|string }} | 64,00 ₽ | {{ sku|RUB|compute.vm.gpu.standard.v3-t4.preemptible|string }} | 16,00 ₽ |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram.v3|string }} | 0,28 ₽ | {{ sku|RUB|compute.vm.ram.preemptible.v3|string }} | 0,07 ₽ |

<br>

| **AMD EPYC™** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 100% | {{ sku|RUB|compute.vm.cpu.c100.gpu-standard.v3|string }} | 0,90 ₽ | {{ sku|RUB|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }} | 0,36 ₽ |
| 1 GPU Nvidia A100 | {{ sku|RUB|compute.vm.gpu.gpu-standard.v3|string }} | 371,70 ₽ | {{ sku|RUB|compute.vm.gpu.gpu-standard.preemptible.v3|string }} | 148,68 ₽ |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram.gpu-standard.v3|string }} | 0,28 ₽ | {{ sku|RUB|compute.vm.ram.gpu-standard.preemptible.v3|string }} | 0,11 ₽ |

{% endif %}

{% if region == "kz" %}

| **Intel Broadwell** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 5% | {{ sku|KZT|compute.vm.cpu.c05|string }} | 1,55 ₸ | {{ sku|KZT|compute.vm.cpu.c05.preemptible|string }} | 0,95 ₸ |
| vCPU 20% | {{ sku|KZT|compute.vm.cpu.c20|string }} | 4,40 ₸ | {{ sku|KZT|compute.vm.cpu.c20.preemptible|string }} | 1,35 ₸ |
| vCPU 100% | {{ sku|KZT|compute.vm.cpu.c100|string }} | 5,60 ₸ | {{ sku|KZT|compute.vm.cpu.c100.preemptible|string }} | 1,70 ₸ |
| 1 GPU Nvidia V100 | {{ sku|KZT|compute.vm.gpu.gpu-standard|string }} | 1247,60 ₸ | {{ sku|KZT|compute.vm.gpu.gpu-standard.preemptible|string }} | 312,00 ₸ |
| 1 vGPU Nvidia V100 | {{ sku|KZT|compute.vm.gpu.vgpu-standard.v1|string }} | 312,00 ₸ | {{ sku|KZT|compute.vm.gpu.vgpu-standard.v1.preemptible|string }} | 78,00 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|compute.vm.ram|string }} | 1,95 ₸ | {{ sku|KZT|compute.vm.ram.preemptible|string }} | 0,60 ₸ |

<br>

| **Intel Cascade Lake** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 5% | {{ sku|KZT|compute.vm.cpu.c05.v2|string }} | 0,80 ₸ | {{ sku|KZT|compute.vm.cpu.c05.preemptible.v2|string }} | 0,50 ₸ |
| vCPU 20% | {{ sku|KZT|compute.vm.cpu.c20.v2|string }} | 2,45 ₸ | {{ sku|KZT|compute.vm.cpu.c20.preemptible.v2|string }} | 0,80 ₸ |
| vCPU 50% | {{ sku|KZT|compute.vm.cpu.50.v2|string }} | 3,60 ₸ | {{ sku|KZT|compute.vm.cpu.c50.preemptible.v2|string }} | 1,10 ₸ |
| vCPU 100% | {{ sku|KZT|compute.vm.cpu.c100.v2|string }} | 5,95 ₸ | {{ sku|KZT|compute.vm.cpu.c100.preemptible.v2|string }} | 1,60 ₸ |
| 1 GPU Nvidia V100 | {{ sku|KZT|compute.vm.gpu.gpu-standard.v2|string }} | 1247,60 ₸ | {{ sku|KZT|compute.vm.gpu.gpu-standard.preemptible.v2|string }} | 312,00 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|compute.vm.ram.v2|string }} | 1,55 ₸ | {{ sku|KZT|compute.vm.ram.preemptible.v2|string }} | 0,35 ₸ |

<br>

| **Intel Ice Lake** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 20% | {{ sku|KZT|compute.vm.cpu.c20.v3|string }} | 2,20 ₸ | {{ sku|KZT|compute.vm.cpu.c20.preemptible.v3|string }} | 0,70 ₸ |
| vCPU 50% | {{ sku|KZT|compute.vm.cpu.c50.v3|string }} | 3,20 ₸ | {{ sku|KZT|compute.vm.cpu.c50.preemptible.v3|string }} | 1,00 ₸ |
| vCPU 100% | {{ sku|KZT|compute.vm.cpu.c100.v3|string }} | 5,25 ₸ | {{ sku|KZT|compute.vm.cpu.c100.preemptible.v3|string }} | 1,45 ₸ |
| 1 GPU Nvidia T4 | {{ sku|KZT|compute.vm.gpu.standard.v3-t4|string }} | 320,00 ₸ | {{ sku|KZT|compute.vm.gpu.standard.v3-t4.preemptible|string }} | 80,00 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|compute.vm.ram.v3|string }} | 1,40 ₸ | {{ sku|KZT|compute.vm.ram.preemptible.v3|string }} | 0,35 ₸ |

<br>

| **AMD EPYC™** | Обычная ВМ | | Прерываемая ВМ | |
| --- | --- | --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** | **До 12 апреля 2022<br>включительно** | **C 13 апреля 2022** |
| vCPU 100% | {{ sku|KZT|compute.vm.cpu.c100.gpu-standard.v3|string }} | 4,50 ₸ | {{ sku|KZT|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }} | 1,80 ₸ |
| 1 GPU Nvidia A100 | {{ sku|KZT|compute.vm.gpu.gpu-standard.v3|string }} | 1858,50 ₸ | {{ sku|KZT|compute.vm.gpu.gpu-standard.preemptible.v3|string }} | 743,40 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|compute.vm.ram.gpu-standard.v3|string }} | 1,40 ₸ | {{ sku|KZT|compute.vm.ram.gpu-standard.preemptible.v3|string }} | 0,55 ₸ |

{% endif %}

{% if region == "int" %}

**Intel Broadwell** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 5% | {{ sku|USD|compute.vm.cpu.c05|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible|string }}
vCPU 20% | {{ sku|USD|compute.vm.cpu.c20|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible|string }}
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible|string }}
1 GPU Nvidia V100 | {{ sku|USD|compute.vm.gpu.gpu-standard|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible|string }}
1 vGPU Nvidia V100 | {{ sku|USD|compute.vm.gpu.vgpu-standard.v1|string }} | {{ sku|USD|compute.vm.gpu.vgpu-standard.v1.preemptible|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram|string }} | {{ sku|USD|compute.vm.ram.preemptible|string }}

<br>

**Intel Cascade Lake** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 5% | {{ sku|USD|compute.vm.cpu.c05.v2|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible.v2|string }}
vCPU 20% | {{ sku|USD|compute.vm.cpu.c20.v2|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v2|string }}
vCPU 50% | {{ sku|USD|compute.vm.cpu.50.v2|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v2|string }}
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100.v2|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v2|string }}
1 GPU Nvidia V100 | {{ sku|USD|compute.vm.gpu.gpu-standard.v2|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible.v2|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v2|string }} | {{ sku|USD|compute.vm.ram.preemptible.v2|string }}

<br>

**Intel Ice Lake** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 20% | {{ sku|USD|compute.vm.cpu.c20.v3|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v3|string }}
vCPU 50% | {{ sku|USD|compute.vm.cpu.c50.v3|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v3|string }}
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100.v3|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v3|string }}
1 GPU Nvidia T4 | {{ sku|USD|compute.vm.gpu.standard.v3-t4|string }} | {{ sku|USD|compute.vm.gpu.standard.v3-t4.preemptible|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v3|string }} | {{ sku|USD|compute.vm.ram.preemptible.v3|string }}

<br>

**AMD EPYC™** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }}
1 GPU Nvidia A100 | {{ sku|USD|compute.vm.gpu.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible.v3|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.ram.gpu-standard.preemptible.v3|string }}

{% endif %}

### Операционные системы {#prices-os}

{% if region == "ru" %}

{% include [rub-os.md](../_pricing/compute/rub-os.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-os.md](../_pricing/compute/kzt-os.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-os.md](../_pricing/compute/usd-os.md) %}

{% endif %}

Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:

{% if region == "ru" %}

{% include [rub-os-rds.md](../_pricing/compute/rub-os-rds.md) %}

{% include [rub-os-sql.md](../_pricing/compute/rub-os-sql.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-os-rds.md](../_pricing/compute/kzt-os-rds.md) %}

{% include [kzt-os-sql.md](../_pricing/compute/kzt-os-sql.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-os-rds.md](../_pricing/compute/usd-os-rds.md) %}

{% include [usd-os-sql.md](../_pricing/compute/usd-os-sql.md) %}

{% endif %}

\* Продукт предоставляется на группу из 2 vCPU, минимальное доступное количество vCPU для ВМ — 4 (2 группы).

### Диски, снимки и образы {#prices-storage}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/compute/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/compute/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/compute/usd-storage.md) %}

{% endif %}

### Вычислительные ресурсы выделенных хостов {#prices-dedicated-host}

{% if region == "ru" %}

{% include [rub-host-cpu.md](../_pricing/compute/rub-host-cpu.md) %}

{% include [rub-host-other.md](../_pricing/compute/rub-host-other.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host-cpu.md](../_pricing/compute/kzt-host-cpu.md) %}

{% include [kzt-host-other.md](../_pricing/compute/kzt-host-other.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host-cpu.md](../_pricing/compute/usd-host-cpu.md) %}

{% include [usd-host-other.md](../_pricing/compute/usd-host-other.md) %}

{% endif %}

{% if region == "ru" %}

{% include [rub-local-nvme.md](../_pricing/compute/rub-local-nvme.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-local-nvme.md](../_pricing/compute/kzt-local-nvme.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-local-nvme.md](../_pricing/compute/usd-local-nvme.md) %}

{% endif %}

### Программно-ускоренная сеть {#software-accelerated-network}

{% if region == "ru" %}

{% include [rub-network.md](../_pricing/compute/rub-network.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-network.md](../_pricing/compute/kzt-network.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-network.md](../_pricing/compute/usd-network.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}