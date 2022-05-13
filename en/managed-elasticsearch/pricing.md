---
editable: false
---

# Pricing policy for Managed Service for Elasticsearch

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* For a `Running` cluster, you pay both for the computing resources and storage size.
* For a `Stopped` cluster, you pay only for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mes-short-name }} {#rules}

The cost of {{ mes-name }} usage is based on:

* {{ ES }} edition used.

* Computing resources allocated to cluster hosts (including hosts with the `Master node` role).

* Storage type and size (disk space).

* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources and {{ ES }} edition used. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

You can select the host class both for the hosts with the `Data node` role and hosts with the `Master node` role.

The minimum billing unit is one minute (for example, the cost of 1.5 minutes of operation is the same as the cost of 2 minutes of operation). You are not charged for time when the {{ ES }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.

* Storage taken up by backups over specified cluster storage.

    * Storing backups is free of charge as long as the total amount of data in a cluster together with all the backups stays under the selected storage size.

    * When performing automatic backups, {{ mes-short-name }} does not create a new copy, but stores data changes with respect to the previous backup. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if audience == "draft" %}

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* With 3 hosts with the `Data node` role that have the `s2.micro` class (2 vCPU, 8 GB RAM).
* With 3 hosts with the `Master node` role that have the `s2.micro` class (2 vCPU, 8 GB RAM).
* With 100 GB of standard network storage.

Cost per hour for the hosts: `3 × (2 × ₽1.05 + 8 × ₽0.28) + 3 × (2 × ₽0.49 + 4 × ₽0.20) = ₽18.36`

Total cost per cluster per month (hosts and storage): `720 × ₽18.36 + 100 × ₽2.2881 = ₽13,448.01`

{% endif %}

{% if audience == "cvos" %}

## Discount for committed volumes of services (CVoS) {#cvos}

You can get a guaranteed discount on {{ yandex-cloud }} resource usage when you plan for one or three years ahead.

{{mes-name}} provides four types of CVoS:

* For vCPU.
* For RAM in the BASIC edition.
* For RAM in the GOLD edition.
* For RAM in the PLATINUM edition.

A CVoS guarantees a discount on usage, but doesn't guarantee the availability of the resources ordered. To enable CVoS, contact [support](../support/overview.md).

Read more about CVoS in the [Billing documentation](../billing/concepts/cvos.md).

{% note info %}

You can't order storage or internet traffic using the CVoS model.

{% endnote %}

{% endif %}

## Pricing {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

{% if region == "ru" %}

{% include notitle [rub-hosts-and-storage.md](../_pricing/managed-elasticsearch/rub-hosts-and-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-hosts-and-storage.md](../_pricing/managed-elasticsearch/kzt-hosts-and-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-hosts-and-storage.md](../_pricing/managed-elasticsearch/usd-hosts-and-storage.md) %}

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

