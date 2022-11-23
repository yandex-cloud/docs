---
editable: false
---

# Pricing for {{ mpg-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect on December 6, 2022. Until then, {{ mpg-name }} can be used free of charge.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mpg-short-name }} {#rules}

The cost of {{ mpg-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. Exact class characteristics are given in [{#T}](concepts/instance-types.md).

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ PG }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

   {% if product == "yandex-cloud" %}

   * You can only oder local SSD storage (`local-ssd`) for clusters with three or more hosts:
      * for Intel Broadwell and Intel Cascade Lake in 100 GB increments.
      * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.

   * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

   {% endif %}

* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * During an automatic backup, {{ mpg-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if product == "yandex-cloud" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mpg-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

{% endif %}

## Pricing {% if product == "cloud-il" %}starting December 6, 2022{% endif %} {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

### Host computing resources {#prices-hosts}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-host-resources.md](../_pricing/managed-postgresql/rub-host-resources.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-host-resources.md](../_pricing/managed-postgresql/kzt-host-resources.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-host-resources.md](../_pricing/managed-postgresql/usd-host-resources.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-host-resources.md](../_pricing/managed-postgresql/ils-host-resources.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-storage.md](../_pricing/managed-postgresql/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-storage.md](../_pricing/managed-postgresql/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-storage.md](../_pricing/managed-postgresql/usd-storage.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-storage.md](../_pricing/managed-postgresql/ils-storage.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

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
