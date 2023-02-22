---
title: "Правила тарификации для {{ mmy-name }}"
description: "Расчет стоимости использования {{ mmy-name }} учитывает тип диска и размер хранилища, вычислительные ресурсы, выделенные хостам кластера, настройки и количество резервных копий и объем исходящего трафика из {{ yandex-cloud }} в интернет."
editable: false
---

# Правила тарификации для {{ mmy-name }}

Использование сервиса {{ mmy-name }} тарифицируется по правилам, описанным в этом разделе.

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mmy-short-name }} {#rules}

Расчет стоимости использования {{ mmy-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

{% if product == "cloud-il" %}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

{% endif %}

{% if product == "yandex-cloud" %}

В зависимости от [типа хоста](concepts/index.md) стоимость вычисляется по-разному:

* Стандартные хосты

  Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.

* Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../compute/pricing.md#prices) и наценки {{ mmy-name }} на эти ресурсы.

Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

{% endif %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ MY }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

    {% if product == "yandex-cloud" %}

    * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:
        * для платформ **Intel Broadwell** и **Intel Cascade Lake** — с шагом 100 ГБ;
        * для платформы **Intel Ice Lake** — с шагом {{ local-ssd-v3-step }}.

    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

    {% endif %}

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if product == "yandex-cloud" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mmy-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

{% endif %}

## Цены {#prices}

{% if region != "int" %}

Все цены указаны с включением НДС.

{% else %}

Все цены указаны без включения НДС.

{% endif %}

Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

От типа хостов также зависит цена на хранилище на локальных SSD-дисках (`local-ssd`).

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-hosts}

{% if product == "yandex-cloud" %}

{% list tabs %}

- Стандартные хосты

    {% if region == "ru" %} {% include [RUB: standard hosts](../_pricing/managed-mysql/rub-hosts-standard.md) %} {% endif %}
    {% if region == "kz" %} {% include [KZT: standard hosts](../_pricing/managed-mysql/kzt-hosts-standard.md) %} {% endif %}
    {% if region == "int" %} {% include [USD: standard hosts](../_pricing/managed-mysql/usd-hosts-standard.md) %} {% endif %}

- Выделенные хосты

    Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../compute/pricing.md#prices) и наценки {{ mmy-name }} на эти ресурсы.

    {% if region == "ru" %} {% include [RUB: dedicated hosts](../_pricing/managed-mysql/rub-hosts-dedicated.md) %} {% endif %}
    {% if region == "kz" %} {% include [KZT: dedicated hosts](../_pricing/managed-mysql/kzt-hosts-dedicated.md) %} {% endif %}
    {% if region == "int" %} {% include [USD: dedicated hosts](../_pricing/managed-mysql/usd-hosts-dedicated.md) %} {% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-host.md](../_pricing/managed-mysql/ils-host.md) %}

{% endif %}

### Хранилище и резервные копии {#prices-storage}

{% if product == "yandex-cloud" %}

{% list tabs %}

- Стандартные хосты

    {% include [local-ssd для Ice Lake только по запросу](../_includes/ice-lake-local-ssd-note.md) %}

    {% if region == "ru" %} {% include [rub-storage-standard.md](../_pricing/managed-mysql/rub-storage-standard.md) %} {% endif %}
    {% if region == "kz" %} {% include [kzt-storage-standard.md](../_pricing/managed-mysql/kzt-storage-standard.md) %} {% endif %}
    {% if region == "int" %} {% include [usd-storage-standard.md](../_pricing/managed-mysql/usd-storage-standard.md) %} {% endif %}

- Выделенные хосты

    Стоимость начисляется из двух компонентов: [цены за хранилище {{ compute-full-name }}](../compute/pricing.md#prices) и цены {{ mmy-name }} на него. Все цены указаны за 1 ГБ в месяц.

    {% if region == "ru" %} {% include [rub-storage-dedicated.md](../_pricing/managed-mysql/rub-storage-dedicated.md) %} {% endif %}
    {% if region == "kz" %} {% include [kzt-storage-dedicated.md](../_pricing/managed-mysql/kzt-storage-dedicated.md) %} {% endif %}
    {% if region == "int" %} {% include [usd-storage-dedicated.md](../_pricing/managed-mysql/usd-storage-dedicated.md) %} {% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-storage.md](../_pricing/managed-mysql/ils-storage.md) %}

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
