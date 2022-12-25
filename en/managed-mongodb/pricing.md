---
editable: false
---

# Pricing for {{ mmg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mmg-short-name }} {#rules}

The {{ mmg-name }} usage cost is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ MG }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

   * Storage on non-replicated SSDs (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts in increments of 93 GB.

   {% if product == "yandex-cloud" %}* Storage on local SSDs (`local-ssd`) can only be ordered for clusters running Intel Broadwell and Intel Cascade Lake with three or more hosts, in increments of 100 GB.{% endif %}

   For more information about platform-specific storage limitations, see [{#T}](./concepts/storage.md).

* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * During an automatic backup, {{ mmg-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if audience == "cvos" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mmg-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

{% endif %}

## Pricing {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

### Host computing resources {#prices-host}

The prices for computing resources are the same for all types of hosts: mongod, mongos, and mongocfg.

{% if region == "ru" %}

{% include [rub-host](../_pricing/managed-mongodb/rub-host.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host](../_pricing/managed-mongodb/kzt-host.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host](../_pricing/managed-mongodb/usd-host.md) %}

{% endif %}


### Storage and backups {#prices-storage}

{% if region == "ru" %}

{% include [rub-storage](../_pricing/managed-mongodb/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage](../_pricing/managed-mongodb/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage](../_pricing/managed-mongodb/usd-storage.md) %}

{% endif %}


### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

