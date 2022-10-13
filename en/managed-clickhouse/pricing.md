---
editable: false
---

# Pricing for {{ mch-short-name }}

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ mch-name }} can be used free of charge.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mch-short-name }} {#rules}

The cost of {{ mch-name }} usage is based on:

* Storage type and size (disk space).

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts).

* Settings and number of backups.

* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

You can choose the host class for {{ CH }} and {{ ZK }} hosts (as appropriate for the expected replication load).

{% note warning %}

In clusters with disabled [{{ CK }}](./concepts/replication.md#ck) support and with two or more {{ CH }} hosts, 3 {{ ZK }} hosts with the minimal class are automatically created to provide replication and fault tolerance.

{% endnote %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You aren't charged for time when the DBMS or {{ ZK }} host isn't performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

   {% if product == "yandex-cloud" %}* Storage on local SSDs (`local-ssd`) can only be ordered for clusters running Intel Broadwell and Intel Cascade Lake with three or more hosts, in increments of 100 GB.{% endif %}
   * Storage on non-replicated SSDs (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts in increments of 93 GB.

* The storage size used by data backups of [local](concepts/storage.md#local-storage-features) and [network](concepts/storage.md) storage:

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * If the combined size of the database and all backups exceeds the storage volume of the cluster, you only pay for the excess of this volume.

   * During an automatic backup, {{ mch-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

   For example, if there are N free GB of space in the cluster, the first N GB of backups are stored free of charge.

* The storage size used by cold data backups of [hybrid storage](concepts/storage.md#hybrid-storage-features):

   * Cold data backups are stored in the same {{ objstorage-name }} bucket as the data itself.

   * The storage used by backups is taken into account when calculating the cost of using {{ objstorage-name }} as well as the volume of the data itself.

   * During an automatic backup, {{ mch-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* With 3 {{ CH }} hosts of the `s1.micro` class (2 vCPU, 8 GB RAM).
* With 3 automatically created {{ ZK }} hosts of the `b2.medium` class (2 vCPU x 50%, 4 GB RAM).
* With 100 GB of HDD network (`network-hdd`) storage.

Cost of using resources:

* 1 hour of using the core of a {{ CH }} host with 100% vCPU: {% if region == "ru" %}₽2.28{% endif %}{% if region == "int" %}$0.018240{% endif %}{% if region == "kz" %}{% endif %}.
* 1 hour of using 1 GB of RAM of a {{ CH }} host: {% if region == "ru" %}₽0.52{% endif %}{% if region == "int" %}$0.004160{% endif %}{% if region == "kz" %}₸2.6000{% endif %}.
* 1 hour of using the core of a {{ ZK }} host with 50% vCPU: {% if region == "ru" %}₽0.78{% endif %}{% if region == "int" %}$0.006240{% endif %}{% if region == "kz" %}₸3.9000{% endif %}.
* 1 hour of using 1 GB of RAM of a {{ ZK }} host: {% if region == "ru" %}₽0.32{% endif %}{% if region == "int" %}$0.002560{% endif %}{% if region == "kz" %}₸1.6000{% endif %}.
* 1 month of using 1 GB of HDD network storage (`network-hdd`): {% if region == "ru" %}₽3.20{% endif %}{% if region == "int" %}$0.025600{% endif %}{% if region == "kz" %}₸16.0000{% endif %}.

Cost per hour for all hosts: {% if region == "ru" %}`3 × (2 × ₽2.28 + 8 × ₽0.52) + 3 × (2 × ₽0.78 + 4 × ₽0.32) = ₽34.68`{% endif %}{% if region == "int" %}`3 × (2 × $0.018240 + 8 × $0.004160) + 3 × (2 × $0.006240 + 4 × $0.002560) = $0.277440`{% endif %}{% if region == "kz" %}`3 × (2 × ₸11.4000 + 8 × ₸2.6000) + 3 × (2 × ₸3.9000 + 4 × ₸1.6000) = ₸173.4000`{% endif %}

Total cost of the cluster per month (hosts and storage): {% if region == "ru" %}`720 × ₽34.68 + 100 × ₽3.20 = ₽25289.6`{% endif %}{% if region == "int" %}`720 × $0.277440 + 100 × $0.025600 = $202.316800`{% endif %}{% if region == "kz" %}`720 × ₸173.4000 + 100 × ₸16.0000 = ₸126448.0000`{% endif %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mch-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

## Pricing {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

### {{ CH }} host computing resources {#prices-clickhouse}

{% if region == "ru" %}

{% include [rub-host-ch.md](../_pricing/managed-clickhouse/rub-host-ch.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host-ch.md](../_pricing/managed-clickhouse/kzt-host-ch.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}

{% endif %}

### {{ ZK }} host computing resources {#prices-zookeeper}

{% note info %}

You can't order {{ ZK }} host resources using a CVoS.

{% endnote %}

{% if region == "ru" %}

{% include [rub-host-zoo.md](../_pricing/managed-clickhouse/rub-host-zoo.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host-zoo.md](../_pricing/managed-clickhouse/kzt-host-zoo.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host-zoo.md](../_pricing/managed-clickhouse/usd-host-zoo.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/managed-clickhouse/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/managed-clickhouse/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}

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

{% endif %}
