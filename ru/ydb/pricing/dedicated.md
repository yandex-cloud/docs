---
title: Правила тарификации для режима {{ ydb-full-name }} с выделенными инстансами
description: Из статьи вы узнаете о правилах тарификации для режима {{ ydb-full-name }} с выделенными инстансами.
editable: false
---

# Правила тарификации для режима {{ ydb-name }} с выделенными инстансами



{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=2443a6ec26b9#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}


{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## Из чего складывается стоимость использования {{ ydb-name }} {#rules}

При работе {{ ydb-name }} в режиме с выделенными инстансами вы оплачиваете:
* Тип и размер [групп хранения](../concepts/resources.md#storage-groups), выделенных для базы данных.
* [Вычислительные ресурсы](../concepts/resources.md#resource-presets), выделенные БД.

Дополнительно оплачиваются иные потребляемые ресурсы:
* Место, занятое в сервисе {{ objstorage-full-name }} для хранения резервных копий по требованию.
* Объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Использование вычислительных ресурсов {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы виртуальной машины в соответствии с ее классом. Точные характеристики классов приведены в разделе [{#T}](../concepts/index.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы виртуальной машины равна стоимости 2 часов).

### Использование дискового пространства {#rules-storage}

Оплачивается:
* Объем хранилища, выделенный для групп хранения БД.
* Объем, занимаемый резервными копиями БД по требованию, сохраненными в сервисе {{ objstorage-name }}.

  {% note info %}

  {{ ydb-name }} для каждой БД автоматические создает и бесплатно хранит 2 полные резервные копии за два последних дня. Плата за хранение автоматических резервных копий не взимается.

  {% endnote %}

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

Сервис {{ ydb-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}


Все цены указаны с включением НДС. Цены за месяц указаны из расчета для месяца в 30 календарных дней. Для более коротких месяцев цена соответственно выше, для более длинных — ниже.


### Вычислительные ресурсы хостов {#prices-compute-units}


#### Цены в час {#price-per-hour}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-compute-units-hour.md](../../_pricing/ydb/rub-compute-units-hour.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-compute-units-hour.md](../../_pricing/ydb/kzt-compute-units-hour.md) %}

{% endlist %}

#### Цены в месяц {#price-per-month}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-compute-units-month.md](../../_pricing/ydb/rub-compute-units-month.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-compute-units-month.md](../../_pricing/ydb/kzt-compute-units-month.md) %}

{% endlist %}



### Хранилище и резервные копии {#prices-storage}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage.md](../../_pricing/ydb/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage.md](../../_pricing/ydb/kzt-storage.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}
