---
editable: false
---

# Правила тарификации для {{ mch-short-name }}

{% if product == "cloud-il" %}

{% note info %}

Цены, указанные ниже, начнут действовать 6 декабря 2022 года. До этого использование сервиса {{ mch-name }} не тарифицируется

{% endnote %}

{% endif %}

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

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

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

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

{% if product == "yandex-cloud" %}

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты {{ CH }}**: 3 хоста класса `s1.micro`: Intel Broadwell, 2 × 100% vCPU, 8 ГБ RAM.
* **Хосты {{ ZK }}** (создаются автоматически): 3 хоста класса `b2.medium`: Intel Broadwell, 2 × 50% vCPU, 4 ГБ RAM.
* **Хранилище**: 100 ГБ на сетевых HDD-дисках.

Расчет стоимости:

{% if region == "ru" %}
> 3 × (2&nbsp;×&nbsp;2,2800&nbsp;₽ + 8&nbsp;×&nbsp;0,5200&nbsp;₽) = 26,1600&nbsp;₽
{% endif %}
{% if region == "int" %}
> 3 × (2&nbsp;×&nbsp;0,018240&nbsp;$ + 8&nbsp;×&nbsp;0,004160&nbsp;$) = 0,209280&nbsp;$
{% endif %}
{% if region == "kz" %}
> 3 × (2&nbsp;×&nbsp;11,4000&nbsp;₸ + 8&nbsp;×&nbsp;2,6000&nbsp;₸) = 130,8000&nbsp;₸
{% endif %}
> 
> Итого: {% if region == "ru" %}26,1600&nbsp;₽{% endif %}{% if region == "int" %}0,209280&nbsp;${% endif %}{% if region == "kz" %}130,8000&nbsp;₸{% endif %} – стоимость часа работы хостов {{ CH }}.

Где:
* 3 — количество хостов {{ CH }}.
* 2 — количество vCPU.
* {% if region == "ru" %}2,2800&nbsp;₽{% endif %}{% if region == "int" %}0,018240&nbsp;${% endif %}{% if region == "kz" %}11,4000&nbsp;₸{% endif %} — стоимость часа использования 100% vCPU.
* 8 — объем RAM одного хоста {{ CH }} (в гигабайтах).
* {% if region == "ru" %}0,5200&nbsp;₽{% endif %}{% if region == "int" %}0,004160&nbsp;${% endif %}{% if region == "kz" %}2,6000&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

{% if region == "ru" %}
> 3 × (2&nbsp;×&nbsp;0,7800&nbsp;₽ + 4&nbsp;×&nbsp;0,3200&nbsp;₽) = 8,5200&nbsp;₽
{% endif %}
{% if region == "int" %}
> 3 × (2&nbsp;×&nbsp;0,006240&nbsp;$ + 4&nbsp;×&nbsp;0,002560&nbsp;$) = 0,068160&nbsp;$
{% endif %}
{% if region == "kz" %}
> 3 × (2&nbsp;×&nbsp;3,9000&nbsp;₸ + 4&nbsp;×&nbsp;1,6000&nbsp;₸) = 42,6000&nbsp;₸
{% endif %}
> 
> Итого: {% if region == "ru" %}8,5200&nbsp;₽{% endif %}{% if region == "int" %}0,068160&nbsp;${% endif %}{% if region == "kz" %}42,6000&nbsp;₸{% endif %} – стоимость часа работы хостов {{ ZK }}.

Где:
* 3 — количество хостов {{ ZK }}.
* 2 — количество vCPU.
* {% if region == "ru" %}0,7800&nbsp;₽{% endif %}{% if region == "int" %}0,006240&nbsp;${% endif %}{% if region == "kz" %}3,9000&nbsp;₸{% endif %} — стоимость часа использования 50% vCPU.
* 4 — объем RAM одного хоста {{ ZK }} (в гигабайтах).
* {% if region == "ru" %}0,3200&nbsp;₽{% endif %}{% if region == "int" %}0,002560&nbsp;${% endif %}{% if region == "kz" %}1,6000&nbsp;₸{% endif %} — стоимость часа использования 1 ГБ RAM на 50% vCPU.

{% if region == "ru" %}
> 720 × (26,1600&nbsp;₽ + 8,5200&nbsp;₽) + 100&nbsp;×&nbsp;3,2000&nbsp;₽ = 25&nbsp;289,6000&nbsp;₽
{% endif %}
{% if region == "int" %}
> 720 × (0,209280&nbsp;$ + 0,068160&nbsp;$) + 100&nbsp;×&nbsp;0,025600&nbsp;$ = 202,316800&nbsp;$
{% endif %}
{% if region == "kz" %}
> 720 × (130,8000&nbsp;₸ + 42,6000&nbsp;₸) + 100&nbsp;×&nbsp;16,0000&nbsp;₸ = 126&nbsp;448,0000&nbsp;₸
{% endif %}
>
> Итого: {% if region == "ru" %}25&nbsp;289,6000&nbsp;₽{% endif %}{% if region == "int" %}202,316800&nbsp;${% endif %}{% if region == "kz" %}126&nbsp;448,0000&nbsp;₸{% endif %} – стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* {% if region == "ru" %}26,1600&nbsp;₽{% endif %}{% if region == "int" %}0,209280&nbsp;${% endif %}{% if region == "kz" %}130,8000&nbsp;₸{% endif %} — стоимость часа работы хостов {{ CH }}.
* {% if region == "ru" %}8,5200&nbsp;₽{% endif %}{% if region == "int" %}0,068160&nbsp;${% endif %}{% if region == "kz" %}42,6000&nbsp;₸{% endif %} — стоимость часа работы хостов {{ ZK }}.
* 100 — размер хранилища на сетевых HDD-дисках (в гигабайтах).
* {% if region == "ru" %}3,2000&nbsp;₽{% endif %}{% if region == "int" %}0,025600&nbsp;${% endif %}{% if region == "kz" %}16,0000&nbsp;₸{% endif %} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

{% endif %}

{% if product == "yandex-cloud" %}
## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mch-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

{% endif %}
## Цены {% if product == "cloud-il" %}c 6 декабря 2022 года{% endif %}{#prices}

{% if region != "int" %}

Все цены указаны с включением НДС.

{% else %}

Все цены указаны без включения НДС.

{% endif %}

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
