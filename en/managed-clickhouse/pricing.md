---
editable: false
---

# Pricing for {{ mch-short-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect on December 6, 2022. Until then, {{ mch-name }} can be used free of charge.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% if product != "cloud-il" %}
{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}
{% endif %}

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

* The storage size used by data backups of {% if product == "yandex-cloud" %}[local](concepts/storage.md#local-storage-features) and {% endif %}[network](concepts/storage.md) storage:

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

* With 3 {{ CH }} hosts of the `s3-c2-m8` class (Intel Ice Lake, 2 vCPU × 100%, 8 GB RAM).
* With 3 automatically created {{ ZK }} hosts of the `b3-c1-m4` class (Intel Ice Lake, 2 vCPU × 50%, 4 GB RAM).
* With 100 GB of HDD network (`network-hdd`) storage.

Cost of using resources:

* 1 hour of using the core of a {{ CH }} host with 100% vCPU: {% if product == "yandex-cloud" %}{% if region == "ru" %}₽1.72{% endif %}{% if region == "int" %}$0.013760{% endif %}{% if region == "kz" %}₸8.6000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.1659{% endif %}.
* 1 hour of using 1 GB of RAM of a {{ CH }} host: {% if product == "yandex-cloud" %}{% if region == "ru" %}₽0.47{% endif %}{% if region == "int" %}$0.003760{% endif %}{% if region == "kz" %}₸2.3500{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.0286{% endif %}.
* 1 hour of using the core of a {{ ZK }} host with 50% vCPU: {% if product == "yandex-cloud" %}{% if region == "ru" %}₽0.70{% endif %}{% if region == "int" %}$0.005600{% endif %}{% if region == "kz" %}₸3.5000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.0264{% endif %}.
* 1 hour of using 1 GB of RAM of a {{ ZK }} host: {% if product == "yandex-cloud" %}{% if region == "ru" %}₽0.28{% endif %}{% if region == "int" %}$0.002240{% endif %}{% if region == "kz" %}₸1.4000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.0164{% endif %}.
* 1 month of using 1 GB of HDD network storage (`network-hdd`): {% if product == "yandex-cloud" %}{% if region == "ru" %}₽3.20{% endif %}{% if region == "int" %}$0.025600{% endif %}{% if region == "kz" %}₸16.0000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.1440{% endif %}.

Cost per hour for all hosts: {% if product == "yandex-cloud" %}{% if region == "ru" %}3 × (2 × ₽1.72 + 8 × ₽0.47) + 3 × (2 × ₽0.70 + 4 × ₽0.28) = ₽29.16{% endif %}{% if region == "int" %}3 × (2 × $0.013760 + 8 × $0.003760) + 3 × (2 × $0.005600 + 4 × $0.002240) = $0.233280{% endif %}{% if region == "kz" %}3 × (2 × ₸8.6000 + 8 × ₸2.3500) + 3 × (2 × ₸3.5000 + 4 × ₸1.4000) = ₸145.8000{% endif %}{% endif %}{% if product == "cloud-il" %}3 × (2 × ₪0.1659 + 8 × ₪0.0286) + 3 × (2 × ₪0.0264 + 4 × ₪0.0164) = ₪2.0370{% endif %}

Total cost of the cluster per month (hosts and storage): {% if product == "yandex-cloud" %}{% if region == "ru" %}720 × ₽29.16 + 100 × ₽3.20 = ₽21315.2{% endif %}{% if region == "int" %}720 × $0.233280 + 100 × $0.025600 = $170.521600{% endif %}{% if region == "kz" %}720 × ₸145.8000 + 100 × ₸16.0000 = ₸106576.0000{% endif %}{% endif %}{% if product == "cloud-il" %}720 × ₪2.0370 + 100 × ₪0.1440 = ₪1481.0400{% endif %}

{% if product == "yandex-cloud" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mch-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

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

### {{ CH }} host computing resources {#prices-clickhouse}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-host-ch.md](../_pricing/managed-clickhouse/rub-host-ch.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host-ch.md](../_pricing/managed-clickhouse/kzt-host-ch.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-host-ch.md](../_pricing/managed-clickhouse/ils-host-ch.md) %}

{% endif %}

### {{ ZK }} host computing resources {#prices-zookeeper}


{% if product == "yandex-cloud" %}

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

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-host-zoo.md](../_pricing/managed-clickhouse/ils-host-zoo.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/managed-clickhouse/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/managed-clickhouse/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-storage.md](../_pricing/managed-clickhouse/ils-storage.md) %}

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