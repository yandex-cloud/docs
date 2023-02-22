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

В зависимости от [типа хоста](../concepts/) стоимость вычисляется по-разному:

* Стандартные хосты

  Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами.

* Выделенные хосты

  Стоимость начисляется из двух компонентов: [цены за вычислительные ресурсы {{ compute-full-name }}](../../compute/pricing.md#prices) и наценки {{ mgp-name }} на эти ресурсы.

Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](../concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ GP }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров.

  * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с двумя хостами-мастерами:
    {% if product == "yandex-cloud" %}* для платформы Intel Cascade Lake — с шагом 100 ГБ;{% endif %}
    * для платформы Intel Ice Lake — с шагом {{ local-ssd-v3-step }}.
  * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с двумя хостами-мастерами, с шагом 93 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

  * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

  * При автоматическом резервном копировании {{ mgp-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

  * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if audience == "cvos" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

Сервис {{mgp-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

{% endif %}

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Стандартные хосты**: 3 хоста класса `s3-c8-m32`: Intel Ice Lake, 8 × 100% vCPU, 32 ГБ RAM.
* **Хранилище для стандартных хостов**: 100 ГБ на сетевых HDD-дисках.
* **Выделенные хосты**: 3 хоста класса `s2.medium`: Intel Cascade Lake, 8 × 100% vCPU, 32 ГБ RAM.
* **Хранилище для выделенных хостов**: 50 ГБ на локальных SSD-дисках.

Расчет стоимости для стандартных хостов:

> {% if region == "ru" %}3 × (8&nbsp;×&nbsp;2,1500&nbsp;₽ + 32&nbsp;×&nbsp;0,5700&nbsp;₽) = 106,3200&nbsp;₽{% endif %}
> {% if region == "int" %}3 × (8&nbsp;×&nbsp;0,017231&nbsp;$ + 32&nbsp;×&nbsp;0,004564&nbsp;$) = 0,851688&nbsp;${% endif %}
> {% if region == "kz" %}3 × (8&nbsp;×&nbsp;10,7500&nbsp;₸ + 32&nbsp;×&nbsp;2,8500&nbsp;₸) = 531,6000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}106,3200&nbsp;₽{% endif %}{% if region == "int" %}0,851688&nbsp;${% endif %}{% if region == "kz" %}531,6000&nbsp;₸{% endif %} — стоимость часа работы стандартных хостов.

Где:
* 3 — количество стандартных хостов.
* 8 — количество vCPU.
* {% if region == "ru" %}2,1500&nbsp;₽{% endif %}{% if region == "int" %}0,017231&nbsp;${% endif %}{% if region == "kz" %}10,7500&nbsp;₸{% endif %} — стоимость часа использования 100% vCPU.
* 32 — объем RAM одного стандартного хоста (в гигабайтах).
* {% if region == "ru" %}0,5700&nbsp;₽{% endif %}{% if region == "int" %}0,004564&nbsp;${% endif %}{% if region == "kz" %}2,8500&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости для выделенных хостов:

> {% if region == "ru" %}3 × (8&nbsp;×&nbsp;1,2000&nbsp;₽ + 32&nbsp;×&nbsp;0,3100&nbsp;₽) = 58,5600&nbsp;₽{% endif %}
> {% if region == "int" %}3 × (8&nbsp;×&nbsp;0,009595&nbsp;$ + 32&nbsp;×&nbsp;0,002538&nbsp;$) = 0,473928&nbsp;${% endif %}
> {% if region == "kz" %}3 × (8&nbsp;×&nbsp;6,0000&nbsp;₸ + 32&nbsp;×&nbsp;1,5500&nbsp;₸) = 292,8000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}58,5600&nbsp;₽{% endif %}{% if region == "int" %}0,473928&nbsp;${% endif %}{% if region == "kz" %}292,8000&nbsp;₸{% endif %} — стоимость часа работы выделенных хостов.

Где:
* 3 — количество выделенных хостов.
* 8 — количество vCPU.
* {% if region == "ru" %}1,2000&nbsp;₽{% endif %}{% if region == "int" %}0,009595&nbsp;${% endif %}{% if region == "kz" %}6,0000&nbsp;₸{% endif %} — стоимость часа использования 100% vCPU.
* 32 — объем RAM одного выделенного хоста (в гигабайтах).
* {% if region == "ru" %}0,3100&nbsp;₽{% endif %}{% if region == "int" %}0,002538&nbsp;${% endif %}{% if region == "kz" %}1,5500&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости хранилища и итоговой стоимости:

> {% if region == "ru" %}(720 × 106,3200&nbsp;₽ + 100 × 3,2000&nbsp;₽) + (720 × 58,5600&nbsp;₽ + 50 × 13,0100&nbsp;₽) = 119&nbsp;684,1000&nbsp;₽{% endif %}
> {% if region == "kz" %}(720 × 531,6000&nbsp;₸ + 100 × 16,0000&nbsp;₸) + (720 × 292,8000&nbsp;₸ + 50 × 65,0500&nbsp;₸) = 598&nbsp;420,5000&nbsp;₸{% endif %}
> {% if region == "int" %}(720 × 0,851688&nbsp;$ + 100 × 0,104080&nbsp;$) + (720 × 0,473928&nbsp;$ + 50 × 0,104080&nbsp;$) = 970&nbsp;0555&nbsp;${% endif %}
>
> Итого: {% if region == "ru" %}119&nbsp;684,1000&nbsp;₽{% endif %}{% if region == "kz" %}598&nbsp;420,5000&nbsp;₸{% endif %}{% if region == "int" %}970&nbsp;0555&nbsp;${% endif %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* {% if region == "ru" %}106,3200&nbsp;₽{% endif %}{% if region == "kz" %}531,6000&nbsp;₸{% endif %}{% if region == "int" %}0,851688&nbsp;${% endif %} — стоимость часа работы стандартных хостов.
* 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах) для стандартных хостов.
* {% if region == "ru" %}3,2000&nbsp;₽{% endif %}{% if region == "kz" %}16,0000&nbsp;₸{% endif %}{% if region == "int" %}0,104080&nbsp;${% endif %} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.
* {% if region == "ru" %}58,5600&nbsp;₽{% endif %}{% if region == "kz" %}292,8000&nbsp;₸{% endif %}{% if region == "int" %}0,473928&nbsp;${% endif %} — стоимость часа работы выделенных хостов.
* 50 — объем хранилища на локальных SSD-дисках (в гигабайтах) для выделенных хостов.
* {% if region == "ru" %}13,0100&nbsp;₽{% endif %}{% if region == "kz" %}65,0500&nbsp;₸{% endif %}{% if region == "int" %}0,104080&nbsp;${% endif %} — стоимость месяца использования 1 ГБ хранилища на локальных SSD-дисках.

## Цены {#prices}

{% if region != "int" %}

Все цены указаны с включением НДС.

{% else %}

Все цены указаны без включения НДС.

{% endif %}

Цены на хосты [вычисляются по-разному](#rules-hosts-uptime) в зависимости от выбранного типа хостов.

От типа хостов также зависит цена на хранилище на локальных SSD-дисках (`local-ssd`).

{% include [pricing-month-term](../../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {#prices-hosts}

{% list tabs %}

- Стандартные хосты

  Стоимость вычисляется по-разному в зависимости от [конфигурации хостов](../concepts/instance-types.md):

  * Для хостов i2 и i3 (`io-optimized`) стоимость складывается из цены за вычислительные ресурсы хостов {{ mgp-name }} (см. таблицу ниже) и [цены за использование программно-ускоренной сети](../../compute/pricing.md#software-accelerated-network).
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

Особенности тарификации хранилища резервных копий:

* Хранение резервных копий не тарифицируется, пока суммарный объем БД и всех резервных копий меньше общего размера хранилища.

* При [добавлении хоста-сегмента](../operations/hosts/cluster-expand.md#add-hosts) общая стоимость кластера возрастет, но расходы на хранение резервных копий сверх размера хранилища снизятся за счет увеличения общего размера хранилища.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %} {% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %} {% endif %}
{% if region == "kz" %} {% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %} {% endif %}
{% if region == "int" %} {% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %} {% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
