---
editable: false
---

# Правила тарификации для {{ mpg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## Из чего складывается стоимость использования {{ mpg-short-name }} {#rules}

Расчет стоимости использования {{ mpg-name }} учитывает:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [{#T}](concepts/instance-types.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы хоста равна стоимости 2 часов). Время, когда хост {{ PG }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (`local-ssd`) можно заказывать только для кластеров с 3 и более хостами, с шагом 100 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании {{ mpg-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).


## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{mpg-name}} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены {#prices}

Все цены указаны с включением НДС.

### Вычислительные ресурсы хостов {#prices-hosts}

{% if region == "ru" %}

{% include notitle [rub-host-resources.md](../_pricing/managed-postgresql/rub-host-resources.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-host-resources.md](../_pricing/managed-postgresql/kzt-host-resources.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-host-resources.md](../_pricing/managed-postgresql/usd-host-resources.md) %}

{% endif %}


### Хранилище и резервные копии {#prices-storage}

{% if region == "ru" %}

{% include notitle [rub-storage.md](../_pricing/managed-postgresql/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-storage.md](../_pricing/managed-postgresql/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-storage.md](../_pricing/managed-postgresql/usd-storage.md) %}

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

## Расчетные цены для классов хостов {#calculated-prices}

Цены за время работы хостов рассчитаны исходя из конфигураций [классов хостов](concepts/instance-types.md) и приведенных выше цен за использование vCPU и RAM для соответствующей платформы. Чтобы точно рассчитать стоимость нужного кластера, воспользуйтесь [калькулятором](https://cloud.yandex.ru/services/managed-postgresql#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- За месяц работы хоста

  {% if region == "ru" %}

  {% include notitle [rub-calculated-month.md](../_pricing/managed-postgresql/rub-calculated-month.md) %}

  {% endif %}

  {% if region == "kz" %}

  {% include notitle [kzt-calculated-month.md](../_pricing/managed-postgresql/kzt-calculated-month.md) %}

  {% endif %}

  {% if region == "int" %}

  {% include notitle [usd-calculated-month.md](../_pricing/managed-postgresql/usd-calculated-month.md) %}

  {% endif %}

- За 1 час работы хоста

  {% if region == "ru" %}

  {% include notitle [rub-calculated-hour.md](../_pricing/managed-postgresql/rub-calculated-hour.md) %}

  {% endif %}

  {% if region == "kz" %}

  {% include notitle [kzt-calculated-hour.md](../_pricing/managed-postgresql/kzt-calculated-hour.md) %}

  {% endif %}

  {% if region == "int" %}

  {% include notitle [usd-calculated-hour.md](../_pricing/managed-postgresql/usd-calculated-hour.md) %}

  {% endif %}

{% endlist %}

