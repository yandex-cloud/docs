---
title: "Правила тарификации для режима {{ ydb-full-name }} с выделенными инстансами"
description: "Из статьи вы узнаете о правилах тарификации для режима {{ ydb-full-name }} с выделенными инстансами."
editable: false
---

# Правила тарификации для режима {{ ydb-name }} с выделенными инстансами

{% if product == "cloud-il" %}

{% note info %}

Цены, указанные ниже, начнут действовать, когда сервис {{ ydb-name }} [станет общедоступным](../../overview/concepts/launch-stages.md) (дата будет анонсирована позднее). До этого использование сервиса не тарифицируется.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

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

{% if product == "yandex-cloud" %}

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

Сервис {{ ydb-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

Объем хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

{% endif %}

## Цены {% if product == "cloud-il" %}(after the service becomes public){% endif %} {#prices}

{% if region != "int" %}

Все цены указаны с включением НДС. Цены за месяц указаны из расчета для месяца в 30 календарных дней. Для более коротких месяцев цена соответственно выше, для более длинных — ниже.

{% endif %}

### Вычислительные ресурсы хостов {#prices-compute-units}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-compute-units.md](../../_pricing/ydb/rub-compute-units.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-compute-units.md](../../_pricing/ydb/kzt-compute-units.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-compute-units.md](../../_pricing/ydb/usd-compute-units.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-compute-units.md](../../_pricing/ydb/ils-compute-units.md) %}

{% endif %}

### Хранилище и резервные копии {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-storage.md](../../_pricing/ydb/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-storage.md](../../_pricing/ydb/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-storage.md](../../_pricing/ydb/usd-storage.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-storage.md](../../_pricing/ydb/ils-storage.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-egress-traffic.md](../../_pricing/ils-egress-traffic.md) %}

{% endif %}