---
title: "Pricing rules for the {{ ydb-full-name }} mode with dedicated instances"
description: "In this tutorial, you will learn about the pricing policy for the {{ ydb-full-name }} mode with dedicated instances."
editable: false
---

# Pricing rules for the {{ ydb-name }} mode with dedicated instances

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect when {{ ydb-name }} [becomes public](../../overview/concepts/launch-stages.md) (the date will be announced later). Until then, the service can be used free of charge.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## What goes into the cost of using {{ ydb-name }} {#rules}

When using {{ ydb-name }} in dedicated mode, you pay for the following:
* The type and size of [storage groups](../concepts/resources.md#storage-groups) allocated for the DB.
* [Computing resources](../concepts/resources.md#resource-presets) allocated to the DB.

Other consumed resources to be additionally paid for:
* The space used in {{ objstorage-full-name }} to store on-demand backups.
* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Using computing resources {#rules-hosts-uptime}

The cost is calculated for each hour of VM operation in accordance with its class. Exact class characteristics are given in [{#T}](../concepts/index.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation).

### Disk space usage {#rules-storage}

The following is charged:
* Storage allocated for DB storage groups.
* Space used by on-demand DB backups saved in {{ objstorage-name }}.

   {% note info %}

   For each DB, {{ ydb-name }} automatically creates and stores two full backups for the last two days for free. No fee is charged for storing automatic backups.

   {% endnote %}

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

{% if product == "yandex-cloud" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

{{ ydb-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You currently can't order storage or web traffic this way.

{% endnote %}

{% endif %}

## Pricing {% if product == "cloud-il" %}(after the service becomes public){% endif %} {#prices}

{% if region != "int" %}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

{% endif %}

### Host computing resources {#prices-compute-units}

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

### Storage and backups {#prices-storage}

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

### Egress traffic {#prices-traffic}

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