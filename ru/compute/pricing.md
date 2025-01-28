---
title: Правила тарификации для {{ compute-full-name }}
description: В статье содержатся правила тарификации сервиса {{ compute-name }}.
editable: false
---


# Правила тарификации для {{ compute-name }}

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=f2dac101335a#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.





{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## Из чего складывается стоимость использования {{ compute-short-name }} {#rules}

Расчет стоимости использования {{ compute-name }} учитывает:
* Вычислительные ресурсы ВМ:
  * тип и количество ядер (vCPU);
  * количество графических ускорителей ([GPU](concepts/gpus.md));
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


#### Пример расчета стоимости вычислительных ресурсов {#instance-resources-example}

Сравним стоимость ВМ для [платформы](concepts/vm-platforms.md) Intel Ice Lake c разным [уровнем производительности vCPU](concepts/performance-levels.md).

Созданы две ВМ с операционной системой Linux:
* 2 × 20% vCPU и 2 ГБ RAM.
* 2 × 100% vCPU и 2 ГБ RAM.

Обе ВМ работали в течение 30 дней.

**Расчет стоимости для ВМ с 20% vCPU**:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-compute-vm20](../_pricing_examples/compute/rub-vm20.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-compute-vm20](../_pricing_examples/compute/kzt-vm20.md) %}

{% endlist %}




**Расчет стоимости для ВМ со 100% vCPU**:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-compute-vm100](../_pricing_examples/compute/rub-vm100.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-compute-vm100](../_pricing_examples/compute/kzt-vm100.md) %}

{% endlist %}




Таким образом, стоимость ВМ с 20% vCPU почти в два раза ниже стоимости ВМ со 100% vCPU.


#### Операционные системы {#instance-os}

Использование операционной системы на ВМ также тарифицируется. Стоимость зависит от лицензии на операционную систему и количества вычислительных ресурсов. В том числе влияет то, какой тип использования ядра выбран для ВМ.

{{ price-per-hour-count-per-second }}


#### Использование лицензий Microsoft {#license-microsoft}

Правила использования лицензий Microsoft описаны в разделе [{#T}](../microsoft/licensing.md).


### Использование хранилища (диски, снимки и образы) {#disk}

При создании диска указывается его размер — объем блочного хранилища, которое занимает диск. На стоимость услуги влияет время между созданием и удалением диска, объем диска и тип диска, который выбирается при создании.

Диски тарифицируются независимо от того, запущена ВМ или нет.

Если вы создали образ или снимок, то хранение этого объекта оплачивается отдельно — исходя из его объема.

После удаления ВМ диски, снимки и образы продолжат тарифицироваться. Если эти ресурсы не нужны, удалите их.

Цена указывается за 1 месяц использования. Тарификация посекундная.

{% note warning %}

Диски с установленными продуктами [{{ marketplace-name }}](/marketplace) содержат идентификаторы лицензий (`product_ids`) этих продуктов.

Если вы подключили к ВМ такой диск в качестве дополнительного, то помимо платы за использование хранилища, также будет взиматься плата за использование продуктов {{ marketplace-name }}.

{% endnote %}


### Использование {{ ig-name }} {#instance-groups}

Использование компонента {{ ig-name }} не тарифицируется. Вы можете создавать группы ВМ, пользоваться хранилищем и вычислительными ресурсами в рамках [доступных лимитов](concepts/limits.md).

Все остальные услуги {{ yandex-cloud }}, например, создание ВМ или выделение внешних IP-адресов, тарифицируются обычным образом. Исходящий трафик [тарифицируется](#prices-traffic) аналогично другим сервисам.



### Использование выделенных хостов {#dedicated-hosts}

Стоимость выделенного хоста зависит от его [типа](concepts/dedicated-host.md#host-types) (модели процессора, количества ядер и оперативной памяти, количества и размера локальных SSD-дисков) и не зависит от количества ВМ, запущенных на нем.

vCPU и память ВМ, запущенных на выделенном хосте, не тарифицируются.

Использование дополнительных ресурсов, например, образов из {{ marketplace-name }} или сетевых дисков, тарифицируется обычным образом.

{{ price-per-hour-count-per-second }}

{% cut "Пример расчета стоимости выделенного хоста" %}

Работа выделенного хоста типа `intel-6338-c108-m704-n3200x6` в течение одного часа тарифицируется следующим образом:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-compute-dedicated-hosts](../_pricing_examples/compute/rub-dedicated-hosts.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-compute-dedicated-hosts](../_pricing_examples/compute/kzt-dedicated-hosts.md) %}

{% endlist %}



{% endcut %}


## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ compute-name }} предоставляет CVoS двух видов: на vCPU и RAM. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены для региона Россия](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



Все цены указаны с включением НДС.




Цена с (CVoS) доступна только для обычных ВМ.



### Вычислительные ресурсы ВМ {#prices-instance-resources}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-instance-resources.md](../_pricing/compute/rub-instance-resources.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-instance-resources.md](../_pricing/compute/kzt-instance-resources.md) %}

{% endlist %}






### Кластеры GPU {#prices-gpu-clusters}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-gpu-clusters.md](../_pricing/compute/rub-gpu-clusters.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-gpu-clusters.md](../_pricing/compute/kzt-gpu-clusters.md) %}

{% endlist %}





### Диски, снимки и образы {#prices-storage}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage.md](../_pricing/compute/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage.md](../_pricing/compute/kzt-storage.md) %}

{% endlist %}





### Файловые хранилища {#prices-nfs}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-nfs.md](../_pricing/compute/rub-nfs.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-nfs.md](../_pricing/compute/kzt-nfs.md) %}

{% endlist %}






### Вычислительные ресурсы выделенных хостов {#prices-dedicated-host}

Указываются цены за 1 vCPU, 1 ГБ RAM и 1 ГБ хранилища на локальном диске. Тарифицируются все ресурсы, доступные на выделенном хосте, вне зависимости от того, используются ли они. Например, на хосте [типа](concepts/dedicated-host.md#host-types) `intel-6338-c108-m704-n3200x6` доступны 108 vCPU, 704 ГБ RAM и 19&nbsp;200 ГБ хранилища на локальных дисках. См. пример расчета [выше](#dedicated-hosts).


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-host-resources.md](../_pricing/compute/rub-host-resources.md) %}

  {% include [rub-local-nvme.md](../_pricing/compute/rub-local-nvme.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-host-resources.md](../_pricing/compute/kzt-host-resources.md) %}

  {% include [kzt-local-nvme.md](../_pricing/compute/kzt-local-nvme.md) %}

{% endlist %}





### Программно-ускоренная сеть {#software-accelerated-network}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-network.md](../_pricing/compute/rub-network.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-network.md](../_pricing/compute/kzt-network.md) %}

{% endlist %}




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}