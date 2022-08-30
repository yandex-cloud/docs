---
editable: false
---

# Правила тарификации для {{ mgp-name }}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [pricing-status](../../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning](../../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mgp-short-name }} {#rules}

Расчет стоимости использования {{ mgp-name }} учитывает:

* тип диска и размер хранилища;
* вычислительные ресурсы, выделенные хостам кластера, и тип хостов;
* настройки и количество резервных копий;
* объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](../concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

В зависимости от [типа хоста](../concepts/) стоимость вычисляется по-разному:

* Стандартные хосты

  Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.

{% if product == "yandex-cloud" %}

* Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../../compute/pricing.md#prices) и наценки {{ mgp-name }} на эти ресурсы.

{% endif %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ GP }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров.

  * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с двумя хостами-мастерами:
    {% if product == "yandex-cloud" %}* для платформы Intel Cascade Lake — с шагом 100 ГБ;{% endif %}
    * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.
  * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с двумя хостами-мастерами, с шагом 93 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

  * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

  * При автоматическом резервном копировании {{ mgp-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

  * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if audience == "cvos" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

Сервис {{mgp-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

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

### Вычислительные ресурсы хостов {#prices-hosts}

{% list tabs %}

- Стандартные хосты

  Стоимость вычисляется по-разному в зависимости от [конфигурации хостов](../concepts/instance-types.md):

  * Для хостов i2 и i3 (`io-optimized`) стоимость складывается из цены за вычислительные ресурсы хостов {{ mgp-name }} (см. таблицу ниже) и [цены за использование программно-ускоренной сети](../../compute/pricing#software-accelerated-network).
  * Для хостов других конфигураций оплачиваются только их вычислительные ресурсы:

  {% if region == "ru" %} {% include notitle [RUB: standard hosts](../../_pricing/managed-greenplum/rub-hosts-standard.md) %}{% endif %}
  {% if region == "kz" %} {% include notitle [KZT: standard hosts](../../_pricing/managed-greenplum/kzt-hosts-standard.md) %}{% endif %}
  {% if region == "int" %} {% include notitle [USD: standard hosts](../../_pricing/managed-greenplum/usd-hosts-standard.md) %}{% endif %}

{% if product == "yandex-cloud" %}

- Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../../compute/pricing.md#prices) и наценки {{ mgp-name }} на эти ресурсы.

  {% if region == "ru" %} {% include notitle [RUB: dedicated hosts](../../_pricing/managed-greenplum/rub-hosts-dedicated.md) %}{% endif %}
  {% if region == "kz" %} {% include notitle [KZT: dedicated hosts](../../_pricing/managed-greenplum/kzt-hosts-dedicated.md) %}{% endif %}
  {% if region == "int" %} {% include notitle [USD: dedicated hosts](../../_pricing/managed-greenplum/usd-hosts-dedicated.md) %}{% endif %}

{% endif %}

{% endlist %}

### Хранилище и резервные копии {#prices-storage}

{% list tabs %}

- Стандартные хосты

  {% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

  {% if region == "ru" %}{% include notitle [rub-storage-standard.md](../../_pricing/managed-greenplum/rub-storage-standard.md) %}{% endif %}
  {% if region == "kz" %}{% include notitle [kzt-storage-standard.md](../../_pricing/managed-greenplum/kzt-storage-standard.md) %}{% endif %}
  {% if region == "int" %}{% include notitle [usd-storage-standard.md](../../_pricing/managed-greenplum/usd-storage-standard.md) %}{% endif %}

{% if product == "yandex-cloud" %}

- Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за хранилище {{ compute-full-name }}](../../compute/pricing.md#prices) и цены {{ mgp-name }} на него. Все цены указаны за 1 ГБ в месяц.

  {% if region == "ru" %}{% include notitle [rub-storage-dedicated.md](../../_pricing/managed-greenplum/rub-storage-dedicated.md) %}{% endif %}
  {% if region == "kz" %}{% include notitle [kzt-storage-dedicated.md](../../_pricing/managed-greenplum/kzt-storage-dedicated.md) %}{% endif %}
  {% if region == "int" %}{% include notitle [usd-storage-dedicated.md](../../_pricing/managed-greenplum/usd-storage-dedicated.md) %}{% endif %}

{% endif %}

{% endlist %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %} {% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %} {% endif %}
{% if region == "kz" %} {% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %} {% endif %}
{% if region == "int" %} {% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %} {% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
