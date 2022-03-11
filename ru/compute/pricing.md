---
editable: false
---

# Правила тарификации для {{ compute-name }}

{% note alert %}

В этом разделе указаны цены, действующие до 21 марта 2022 года включительно. С 22 марта цены на операционные системы и лицензии Microsoft будут повышены на 60%. Новые цены см. в разделе [{#T}](pricing-22032022.md).

{% endnote %}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ compute-short-name }} {#rules}

Расчет стоимости использования {{ compute-short-name }} учитывает:
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

Стоимость рассчитывается за время использования виртуальной машины, начиная с момента запуска (перехода в статус `RUNNING`) и до полной остановки. Время, которое виртуальная машина была выключена, не тарифицируется.

Виртуальная машина автоматически запускается после создания.

При создании виртуальной машины можно указать публичный IP-адрес для нее.

О тарифах за использование внешнего IP-адреса читайте в разделе [{#T}](../vpc/pricing.md) документации сервиса {{ vpc-full-name }}.

#### Вычислительные ресурсы {#instance-resources}

При создании виртуальной машины указывается количество ядер процессора (vCPU), количество графических ускорителей ([GPU](concepts/gpus.md)), базовый уровень производительности ядра и объем оперативной памяти (RAM) в ГБ. Подробнее читайте в разделе [{#T}](concepts/performance-levels.md).

Базовый уровень производительности ядра зависит от выбранной [платформы](concepts/vm-platforms.md).

{{ price-per-hour-count-per-second }}

#### Операционные системы {#instance-os}

Использование операционной системы на виртуальной машине также тарифицируется. Стоимость зависит от лицензии на операционную систему и количества вычислительных ресурсов. В том числе влияет то, какой тип использования ядра выбран для виртуальной машины.

{{ price-per-hour-count-per-second }}

#### Использование лицензий Microsoft {#license-microsoft}

Правила использования лицензий Microsoft описаны в разделе [{#T}](../microsoft/licensing.md).


#### Пример расчета стоимости {#example-of-cost-calculation}

Сравним стоимость виртуальных машин для [платформы](concepts/vm-platforms.md) Intel Broadwell c разным [уровнем производительности vCPU](concepts/performance-levels.md).

Созданы две виртуальные машины с операционной системой Linux:
* 5% vCPU и 1 ГБ RAM;
* 100% vCPU и 1 ГБ RAM.

Обе виртуальные машины работали в течение 30 дней.

Расчет стоимости для виртуальной машины с 5% vCPU при цене часа использования ядра процессора, равной 0,1932 ₽, и цене часа использования 1 ГБ оперативной памяти, равной 0,2441 ₽:

>5% vCPU = 0,1932 ₽/час * 30 дней * 24 часа = 139,1040 ₽
>
>1 ГБ RAM = 0,2441 ₽/час * 30 дней * 24 часа = 175,7520 ₽
>
>Итого: 314,8560 ₽

Расчет стоимости для виртуальной машины со 100% vCPU при цене часа использования ядра процессора, равной 0,7017 ₽, и цене часа использования 1 ГБ оперативной памяти, равной 0,2441 ₽:

>1 vCPU = 0,7017 ₽/час * 30 дней * 24 часа = 505,2240 ₽
>
>1 ГБ RAM = 0,2441 ₽/час * 30 дней * 24 часа = 175,7520 ₽
>
>Итого: 680,9760 ₽

Таким образом, стоимость виртуальной машины с 5% vCPU почти в два раза ниже стоимости машины со 100% vCPU.

### Использование хранилища (диски, снимки и образы) {#disk}

При создании диска указывается его размер — объем блочного хранилища, которое занимает диск. На стоимость услуги влияет время между созданием и удалением диска, объем диска и тип диска, который выбирается при создании.

Диски тарифицируются независимо от того, запущена виртуальная машина или нет.

Если вы создали образ или снимок, то хранение этого объекта оплачивается отдельно — исходя из его объема.

Цена указывается за 1 месяц использования. Тарификация посекундная.

### Использование {{ ig-name }} {#instance-groups}

Использование компонента {{ ig-name }} не тарифицируется. Вы можете создавать группы виртуальных машин, пользоваться хранилищем и вычислительными ресурсами в рамках [доступных лимитов](concepts/limits.md).

Все остальные услуги {{ yandex-cloud }}, например, создание виртуальных машин или выделение внешних IP-адресов, [тарифицируются обычным образом](../billing/pricing.md). Исходящий трафик [тарифицируется](#prices-traffic) аналогично другим сервисам.

### Использование выделенных хостов {#dedicated-hosts}

Стоимость выделенного хоста зависит от его типа (модель процессора, количество ядер и оперативной памяти) и не зависит от количества ВМ, запущенных на нем. 

Существуют конфигурации выделенных хостов с локальными SSD-дисками, воспользоваться ими можно после согласования через службу поддержки. Если локальные диски есть в конфигурации хоста, они будут оплачиваться, даже если вы их не используете.

vCPU и память ВМ, запущенных на выделенном хосте, не тарифицируются.

Использование дополнительных ресурсов, например, образов из {{ marketplace-name }} или сетевых дисков, тарифицируется обычным образом.

Цена указывается за 1 час использования (для локальных дисков — за месяц). Тарификация посекундная.

## Цены {#prices}

### Вычислительные ресурсы ВМ {#prices-instance-resources}


| **Intel Broadwell**    | Обычная ВМ                                               | Прерываемая ВМ                                                       |
| ---------------------- | -------------------------------------------------------- | -------------------------------------------------------------------- |
| vCPU 5%                | {{ sku|RUB|compute.vm.cpu.c05|string }}                  | {{ sku|RUB|compute.vm.cpu.c05.preemptible|string }}                  |
| vCPU 20%               | {{ sku|RUB|compute.vm.cpu.c20|string }}                  | {{ sku|RUB|compute.vm.cpu.c20.preemptible|string }}                  |
| vCPU 100%              | {{ sku|RUB|compute.vm.cpu.c100|string }}                 | {{ sku|RUB|compute.vm.cpu.c100.preemptible|string }}                 |
| 1 GPU Nvidia V100      | {{ sku|RUB|compute.vm.gpu.gpu-standard|string }}         | {{ sku|RUB|compute.vm.gpu.gpu-standard.preemptible|string }}         |
| 1 vGPU Nvidia V100     | {{ sku|RUB|compute.vm.gpu.vgpu-standard.v1|string }}     | {{ sku|RUB|compute.vm.gpu.vgpu-standard.v1.preemptible|string }}     |
| RAM (за 1 ГБ)          | {{ sku|RUB|compute.vm.ram|string }}                      | {{ sku|RUB|compute.vm.ram.preemptible|string }}                      |

<br>

| **Intel Cascade Lake** | Обычная ВМ                                               | Прерываемая ВМ                                                       |
| ---------------------- | -------------------------------------------------------- | -------------------------------------------------------------------- |
| vCPU 5%                | {{ sku|RUB|compute.vm.cpu.c05.v2|string }}               | {{ sku|RUB|compute.vm.cpu.c05.preemptible.v2|string }}               |
| vCPU 20%               | {{ sku|RUB|compute.vm.cpu.c20.v2|string }}               | {{ sku|RUB|compute.vm.cpu.c20.preemptible.v2|string }}               |
| vCPU 50%               | {{ sku|RUB|compute.vm.cpu.50.v2|string }}                | {{ sku|RUB|compute.vm.cpu.c50.preemptible.v2|string }}               |
| vCPU 100%              | {{ sku|RUB|compute.vm.cpu.c100.v2|string }}              | {{ sku|RUB|compute.vm.cpu.c100.preemptible.v2|string }}              |
| 1 GPU Nvidia V100      | {{ sku|RUB|compute.vm.gpu.gpu-standard.v2|string }}      | {{ sku|RUB|compute.vm.gpu.gpu-standard.preemptible.v2|string }}      |
| RAM (за 1 ГБ)          | {{ sku|RUB|compute.vm.ram.v2|string }}                   | {{ sku|RUB|compute.vm.ram.preemptible.v2|string }}                   |

<br>

| **Intel Ice Lake**     | Обычная ВМ                                               | Прерываемая ВМ                                                       |
| ---------------------- | -------------------------------------------------------- | -------------------------------------------------------------------- |
| vCPU 20%               | {{ sku|RUB|compute.vm.cpu.c20.v3|string }}               | {{ sku|RUB|compute.vm.cpu.c20.preemptible.v3|string }}               |
| vCPU 50%               | {{ sku|RUB|compute.vm.cpu.c50.v3|string }}               | {{ sku|RUB|compute.vm.cpu.c50.preemptible.v3|string }}               |
| vCPU 100%              | {{ sku|RUB|compute.vm.cpu.c100.v3|string }}              | {{ sku|RUB|compute.vm.cpu.c100.preemptible.v3|string }}              |
| 1 GPU Nvidia T4        | {{ sku|RUB|compute.vm.gpu.standard.v3-t4|string }}       | {{ sku|RUB|compute.vm.gpu.standard.v3-t4.preemptible|string }}       |
| RAM (за 1 ГБ)          | {{ sku|RUB|compute.vm.ram.v3|string }}                   | {{ sku|RUB|compute.vm.ram.preemptible.v3|string }}                   |

<br>

| **AMD EPYC™**          | Обычная ВМ                                               | Прерываемая ВМ                                                       |
| ---------------------- | -------------------------------------------------------- | -------------------------------------------------------------------- |
| vCPU 100%              | {{ sku|RUB|compute.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|RUB|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }} |
| 1 GPU Nvidia A100      | {{ sku|RUB|compute.vm.gpu.gpu-standard.v3|string }}      | {{ sku|RUB|compute.vm.gpu.gpu-standard.preemptible.v3|string }}      |
| RAM (за 1 ГБ)          | {{ sku|RUB|compute.vm.ram.gpu-standard.v3|string }}      | {{ sku|RUB|compute.vm.ram.gpu-standard.preemptible.v3|string }}      |



### Операционные системы {#prices-os}


{% include [rub-os.md](../_pricing/compute/rub-os.md) %}



Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:


{% include [rub-os-rds.md](../_pricing/compute/rub-os-rds.md) %}

{% include [rub-os-sql.md](../_pricing/compute/rub-os-sql.md) %}



\* Продукт предоставляется на группу из 2 vCPU, минимальное доступное количество vCPU для ВМ — 4 (2 группы).

### Диски, снимки и образы {#prices-storage}


{% include [rub-storage.md](../_pricing/compute/rub-storage.md) %}



### Вычислительные ресурсы выделенных хостов {#prices-dedicated-host}


{% include [rub-host-cpu.md](../_pricing/compute/rub-host-cpu.md) %}

{% include [rub-host-other.md](../_pricing/compute/rub-host-other.md) %}




{% include [rub-local-nvme.md](../_pricing/compute/rub-local-nvme.md) %}



### Программно-ускоренная сеть {#software-accelerated-network}


{% include [rub-network.md](../_pricing/compute/rub-network.md) %}



### Исходящий трафик {#prices-traffic}


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}


