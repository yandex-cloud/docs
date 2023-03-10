---
editable: false
---

# Правила тарификации для {{ mch-short-name }}

Использование сервиса {{ mch-name }} тарифицируется по правилам, описанным в этом разделе.

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% if product == "yandex-cloud" %}
{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}
{% endif %}

## Из чего складывается стоимость использования {{ mch-short-name }} {#rules}

Расчет стоимости использования {{ mch-name }} учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам {{ ZK }});

* настройки и количество резервных копий;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Входящий трафик и количество запросов к гибридному хранилищу не тарифицируются.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов как для хостов {{ CH }}, так и для хостов {{ ZK }} (в соответствии с ожидаемой нагрузкой реплицирования).

{% note warning %}

В кластерах с выключенной поддержкой [{{ CK }}](./concepts/replication.md#ck) и с двумя или более хостами {{ CH }} автоматически создается 3 хоста {{ ZK }} минимального класса, которые обеспечивают репликацию и отказоустойчивость.

{% endnote %}

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост СУБД или {{ ZK }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

  {% if product == "yandex-cloud" %}* Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров на платформах Intel Broadwell и Intel Cascade Lake с тремя или более хостами, с шагом 100 ГБ.{% endif %}
    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя или более хостами, с шагом 93 ГБ.

* Размер, занимаемый резервными копиями данных хранилища на {% if product == "yandex-cloud" %}[локальных](concepts/storage.md#local-storage-features) и {% endif %}[сетевых](concepts/storage.md) дисках:

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного размера хранилища.

    * Если сумма размера БД и всех резервных копий становится больше размера хранилища кластера, тарифицируется только превышение этого размера.

   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

   * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

    Например, если в кластере есть N свободных гигабайт места, то хранение первых N гигабайт резервных копий не тарифицируется.

* Размер, занимаемый резервными копиями холодных данных [гибридного хранилища](concepts/storage.md#hybrid-storage-features):

   * Резервные копии холодных данных хранятся в том же бакете {{ objstorage-name }}, что и сами данные.

   * Объем, который занимают резервные копии, учитывается при расчете стоимости использования {{ objstorage-name }} так же, как и объем самих данных.

   * При автоматическом резервном копировании {{ mch-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты {{ CH }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b3-c1-m4`: Intel Ice Lake, 2 × 50% vCPU, 4 ГБ RAM.
* **Хранилище**: 100 ГБ на сетевых HDD-дисках.

Расчет стоимости для хостов {{ CH }}:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}3 × (2&nbsp;×&nbsp;1,7200&nbsp;₽ + 8&nbsp;×&nbsp;0,4700&nbsp;₽) = 21,6000&nbsp;₽{% endif %}
> {% if region == "int" %}3 × (2&nbsp;×&nbsp;0,013760&nbsp;$ + 8&nbsp;×&nbsp;0,003760&nbsp;$) = 0,172800&nbsp;${% endif %}
> {% if region == "kz" %}3 × (2&nbsp;×&nbsp;8,6000&nbsp;₸ + 8&nbsp;×&nbsp;2,3500&nbsp;₸) = 108,0000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}21,6000&nbsp;₽{% endif %}{% if region == "int" %}0,172800&nbsp;${% endif %}{% if region == "kz" %}108,0000&nbsp;₸{% endif %} — стоимость часа работы хостов {{ CH }}.

{% endif %}

{% if product == "cloud-il" %}

> 3 × (2&nbsp;×&nbsp;0,1659&nbsp;₪ + 8&nbsp;×&nbsp;0,0286&nbsp;₪) = 1,6818&nbsp;₪
>
> Итого: 1,6818&nbsp;₪ — стоимость часа работы хостов {{ CH }}.

{% endif %}

Где:
* 3 — количество хостов {{ CH }}.
* 2 — количество vCPU.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}1,7200&nbsp;₽{% endif %}{% if region == "int" %}0,013760&nbsp;${% endif %}{% if region == "kz" %}8,6000&nbsp;₸{% endif %}{% endif %}{% if product == "cloud-il" %}0,1659&nbsp;₪{% endif %} — стоимость часа использования 100% vCPU.
* 8 — объем RAM одного хоста {{ CH }} (в гигабайтах).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}0,4700&nbsp;₽{% endif %}{% if region == "int" %}0,003760&nbsp;${% endif %}{% if region == "kz" %}2,3500&nbsp;₸{% endif %}{% endif %}{% if product == "cloud-il" %}0,0286&nbsp;₪{% endif %} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости для хостов {{ ZK }}:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}3 × (2&nbsp;×&nbsp;0,7000&nbsp;₽ + 4&nbsp;×&nbsp;0,2800&nbsp;₽) = 7,5600&nbsp;₽{% endif %}
> {% if region == "int" %}3 × (2&nbsp;×&nbsp;0,005600&nbsp;$ + 4&nbsp;×&nbsp;0,002240&nbsp;$) = 0,060480&nbsp;${% endif %}
> {% if region == "kz" %}3 × (2&nbsp;×&nbsp;3,5000&nbsp;₸ + 4&nbsp;×&nbsp;1,4000&nbsp;₸) = 37,8000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}7,5600&nbsp;₽{% endif %}{% if region == "int" %}0,060480&nbsp;${% endif %}{% if region == "kz" %}37,8000&nbsp;₸{% endif %} — стоимость часа работы хостов {{ ZK }}.

{% endif %}

{% if product == "cloud-il" %}

> 3 × (2&nbsp;×&nbsp;0,0264&nbsp;₪ + 4&nbsp;×&nbsp;0,0164&nbsp;₪) = 0,3552&nbsp;₪
>
> Итого: 0,3552&nbsp;₪ — стоимость часа работы хостов {{ ZK }}.

{% endif %}

Где:
* 3 — количество хостов {{ ZK }}.
* 2 — количество vCPU.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}0,7000&nbsp;₽{% endif %}{% if region == "int" %}0,005600&nbsp;${% endif %}{% if region == "kz" %}3,5000&nbsp;₸{% endif %}{% endif %}{% if product == "cloud-il" %}0,0264&nbsp;₪{% endif %} — стоимость часа использования 50% vCPU.
* 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}0,2800&nbsp;₽{% endif %}{% if region == "int" %}0,002240&nbsp;${% endif %}{% if region == "kz" %}1,4000&nbsp;₸{% endif %}{% endif %}{% if product == "cloud-il" %}0,0164&nbsp;₪{% endif %} — стоимость часа использования 1 ГБ RAM на 50% vCPU.

Расчет стоимости хранилища и итоговой стоимости:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}720 × (21,6000&nbsp;₽ + 7,5600&nbsp;₽) + 100&nbsp;×&nbsp;3,2000&nbsp;₽ = 21&nbsp;315,2000&nbsp;₽{% endif %}
> {% if region == "int" %}720 × (0,172800&nbsp;$ + 0,060480&nbsp;$) + 100&nbsp;×&nbsp;0,025600&nbsp;$ = 170,521600&nbsp;${% endif %}
> {% if region == "kz" %}720 × (108,0000&nbsp;₸ + 37,8000&nbsp;₸) + 100&nbsp;×&nbsp;16,0000&nbsp;₸ = 106&nbsp;576,0000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}21&nbsp;315,2000&nbsp;₽{% endif %}{% if region == "int" %}170,521600&nbsp;${% endif %}{% if region == "kz" %}106&nbsp;576,0000&nbsp;₸{% endif %} — стоимость использования кластера в течение 30 дней.

{% endif %}

{% if product == "cloud-il" %}

> 720 × (1,6818&nbsp;₪ + 0,3552&nbsp;₪) + 100&nbsp;×&nbsp;0,1440&nbsp;₪ = 1481,0400&nbsp;₪

> Итого: 1481,0400&nbsp;₪ — стоимость использования кластера в течение 30 дней.

{% endif %}

Где:
* 720 — количество часов в 30 днях.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}21,6000&nbsp;₽{% endif %}{% if region == "int" %}0,172800&nbsp;${% endif %}{% if region == "kz" %}108,0000&nbsp;₸{% endif %}{% endif %}{% if product == "cloud-il" %}1,6818&nbsp;₪{% endif %} — стоимость часа работы хостов {{ CH }}.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}7,5600&nbsp;₽{% endif %}{% if region == "int" %}0,060480&nbsp;${% endif %}{% if region == "kz" %}37,8000&nbsp;₸{% endif %}{% endif %}{% if product == "cloud-il" %}0,3552&nbsp;₪{% endif %} — стоимость часа работы хостов {{ ZK }}.
* 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}3,2000&nbsp;₽{% endif %}{% if region == "int" %}0,025600&nbsp;${% endif %}{% if region == "kz" %}16,0000&nbsp;₸{% endif %}{% endif %}{% if product == "cloud-il" %}0,1440&nbsp;₪{% endif %} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

{% if product == "yandex-cloud" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mch-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

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

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Вычислительные ресурсы хостов {{ CH }} {#prices-clickhouse}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-host-ch.md](../_pricing/managed-clickhouse/rub-host-ch.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host-ch.md](../_pricing/managed-clickhouse/kzt-host-ch.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-host-ch.md](../_pricing/managed-clickhouse/ils-host-ch.md) %}

{% endif %}

### Вычислительные ресурсы хостов {{ ZK }} {#prices-zookeeper}


{% if product == "yandex-cloud" %}

{% note info %}

Заказать ресурсы хостов {{ ZK }} с помощью механизма CVoS невозможно.

{% endnote %}

{% if region == "ru" %}

{% include [rub-host-zoo.md](../_pricing/managed-clickhouse/rub-host-zoo.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host-zoo.md](../_pricing/managed-clickhouse/kzt-host-zoo.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host-zoo.md](../_pricing/managed-clickhouse/usd-host-zoo.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-host-zoo.md](../_pricing/managed-clickhouse/ils-host-zoo.md) %}

{% endif %}


### Хранилище и резервные копии {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/managed-clickhouse/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/managed-clickhouse/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-storage.md](../_pricing/managed-clickhouse/ils-storage.md) %}

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
