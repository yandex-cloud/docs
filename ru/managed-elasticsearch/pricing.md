---
editable: false
---

# Правила тарификации для Managed Service for Elasticsearch

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## Из чего складывается стоимость использования {{ mes-short-name }} {#rules}

Расчет стоимости использования {{ mes-name }} учитывает:

* используемую редакцию {{ ES }};

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам с ролью `Master node`);

* тип и объем хранилища (дискового пространства);

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами и используемой редакцией {{ ES }}. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов как для хостов с ролью `Data node`, так и для хостов с ролью `Master node`.

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ ES }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается объем хранилища, выделенный для кластеров. Цена указывается за 1 месяц использования.  Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if audience == "draft" %}  

{% if region == "ru"%}

### Пример расчета стоимости кластера {#example}

Например, вы создали кластер:

* с 3 хостами c ролью `Data node` класса `s2.micro` (2 vCPU, 8 ГБ RAM),
* с 3  хостами с ролью `Master node` класса `s2.micro` (2 vCPU, 8 ГБ RAM).
* c 100 ГБ стандартного сетевого хранилища.

Стоимость часа работы хостов: `3 × (2 × 1,05 ₽ + 8 × 0,28 ₽) + 3 × (2 × 0,49 ₽ + 4 × 0,20 ₽) = 18,36 ₽`

Общая стоимость кластера в месяц (хосты и хранилище): `720 × 18,36 ₽ + 100 × 2,2881 ₽ = 13 448,01 ₽`

{% endif %}

{% endif %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на год или на три года вперед.

Сервис {{mes-name}} предоставляет CVoS четырех видов:

* на vCPU;
* на RAM для редакции BASIC;
* на RAM для редакции GOLD;
* на RAM для редакции PLATINUM. 

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов. {% if audience != "internal" %}Чтобы подключить  CVoS, обратитесь в [техническую поддержку](../support/overview.md).
 
Подробнее о механизме работы CVoS читайте в [документации Биллинга](../billing/concepts/cvos.md).{% endif %}

{% note info %}

Объем хранилища и интернет-трафика заказать по схеме CVoS невозможно. 

{% endnote %}


## Цены {#prices}

{% if region == "ru" %}

{% include notitle [rub-hosts-and-storage.md](../_pricing/managed-elasticsearch/rub-hosts-and-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-hosts-and-storage.md](../_pricing/managed-elasticsearch/kzt-hosts-and-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-hosts-and-storage.md](../_pricing/managed-elasticsearch/usd-hosts-and-storage.md) %}

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


## Расчетные цены для классов хостов {#calculated-host-price}

Цены за время работы хостов рассчитаны исходя из конфигураций [классов хостов](concepts/instance-types.md) и приведенных выше цен за использование vCPU и RAM для соответствующей платформы. Чтобы точно рассчитать стоимость нужного кластера, воспользуйтесь [калькулятором](https://cloud.yandex.ru/services/managed-elasticsearch#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% if region == "ru" %}

{% include notitle [rub-calculated.md](../_pricing/managed-elasticsearch/rub-calculated.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-calculated.md](../_pricing/managed-elasticsearch/kzt-calculated.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-calculated.md](../_pricing/managed-elasticsearch/usd-calculated.md) %}

{% endif %}
