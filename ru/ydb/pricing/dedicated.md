# Правила тарификации для режима {{ ydb-name }} с выделенными инстансами

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## Из чего складывается стоимость использования YDB {#rules}

При работе {{ ydb-name }} в режиме с выделенными инстансами вы оплачиваете:

* тип и размер [групп хранения](../concepts/index.md#storage-groups), выделенных для базы данных;
* вычислительные ресурсы, выделенные базе данных.

Дополнительно оплачиваются иные потребляемые ресурсы:

* место, занятое в сервисе Object Storage для хранения резервных копий по требованию;
* объем исходящего трафика из {{ yandex-cloud }} в интернет.


{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Использование вычислительных ресурсов {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы виртуальной машины в соответствии с ее классом. Точные характеристики классов приведены в разделе [{#T}](../concepts/index.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы виртуальной машины равна стоимости 2 часов).

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для групп хранения базы данных.

* Объем, занимаемый резервными копиями баз данных по требованию, сохраненными в сервисе Object Storage.

   {% note info %}

   Yandex {{ ydb-name }} для каждой базы автоматические создает и бесплатно хранит 2 полные резервные копии за два последних дня. Плата за хранение автоматических резервных копий не взимается.

   {% endnote %}

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

Сервис {{ ydb-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены {#prices}

Все цены указаны с включением НДС. Цены за месяц указаны из расчета для месяца в 30 календарных дней. Для более коротких месяцев цена соответственно выше, для более длинных — ниже.

### Вычислительные ресурсы хостов {#prices-compute-units}

{% if region == "ru" %}

{% include notitle [rub-compute-units.md](../../_pricing/ydb/rub-compute-units.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-compute-units.md](../../_pricing/ydb/kzt-compute-units.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-compute-units.md](../../_pricing/ydb/usd-compute-units.md) %}

{% endif %}

### Хранилище и резервные копии {#prices-storage}

{% if region == "ru" %}

{% include notitle [rub-storage.md](../../_pricing/ydb/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-storage.md](../../_pricing/ydb/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-storage.md](../../_pricing/ydb/usd-storage.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

{% endif %}

