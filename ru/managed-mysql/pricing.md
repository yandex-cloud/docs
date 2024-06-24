---
title: "Правила тарификации для {{ mmy-name }}"
description: "Расчет стоимости использования {{ mmy-name }} учитывает тип диска и размер хранилища, вычислительные ресурсы, выделенные хостам кластера, настройки и количество резервных копий и объем исходящего трафика из {{ yandex-cloud }} в интернет."
editable: false
---

# Правила тарификации для {{ mmy-name }}

В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mmy-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mmy-short-name }} {#rules}

Расчет стоимости использования {{ mmy-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

В зависимости от [типа хоста](concepts/index.md) стоимость вычисляется по-разному:

* Стандартные хосты

  Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.


* Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../compute/pricing.md#prices) и наценки {{ mmy-name }} на эти ресурсы.


Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ MY }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

    * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:
                * для платформ **Intel Broadwell** и **Intel Cascade Lake** — с шагом 100 ГБ;
        * для платформы **Intel Ice Lake** — с шагом {{ local-ssd-v3-step }}.

    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).


## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mmy-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены для региона Россия {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Все цены указаны с включением НДС.



Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

От типа хостов также зависит цена на хранилище на локальных SSD-дисках (`local-ssd`).

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-hosts}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}


#### Стандартные хосты {#standard-hosts}


**Цены в час**


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [RUB: standard hosts hour](../_pricing/managed-mysql/rub-hosts-standard-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [KZT: standard hosts hour](../_pricing/managed-mysql/kzt-hosts-standard-hour.md) %}

{% endlist %}



**Цены в месяц**


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [RUB: standard hosts month](../_pricing/managed-mysql/rub-hosts-standard-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [KZT: standard hosts month](../_pricing/managed-mysql/kzt-hosts-standard-month.md) %}

{% endlist %}






#### Выделенные хосты {#dedicated-hosts}

Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../compute/pricing.md#prices) и наценки {{ mmy-name }} на эти ресурсы.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [RUB: dedicated hosts](../_pricing/managed-mysql/rub-hosts-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [KZT: dedicated hosts](../_pricing/managed-mysql/kzt-hosts-dedicated.md) %}

{% endlist %}




### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd for Ice Lake by query only](../_includes/ice-lake-local-ssd-note.md) %}


#### Стандартные хосты {#standard-hosts-storage}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage-standard.md](../_pricing/managed-mysql/rub-storage-standard.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage-standard.md](../_pricing/managed-mysql/kzt-storage-standard.md) %}

{% endlist %}

#### Выделенные хосты {#dedicated-hosts-storage}

Стоимость начисляется из двух компонентов: [цены за хранилище {{ compute-full-name }}](../compute/pricing.md#prices) и цены {{ mmy-name }} на него. Все цены указаны за 1 ГБ в месяц.

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage-dedicated.md](../_pricing/managed-mysql/rub-storage-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage-dedicated.md](../_pricing/managed-mysql/kzt-storage-dedicated.md) %}

{% endlist %}





{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
