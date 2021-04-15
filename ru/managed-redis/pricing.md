---
editable: false
---

# Правила тарификации для {{ mrd-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}


## Из чего складывается стоимость использования {{ mrd-short-name }} {#rules}

Расчет стоимости использования {{ mrd-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы хоста равна стоимости 2 часов). Время, когда хост {{ RD }} не может выполнять свои основные функции, не тарифицируется.


### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем диска, выделенный для кластеров БД.

* Объем, занимаемый резервными копиями баз данных сверх запрошенного размера дисков для кластера.

    * Резервные копии хранятся бесплатно, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.
    * Запрошенный размер диска выделяется для каждого хоста, поэтому количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mrd-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены {#prices}

Все цены указаны с включением НДС.

### Вычислительные ресурсы хостов {#prices-hosts}

{% if region == "ru"%}

{% include [rub-host.md](../_pricing/managed-redis/rub-host.md) %}

{% endif %}

{% if region == "pre-kz"%}

{% include [kzt-host.md](../_pricing/managed-redis/kzt-host.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-host.md](../_pricing/managed-redis/usd-host.md) %}

{% endif %}

### Хранилище и резервные копии {#prices-storage}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/managed-redis/rub-storage.md) %}

{% endif %}

{% if region == "pre-kz"%}

{% include [kzt-storage.md](../_pricing/managed-redis/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/managed-redis/usd-storage.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

## Расчетные цены для конфигураций хостов {#calculated-prices}

Цены за время работы хостов рассчитаны исходя из [конфигураций хостов](concepts/instance-types.md) и приведенных выше цен за использование RAM. Чтобы точно рассчитать стоимость нужного кластера, воспользуйтесь [калькулятором](https://cloud.yandex.ru/services/managed-redis#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% if region == "ru"%}

{% include [rub-class.md](../_pricing/managed-redis/rub-class.md) %}

{% endif %}

{% if region == "pre-kz"%}

{% include [kzt-class.md](../_pricing/managed-redis/kzt-class.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-class.md](../_pricing/managed-redis/usd-class.md) %}

{% endif %}
