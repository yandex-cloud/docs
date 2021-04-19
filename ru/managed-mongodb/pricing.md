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

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы хоста равна стоимости 2 часов). Время, когда хост {{ MG }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров БД.

    * Хранилище на быстрых локальных дисках (`local-ssd`) можно заказывать только для кластеров более чем с 3 хостами, с шагом 100 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    * Хранение резервных копий не тарифицируется, пока сумма размера БД и всех резервных копий остается меньше выбранного объема хранилища.

    * При автоматическом резервном копировании {{ mmg-short-name }} не создает новую копию, а сохраняет изменения БД по сравнению с предыдущей копией. Поэтому потребление хранилища автоматическими резервными копиями растет только пропорционально объему изменений.

    * Количество хостов кластера не влияет на объем хранилища и, соответственно, на бесплатный объем резервных копий.

Цена указывается за 1 месяц использования.  Минимальная единица тарификации — ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).


## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mmg-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены {#prices}

Все цены указаны с включением НДС.

### Вычислительные ресурсы хостов {#prices-host}

Цены на вычислительные ресурсы одинаковы для всех видов хостов — mongod, mongos и mongocfg. 

{% if region == "ru" %}

{% include [rub-host](../_pricing/managed-mongodb/rub-host.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host](../_pricing/managed-mongodb/kzt-host.md) %}

{% endif %}

{% if region == "int" %}

Prices in USD, without VAT
    
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

Prices in USD, without VAT
    
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


## Расчетные цены для классов хостов {#calculated-host-price}

Цены за время работы хостов рассчитаны исходя из конфигураций [классов хостов](concepts/instance-types.md) и приведенных выше цен за использование vCPU и RAM для соответствующей платформы. Чтобы точно рассчитать стоимость нужного кластера, воспользуйтесь [калькулятором](https://cloud.yandex.ru/services/managed-mongodb#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

Все цены указаны с включением НДС.

{% if region == "ru" %}
    
{% include [rub-class](../_pricing/managed-mongodb/rub-class.md) %}

{% endif %}

{% if region == "kz" %}
    
{% include [kzt-class](../_pricing/managed-mongodb/kzt-class.md) %}

{% endif %}

{% if region == "int" %}

Prices in USD, without VAT
    
{% include [usd-class](../_pricing/managed-mongodb/usd-class.md) %}

{% endif %}