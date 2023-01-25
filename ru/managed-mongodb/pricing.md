---
editable: false
---

# Правила тарификации для {{ mmg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mmg-short-name }} {#rules}

Расчет стоимости использования {{ mmg-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с выделенными для него вычислительными ресурсами. Поддерживаемые конфигурации ресурсов приведены в разделе [{#T}](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ MG }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя или более хостами, с шагом 93 ГБ.

  {% if product == "yandex-cloud" %}* Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров на платформах Intel Broadwell и Intel Cascade Lake с тремя или более хостами, с шагом 100 ГБ.{% endif %}

   Подробнее об ограничениях хранилища, связанных с платформой, см. в разделе [{#T}](./concepts/storage.md).

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного размера хранилища.

    * При автоматическом резервном копировании {{ mmg-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на размер хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования и формируется из расчета 720 часов в месяц.  Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты {{ MG }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM{% if region == "ru" %} в редакции `Community Edition`{% endif %}.
* **Хранилище**: 100 ГБ на сетевых HDD-дисках.

Расчет стоимости для хостов {{ MG }}:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}3 × (2&nbsp;×&nbsp;1,6000&nbsp;₽ + 8&nbsp;×&nbsp;0,9000&nbsp;₽) = 31,2000&nbsp;₽{% endif %}
> {% if region == "int" %}3 × (2&nbsp;×&nbsp;0,012800&nbsp;$ + 8&nbsp;×&nbsp;0,007200&nbsp;$) = 0,249600&nbsp;${% endif %}
> {% if region == "kz" %}3 × (2&nbsp;×&nbsp;8,0000&nbsp;₸ + 8&nbsp;×&nbsp;4,5000&nbsp;₸) = 156,0000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}31,2000&nbsp;₽{% endif %}{% if region == "int" %}0,249600&nbsp;${% endif %}{% if region == "kz" %}156,0000&nbsp;₸{% endif %} — стоимость часа работы хостов {{ MG }}.

{% endif %}

Где:
* 3 — количество хостов {{ MG }}.
* 2 — количество vCPU.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}1,6000&nbsp;₽{% endif %}{% if region == "int" %}0,012800&nbsp;${% endif %}{% if region == "kz" %}8,0000&nbsp;₸{% endif %}{% endif %} — стоимость часа использования 100% vCPU.
* 8 — объем RAM одного хоста {{ MG }} (в гигабайтах).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}0,9000&nbsp;₽{% endif %}{% if region == "int" %}0,007200&nbsp;${% endif %}{% if region == "kz" %}4,5000&nbsp;₸{% endif %}{% endif %} — стоимость часа использования 1 ГБ RAM на 100% vCPU.

Расчет стоимости хранилища и итоговой стоимости:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}720 × 31,2000&nbsp;₽ + 100&nbsp;×&nbsp;3,2000&nbsp;₽ = 22&nbsp;784,0000&nbsp;₽{% endif %}
> {% if region == "int" %}720 × 0,249600&nbsp;$ + 100&nbsp;×&nbsp;0,025600&nbsp;$ = 182,272000&nbsp;${% endif %}
> {% if region == "kz" %}720 × 156,0000&nbsp;₸ + 100&nbsp;×&nbsp;16,0000&nbsp;₸ = 113&nbsp;920,0000&nbsp;₸{% endif %}
>
> Итого: {% if region == "ru" %}22&nbsp;784,0000&nbsp;₽{% endif %}{% if region == "int" %}182,272000&nbsp;${% endif %}{% if region == "kz" %}113&nbsp;920,0000&nbsp;₸{% endif %} — стоимость использования кластера в течение 30 дней.

{% endif %}

Где:
* 720 — количество часов в 30 днях.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}31,2000&nbsp;₽{% endif %}{% if region == "int" %}0,249600&nbsp;${% endif %}{% if region == "kz" %}156,0000&nbsp;₸{% endif %}{% endif %} — стоимость часа работы хостов {{ MG }}.
* 100 — объем хранилища на сетевых HDD-дисках (в гигабайтах).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}3,2000&nbsp;₽{% endif %}{% if region == "int" %}0,025600&nbsp;${% endif %}{% if region == "kz" %}16,0000&nbsp;₸{% endif %}{% endif %} — стоимость месяца использования 1 ГБ хранилища на сетевых HDD-дисках.

{% if audience == "cvos" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mmg-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

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

### Вычислительные ресурсы хостов {#prices-host}

Цены на вычислительные ресурсы одинаковы для всех видов хостов — mongod, mongos и mongocfg.

{% if region == "ru" %}

{% include [rub-host](../_pricing/managed-mongodb/rub-host.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host](../_pricing/managed-mongodb/kzt-host.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host](../_pricing/managed-mongodb/usd-host.md) %}

{% endif %}


### Хранилище и резервные копии {#prices-storage}

{% if region == "ru" %}

{% include [rub-storage](../_pricing/managed-mongodb/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage](../_pricing/managed-mongodb/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage](../_pricing/managed-mongodb/usd-storage.md) %}

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

