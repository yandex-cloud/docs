# Правила тарификации для {{ compute-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: _assets/icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=2362f8e07ee5#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: _assets/icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn22pas77ftg9h3f2djj%2Cdn28okfvqh19eiue6l2m
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: _assets/icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.


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

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование пулов резервов ВМ {#pool}

_Функциональность пулов резервов ВМ находится на [стадии Preview](../overview/concepts/launch-stages.md)._

В стоимость использования [пулов резервов ВМ](concepts/reserved-pools.md) входит плата за весь свободный объем зарезервированных [вычислительных ресурсов ВМ](#prices-instance-resources), [кластеров GPU](#prices-gpu-clusters) и [программно ускоренных сетей](#software-accelerated-network).

В рамках пула тарифицируются слоты в [статусе](concepts/reserved-pools.md#slot-stats) `available`, а слоты в статусе `used` [тарифицируются как обычные ВМ](#instance). То есть, если вы привязываете ВМ к пулу, она продолжает тарифицироваться отдельно, но при этом занимает часть вычислительных ресурсов пула. Соответственно, плата за использование пула уменьшается. При исключении ВМ из пула вычислительные ресурсы высвобождаются, а плата за его использование увеличивается.

Слоты в статусах `unavailable` и `pending` не тарифицируются.

### Использование виртуальных машин {#instance}

Стоимость машины зависит от выделенных вычислительных ресурсов, операционной системы и времени использования. Подключаемые диски и использование сети оплачиваются отдельно.

Стоимость рассчитывается за время использования виртуальной машины, начиная с момента запуска (перехода в статус `RUNNING`) и до полной остановки. Время, которое ВМ была выключена, не тарифицируется.

ВМ автоматически запускается после создания.

При создании ВМ можно указать публичный IP-адрес для нее.

О тарифах за использование внешнего IP-адреса читайте в разделе [{#T}](../vpc/pricing.md) документации сервиса {{ vpc-full-name }}.


#### Вычислительные ресурсы {#instance-resources}

При создании ВМ указывается количество ядер процессора (vCPU), количество графических ускорителей ([GPU](concepts/gpus.md)), базовый уровень производительности ядра и объем оперативной памяти (RAM) в ГБ. Подробнее читайте в разделе [{#T}](concepts/performance-levels.md).

Базовый уровень производительности ядра зависит от выбранной [платформы](concepts/vm-platforms.md).

_{{ price-per-hour-count-per-second }}_


#### Пример расчета стоимости вычислительных ресурсов {#instance-resources-example}

Сравним стоимость ВМ для [платформы](concepts/vm-platforms.md) Intel Ice Lake с разным [уровнем производительности vCPU](concepts/performance-levels.md).

Созданы две ВМ с операционной системой Linux:
* 2 × 20% vCPU и 2 ГБ RAM.
* 2 × 100% vCPU и 2 ГБ RAM.

Обе ВМ работали в течение 30 дней.

**Расчет стоимости для ВМ с 20% vCPU**:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 720 × (2 × {{ sku|RUB|compute.vm.cpu.c20.v3|string }} + 2 × {{ sku|RUB|compute.vm.ram.v3|string }}) = {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|compute.vm.cpu.c20.v3|number }} + 2 × {{ sku|RUB|compute.vm.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|compute.vm.cpu.c20.v3|number }} + 2 × {{ sku|RUB|compute.vm.ram.v3|number }}) %} — стоимость использования ВМ с 2 × 20% vCPU и 2 ГБ RAM в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 2 — количество ядер 20% vCPU.
  * {{ sku|RUB|compute.vm.cpu.c20.v3|string }} — стоимость часа использования 20% vCPU.
  * 2 — объем RAM (в гигабайтах).
  * {{ sku|RUB|compute.vm.ram.v3|string }} — стоимость часа использования 1 ГБ RAM.

- Расчет в тенге {#prices-kzt}

  > 720 × (2 × {{ sku|KZT|compute.vm.cpu.c20.v3|string }} + 2 × {{ sku|KZT|compute.vm.ram.v3|string }}) = {% calc [currency=KZT] 720 × (2 × {{ sku|KZT|compute.vm.cpu.c20.v3|number }} + 2 × {{ sku|KZT|compute.vm.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 720 × (2 × {{ sku|KZT|compute.vm.cpu.c20.v3|number }} + 2 × {{ sku|KZT|compute.vm.ram.v3|number }}) %} — стоимость использования ВМ с 2 × 20% vCPU и 2 ГБ RAM в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 2 — количество ядер 20% vCPU.
  * {{ sku|KZT|compute.vm.cpu.c20.v3|string }} — стоимость часа использования 20% vCPU.
  * 2 — объем RAM (в гигабайтах).
  * {{ sku|KZT|compute.vm.ram.v3|string }} — стоимость часа использования 1 ГБ RAM.

{% endlist %}




**Расчет стоимости для ВМ со 100% vCPU**:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 720 × (2 × {{ sku|RUB|compute.vm.cpu.c100.v3|string }} + 2 × {{ sku|RUB|compute.vm.ram.v3|string }}) = {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|RUB|compute.vm.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|RUB|compute.vm.ram.v3|number }}) %} — стоимость использования ВМ с 2 × 100% vCPU и 2 ГБ RAM в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 2 — количество ядер 100% vCPU.
  * {{ sku|RUB|compute.vm.cpu.c100.v3|string }} — стоимость часа использования 100% vCPU.
  * 2 — объем RAM (в гигабайтах).
  * {{ sku|RUB|compute.vm.ram.v3|string }} — стоимость часа использования 1 ГБ RAM.

- Расчет в тенге {#prices-kzt}

  > 720 × (2 × {{ sku|KZT|compute.vm.cpu.c100.v3|string }} + 2 × {{ sku|KZT|compute.vm.ram.v3|string }}) = {% calc [currency=KZT] 720 × (2 × {{ sku|KZT|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|KZT|compute.vm.ram.v3|number }}) %}
  >
  > Итого: {% calc [currency=KZT] 720 × (2 × {{ sku|KZT|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|KZT|compute.vm.ram.v3|number }}) %} — стоимость использования ВМ с 2 × 100% vCPU и 2 ГБ RAM в течение 30 дней.
  
  Где:
  * 720 — количество часов в 30 днях.
  * 2 — количество ядер 100% vCPU.
  * {{ sku|KZT|compute.vm.cpu.c100.v3|string }} — стоимость часа использования 100% vCPU.
  * 2 — объем RAM (в гигабайтах).
  * {{ sku|KZT|compute.vm.ram.v3|string }} — стоимость часа использования 1 ГБ RAM.

{% endlist %}




Таким образом, стоимость ВМ с 20% vCPU почти в два раза ниже стоимости ВМ со 100% vCPU.


#### Операционные системы {#instance-os}

Использование операционной системы на ВМ также тарифицируется. Стоимость зависит от лицензии на операционную систему и количества вычислительных ресурсов. В том числе влияет то, какой тип использования ядра выбран для ВМ.

_{{ price-per-hour-count-per-second }}_


#### Использование лицензий Microsoft {#license-microsoft}

Правила использования лицензий Microsoft описаны в разделе [{#T}](../microsoft/licensing.md).


### Использование хранилища (диски, снимки и образы) {#disk}

При создании диска указывается его размер — объем блочного хранилища, которое занимает диск. На стоимость услуги влияет время между созданием и удалением диска, объем диска и тип диска, который выбирается при создании.

Диски тарифицируются независимо от того, запущена ВМ или нет.

Если вы создали образ или снимок, то хранение этого объекта оплачивается отдельно — исходя из его объема.

После удаления ВМ диски, снимки и образы продолжат тарифицироваться. Если эти ресурсы не нужны, удалите их.

_{{ price-per-hour-count-per-second }}_

{% note warning %}

Диски с установленными продуктами [{{ marketplace-name }}](https://yandex.cloud/ru/marketplace) содержат идентификаторы лицензий (`product_ids`) этих продуктов.

Если вы подключили к ВМ такой диск в качестве дополнительного, то помимо платы за использование хранилища, также будет взиматься плата за использование продуктов {{ marketplace-name }}.

{% endnote %}


#### Пример расчета стоимости хранения снимков {#snapshot-example}

Рассчитаем стоимость хранения снимка объемом 20 ГБ в течение 60 дней.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 1440 × 20 × {{ sku|RUB|compute.snapshot|string }} = {% calc [currency=RUB] 1440 × 20 × {{ sku|RUB|compute.snapshot|number }} %}
  >
  > Итого: {% calc [currency=RUB] 1440 × 20 × {{ sku|RUB|compute.snapshot|number }} %} — стоимость хранения снимка объемом 20 ГБ в течение 60 дней.
  
  Где:
  * 1440 — количество часов в 60 днях.
  * 20 — объем снимка (в ГБ).
  * {{ sku|RUB|compute.snapshot|string }} — стоимость хранения 1 ГБ снимка в час.

- Расчет в тенге {#prices-kzt}

  > 1440 × 20 × {{ sku|KZT|compute.snapshot|string }} = {% calc [currency=KZT] 1440 × 20 × {{ sku|KZT|compute.snapshot|number }} %}
  >
  > Итого: {% calc [currency=KZT] 1440 × 20 × {{ sku|KZT|compute.snapshot|number }} %} — стоимость хранения снимка объемом 20 ГБ в течение 60 дней.
  
  Где:
  * 1440 — количество часов в 60 днях.
  * 20 — объем снимка (в ГБ).
  * {{ sku|KZT|compute.snapshot|string }} — стоимость хранения 1 ГБ снимка в час.

{% endlist %}





### Использование {{ ig-name }} {#instance-groups}

Использование компонента {{ ig-name }} не тарифицируется. Вы можете создавать группы ВМ, пользоваться хранилищем и вычислительными ресурсами в рамках [доступных лимитов](concepts/limits.md).

Все остальные услуги {{ yandex-cloud }}, например, создание ВМ или выделение внешних IP-адресов, тарифицируются обычным образом. Исходящий трафик [тарифицируется](#prices-traffic) аналогично другим сервисам.



### Использование выделенных хостов {#dedicated-hosts}

Стоимость выделенного хоста зависит от его [типа](concepts/dedicated-host.md#host-types) (модели процессора, количества ядер и оперативной памяти, количества и размера локальных SSD-дисков) и не зависит от количества ВМ, запущенных на нем.

vCPU и память ВМ, запущенных на выделенном хосте, не тарифицируются.

Использование дополнительных ресурсов, например, образов из {{ marketplace-name }} или сетевых дисков, тарифицируется обычным образом.

_{{ price-per-hour-count-per-second }}_

{% cut "Пример расчета стоимости выделенного хоста" %}

Работа выделенного хоста типа `intel-6338-c108-m704-n3200x6` в течение одного часа тарифицируется следующим образом:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  | Ресурс | Стоимость за час | Доступно | Итого |
  | --- | --- | --- | ---: |
  | vCPU | {{ sku|RUB|compute.hostgroup.cpu.c100.v3|string }}/vCPU | 108 vCPU | {% calc [currency=RUB] {{ sku|RUB|compute.hostgroup.cpu.c100.v3|number }} × 108 %} |
  | RAM | {{ sku|RUB|compute.hostgroup.ram.v3|string }}/ГБ | 704 ГБ | {% calc [currency=RUB] {{ sku|RUB|compute.hostgroup.ram.v3|number }} × 704 %} |
  | Диск | {{ sku|RUB|compute.hostgroup.localssd.v1|string }}/ГБ | 19&nbsp;200 ГБ | {% calc [currency=RUB] {{ sku|RUB|compute.hostgroup.localssd.v1|number }} × 19200 %} |
  | | | **Итого** | **{% calc [currency=RUB] {{ sku|RUB|compute.hostgroup.cpu.c100.v3|number }} × 108 + {{ sku|RUB|compute.hostgroup.ram.v3|number }} × 704 + {{ sku|RUB|compute.hostgroup.localssd.v1|number }} × 19200 %}** |

- Расчет в тенге {#prices-kzt}

  | Ресурс | Стоимость за час | Доступно | Итого |
  | --- | --- | --- | ---: |
  | vCPU | {{ sku|KZT|compute.hostgroup.cpu.c100.v3|string }}/vCPU | 108 vCPU | {% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.cpu.c100.v3|number }} × 108 %} |
  | RAM | {{ sku|KZT|compute.hostgroup.ram.v3|string }}/ГБ | 704 ГБ | {% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.ram.v3|number }} × 704 %} |
  | Диск | {{ sku|KZT|compute.hostgroup.localssd.v1|string }}/ГБ | 19&nbsp;200 ГБ | {% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.localssd.v1|number }} × 19200 %} |
  | | | **Итого** | **{% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.cpu.c100.v3|number }} × 108 + {{ sku|KZT|compute.hostgroup.ram.v3|number }} × 704 + {{ sku|KZT|compute.hostgroup.localssd.v1|number }} × 19200 %}** |

{% endlist %}



{% endcut %}


### Использование программно ускоренной сети {#software-accelerated-network}

[Программно ускоренная сеть](concepts/software-accelerated-network.md) в {{ compute-name }} обеспечивается дополнительными ядрами vCPU, за которые взимается плата. Количество дополнительных ядер в зависимости от платформы и количества ядер ВМ приведено в таблице ниже:


#|
|| **Платформа** | **Количество vCPU у ВМ** | **Количество дополнительных vCPU** 
**для программно ускоренной сети** ||
|| Intel Broadwell | меньше 18 | 2 ||
|| ^ | 18 и больше | 4 ||
|| Intel Cascade Lake | меньше 20 | 2 ||
|| ^ | 20 и больше | 4 ||
|| Intel Ice Lake | меньше 36 | 2 ||
|| ^ | 36 и больше | 4 ||
|| Intel Ice Lake (Compute Optimized) | меньше 16 | 2 ||
|| ^ | 16 и больше | 4 ||
|| AMD Zen 3 | меньше 96 | 2 ||
|| ^ | 96 и больше | 4 ||
|| AMD Zen 4 | меньше 96 | 2 ||
|| ^ | 96 и больше | 4 ||
|| AMD Zen 4 (Compute-Optimized) | меньше 48 | 2 ||
|| ^ | 48 и больше | 4 ||
|#



## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на 6 месяцев или 1 год вперед. Чтобы посмотреть ресурсы, для которых можно получить такую скидку:

1. Перейдите в раздел [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}).
1. Нажмите на нужный платежный аккаунт.
1. Выберите раздел ![image](../_assets/console-icons/lock.svg) **{{ ui-key.yacloud_billing.billing.account.switch_offers }}** в меню слева.

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов.  Подробнее о механизме работы CVoS читайте в [документации сервиса {{ billing-name }}](../billing/concepts/cvos.md).

Сервис {{ compute-name }} предоставляет CVoS двух видов: на vCPU и RAM. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

Для ресурсов, доступных по схеме CVoS, в разделе [Цены для региона Россия](#prices) представлены отдельные цены с пометкой CVoS и указанием срока резервирования.

Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

_{{ price-per-hour-count-per-second }}_


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


Доступ к платформам Gen2 и AMD Zen 3 предоставляется по запросу, при наличии технической возможности.

Для выделенных хостов указываются цены за 1 vCPU, 1 ГБ RAM и 1 ГБ хранилища на локальном диске. Тарифицируются все ресурсы, доступные на выделенном хосте, вне зависимости от того, используются ли они. Например, на хосте [типа](concepts/dedicated-host.md#host-types) `intel-6338-c108-m704-n3200x6` доступны 108 vCPU, 704 ГБ RAM и 19&nbsp;200 ГБ хранилища на локальных дисках. См. пример расчета [выше](#dedicated-hosts).



| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }} по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |