---
editable: false
---

# Правила тарификации для {{ mmy-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## Из чего складывается стоимость использования {{ mmy-short-name }} {#rules}

Расчет стоимости использования {{ mmy-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ MY }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более, с шагом 100 ГБ.
    * Хранилище на нереплицируемых сетевых дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).


## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{mmy-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены {#prices}

Все цены указаны с включением НДС.

### Вычислительные ресурсы хостов {#prices-hosts}

{% if region == "ru"%}

{% include [rub-host.md](../_pricing/managed-mysql/rub-host.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-host.md](../_pricing/managed-mysql/kzt-host.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-host.md](../_pricing/managed-mysql/usd-host.md) %}

{% endif %}

### Хранилище и резервные копии {#prices-storage}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/managed-mysql/rub-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-storage.md](../_pricing/managed-mysql/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/managed-mysql/usd-storage.md) %}

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

Цены за время работы хостов рассчитаны исходя из конфигураций [классов хостов](concepts/instance-types.md) и приведенных выше цен за использование vCPU и RAM для соответствующей платформы. Чтобы точно рассчитать стоимость нужного кластера, воспользуйтесь [калькулятором](https://cloud.yandex.ru/services/managed-mysql#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

Все цены указаны с включением НДС.

{% list tabs %}

- За месяц работы хоста

  Из расчета 720 часов в месяц, округлено до целых рублей.

  {% if region == "ru" %}

  {% include notitle [rub-classes-month.md](../_pricing/managed-mysql/rub-classes-month.md) %}

  {% endif %}

  {% if region == "kz" %}

  {% include notitle [kzt-classes-month.md](../_pricing/managed-mysql/kzt-classes-month.md) %}

  {% endif %}

  {% if region == "int" %}

  {% include notitle [usd-classes-month.md](../_pricing/managed-mysql/usd-classes-month.md) %}

  {% endif %}

- За 1 час работы хоста

  {% if region == "ru" %}

  {% include notitle [rub-classes-hour.md](../_pricing/managed-mysql/rub-classes-hour.md) %}

  {% endif %}

  {% if region == "kz" %}

  {% include notitle [kzt-classes-hour.md](../_pricing/managed-mysql/kzt-classes-hour.md) %}

  {% endif %}

  {% if region == "int" %}

  {% include notitle [usd-classes-hour.md](../_pricing/managed-mysql/usd-classes-hour.md) %}

  {% endif %}

{% endlist %}

