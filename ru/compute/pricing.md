---
editable: false
---

# Правила тарификации для {{ compute-name }}

{% if product == "cloud-il" %}

{% note info %}

Цены, указанные ниже, начнут действовать 16 ноября 2022 года, когда сервис {{ compute-name }} [станет общедоступным](../overview/concepts/launch-stages.md). До этого использование сервиса не тарифицируется.

{% endnote %}

{% endif %}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

## Из чего складывается стоимость использования {{ compute-short-name }} {#rules}

Расчет стоимости использования {{ compute-name }} учитывает:
* Вычислительные ресурсы ВМ:
  * тип и количество ядер (vCPU);
  * количество графических ускорителей (GPU);
  * объем памяти (RAM).
{% if product == "yandex-cloud" %}
* Операционные системы.
{% endif %}
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


{% if product == "yandex-cloud" %}

#### Операционные системы {#instance-os}

Использование операционной системы на ВМ также тарифицируется. Стоимость зависит от лицензии на операционную систему и количества вычислительных ресурсов. В том числе влияет то, какой тип использования ядра выбран для ВМ.

{{ price-per-hour-count-per-second }}


#### Использование лицензий Microsoft {#license-microsoft}

Правила использования лицензий Microsoft описаны в разделе [{#T}](../microsoft/licensing.md).

{% endif %}


### Пример расчета стоимости {#example-of-cost-calculation}

{% if product == "yandex-cloud" %}
Сравним стоимость ВМ для [платформы](concepts/vm-platforms.md) Intel Broadwell c разным [уровнем производительности vCPU](concepts/performance-levels.md).

Созданы две ВМ с операционной системой Linux:
* 2 × 5% vCPU и 2 ГБ RAM.
* 2 × 100% vCPU и 2 ГБ RAM.

Обе ВМ работали в течение 30 дней.

**Расчет стоимости для ВМ с 5% vCPU**:

> {% if region == "ru" %}720 × (2 × 0,3100 ₽ + 2 × 0,3900 ₽) = 1008,0000&nbsp;₽{% endif %}
> {% if region == "int" %}720 × (2 × 0,002480&nbsp;$ + 2 × 0,003120&nbsp;$) = 8,064000&nbsp;${% endif %}
> {% if region == "kz" %}720 × (2 × 1,5500&nbsp;₸ + 2 × 1,9500&nbsp;₸) = 5040,0000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}1008,0000&nbsp;₽{% endif %}{% if region == "int" %}8,064000&nbsp;${% endif %}{% if region == "kz" %}5040,0000&nbsp;₸{% endif %} — стоимость использования ВМ с 2 × 5% vCPU и 2 ГБ RAM в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 2 — количество ядер 5% vCPU.
* {% if region == "ru" %}0,3100&nbsp;₽{% endif %}{% if region == "int" %}0,002480&nbsp;${% endif %}{% if region == "kz" %}1,5500&nbsp;₸{% endif %} — стоимость часа использования 5% vCPU.
* 2 — объем RAM (в гигабайтах).
* {% if region == "ru" %}0,3900&nbsp;₽{% endif %}{% if region == "int" %}0,003120&nbsp;${% endif %}{% if region == "kz" %}1,9500&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM.

**Расчет стоимости для ВМ со 100% vCPU**:

> {% if region == "ru" %}720 × (2 × 1,1200&nbsp;₽ + 2 × 0,3900&nbsp;₽) = 2174,4000&nbsp;₽{% endif %}
> {% if region == "int" %}720 × (2 × 0,008960&nbsp;$ + 2 × 0,003120&nbsp;$) = 17,395200&nbsp;${% endif %}
> {% if region == "kz" %}720 × (2 × 5,6000&nbsp;₸ + 2 × 1,9500&nbsp;₸) = 10 872,0000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}2174,4000&nbsp;₽{% endif %}{% if region == "int" %}17,395200&nbsp;${% endif %}{% if region == "kz" %}10 872,0000&nbsp;₸{% endif %} — стоимость использования ВМ с 2 × 100% vCPU и 2 ГБ RAM в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 2 — количество ядер 100% vCPU.
* {% if region == "ru" %}1,1200&nbsp;₽{% endif %}{% if region == "int" %}0,008960&nbsp;${% endif %}{% if region == "kz" %}5,6000&nbsp;₸{% endif %} — стоимость часа использования 100% vCPU.
* 2 — объем RAM (в гигабайтах).
* {% if region == "ru" %}0,3900&nbsp;₽{% endif %}{% if region == "int" %}0,003120&nbsp;${% endif %}{% if region == "kz" %}1,9500&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM.

Таким образом, стоимость ВМ с 5% vCPU в два раза ниже стоимости ВМ со 100% vCPU.

{% endif %}

{% if product == "cloud-il" %}

Сравним стоимость ВМ для [платформы](concepts/vm-platforms.md) Intel Ice Lake c разным [уровнем производительности vCPU](concepts/performance-levels.md).

Созданы две ВМ с операционной системой Linux:
* 2 × 20% vCPU и 2 ГБ RAM.
* 2 × 100% vCPU и 2 ГБ RAM.

Обе ВМ работали в течение 30 дней.

**Расчет стоимости для ВМ с 20% vCPU**:

> 720 × (2 × 0,0223&nbsp;₪ + 2 × 0,0142&nbsp;₪) = 52,5600&nbsp;₪
>
> Итого: 52,5600&nbsp;₪ — стоимость использования ВМ с 2 × 20% vCPU и 2 ГБ RAM в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 2 — количество ядер 20% vCPU.
* 0,0223&nbsp;₪ — стоимость часа использования 20% vCPU.
* 2 — объем RAM (в гигабайтах).
* 0,0142&nbsp;₪ — стоимость часа использования 1 ГБ RAM.

**Расчет стоимости для ВМ со 100% vCPU**:

> 720 × (2 × 0,0533&nbsp;₪ + 2 × 0,0142&nbsp;₪) = 97,2000&nbsp;₪
>
> Итого: 97,2000&nbsp;₪ — стоимость использования ВМ с 2 × 100% vCPU и 2 ГБ RAM в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 2 — количество ядер 100% vCPU.
* 0,0533&nbsp;₪ — стоимость часа использования 100% vCPU.
* 2 — объем RAM (в гигабайтах).
* 0,0142&nbsp;₪ — стоимость часа использования 1 ГБ RAM.

Таким образом, стоимость ВМ с 20% vCPU в два раза ниже стоимости ВМ со 100% vCPU.

{% endif %}

### Использование хранилища (диски, снимки и образы) {#disk}

При создании диска указывается его размер — объем блочного хранилища, которое занимает диск. На стоимость услуги влияет время между созданием и удалением диска, объем диска и тип диска, который выбирается при создании.

Диски тарифицируются независимо от того, запущена ВМ или нет.

Если вы создали образ или снимок, то хранение этого объекта оплачивается отдельно — исходя из его объема.

Цена указывается за 1 месяц использования. Тарификация посекундная.

{% note warning %}

Диски с установленными продуктами [{{ marketplace-name }}]({{ link-cloud-marketplace }}) содержат идентификаторы лицензий (`product_ids`) этих продуктов.

Если вы подключили к ВМ такой диск в качестве дополнительного, то помимо платы за использование хранилища, также будет взиматься плата за использование продуктов {{ marketplace-name }}.

{% endnote %}

### Использование {{ ig-name }} {#instance-groups}

Использование компонента {{ ig-name }} не тарифицируется. Вы можете создавать группы ВМ, пользоваться хранилищем и вычислительными ресурсами в рамках [доступных лимитов](concepts/limits.md).

Все остальные услуги {{ yandex-cloud }}, например, создание ВМ или выделение внешних IP-адресов, тарифицируются обычным образом. Исходящий трафик [тарифицируется](#prices-traffic) аналогично другим сервисам.


{% if product == "yandex-cloud" %}

### Использование выделенных хостов {#dedicated-hosts}

Стоимость выделенного хоста зависит от его типа (модель процессора, количество ядер и оперативной памяти) и не зависит от количества ВМ, запущенных на нем.

Существуют конфигурации выделенных хостов с локальными SSD-дисками, воспользоваться ими можно после согласования через службу поддержки. Если локальные диски есть в конфигурации хоста, они будут оплачиваться, даже если вы их не используете.

vCPU и память ВМ, запущенных на выделенном хосте, не тарифицируются.

Использование дополнительных ресурсов, например, образов из {{ marketplace-name }} или сетевых дисков, тарифицируется обычным образом.

Цена указывается за 1 час использования (для локальных дисков — за месяц). Тарификация посекундная.

{% endif %}


## Цены {% if product == "cloud-il" %}c 16 ноября 2022 года{% endif %} {#prices}

{% if region != "int" %}

Все цены указаны с включением НДС.

{% else %}

Все цены указаны без включения НДС.

{% endif %}

### Вычислительные ресурсы ВМ {#prices-instance-resources}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-instance-resources.md](../_pricing/compute/rub-instance-resources.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-instance-resources.md](../_pricing/compute/kzt-instance-resources.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-instance-resources.md](../_pricing/compute/usd-instance-resources.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-instance-resources.md](../_pricing/compute/ils-instance-resources.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

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

{% endif %}


### Диски, снимки и образы {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/compute/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/compute/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/compute/usd-storage.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-storage.md](../_pricing/compute/ils-storage.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

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

{% endif %}


### Программно-ускоренная сеть {#software-accelerated-network}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-network.md](../_pricing/compute/rub-network.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-network.md](../_pricing/compute/kzt-network.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-network.md](../_pricing/compute/usd-network.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-network.md](../_pricing/compute/ils-network.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}

