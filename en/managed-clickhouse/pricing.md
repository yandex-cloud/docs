---
editable: false
---

# Pricing for {{ mch-short-name }}

{{ mch-name }} usage is rated by the pricing policy described in this section.

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% if product == "yandex-cloud" %}
{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}
{% endif %}

## What goes into the cost of using {{ mch-short-name }} {#rules}

The {{ mch-name }} usage cost is based on:

* Disk type and storage size.

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts).

* Settings and number of backups.

* Egress traffic from {{ yandex-cloud }}.

The incoming traffic and the number of requests to the hybrid storage are free-of-charge.

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

* The size of {% if product == "yandex-cloud" %}[local](concepts/storage.md#local-storage-features) and {% endif %}[network](concepts/storage.md) storage used by data backups:

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage selected.

   * If the combined size of the database and all backups exceeds the storage on the cluster, you only pay for the excess of this storage.

   * During an automatic backup, {{ mch-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster doesn't affect the size of the storage and, consequently, of free backups.

   For example, if there are N free GB of space in the cluster, the first N GB of backups are stored free of charge.

* The storage size used by cold data backups of a [hybrid storage](concepts/storage.md#hybrid-storage-features):

   * Cold data backups are stored in the same {{ objstorage-name }} bucket as the data itself.

   * The storage used by backups is taken into account when calculating the cost of using {{ objstorage-name }} as well as the volume of the data itself.

   * During an automatic backup, {{ mch-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

The cost is specified for one month of use and is based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **{{ CH }} hosts**: 3 `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ZK }} hosts** (created automatically): 3 `b3-c1-m4` hosts: Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM.
* **Storage**: 100 GB of HDD network storage.

Cost calculation for {{ CH }} hosts:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}3 × (2&nbsp;×&nbsp;₽1.7200 + 8&nbsp;×&nbsp;₽0.4700) = ₽21.6000{% endif %}
> {% if region == "int" %}3 × (2&nbsp;×&nbsp;$0.013760 + 8&nbsp;×&nbsp;$0.003760) = $0.172800{% endif %}
> {% if region == "kz" %}3 × (2&nbsp;×&nbsp;₸8.6000 + 8&nbsp;×&nbsp;₸2.3500) = ₸108.0000{% endif %}
>
> Total: {% if region == "ru" %}₽21.6000{% endif %}{% if region == "int" %}$0.172800{% endif %}{% if region == "kz" %}₸108.0000{% endif %} is the cost per hour of {{ CH }} host operation.

{% endif %}

{% if product == "cloud-il" %}

> 3 × (2&nbsp;×&nbsp;₪0.1659 + 8&nbsp;×&nbsp;₪0.0286) = ₪1.6818
>
> Total: ₪1.6818 is the cost per hour of {{ CH }} host operation.

{% endif %}

Where:
* 3 is the number of {{ CH }} hosts.
* 2 is the number of vCPUs.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}₽1.7200{% endif %}{% if region == "int" %}$0.013760{% endif %}{% if region == "kz" %}₸8.6000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.1659{% endif %} is the cost per hour of 100% vCPU utilization.
* 8 is the amount of RAM per {{ CH }} host (in GB).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}₽0.4700{% endif %}{% if region == "int" %}$0.003760{% endif %}{% if region == "kz" %}₸2.3500{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.0286{% endif %} is the cost per hour of 1 GB RAM utilization on 100% vCPU.

Cost calculation for {{ ZK }} hosts:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}3 × (2&nbsp;×&nbsp;₽0.7000 + 4&nbsp;×&nbsp;₽0.2800) = ₽7.5600{% endif %}
> {% if region == "int" %}3 × (2&nbsp;×&nbsp;$0.005600 + 4&nbsp;×&nbsp;$0.002240) = $0.060480{% endif %}
> {% if region == "kz" %}3 × (2&nbsp;×&nbsp;₸3.5000 + 4&nbsp;×&nbsp;₸1.4000) = ₸37.8000{% endif %}
>
> Total: {% if region == "ru" %}₽7.5600{% endif %}{% if region == "int" %}$0.060480{% endif %}{% if region == "kz" %}₸37.8000{% endif %} is the cost per hour of {{ ZK }} host operation.

{% endif %}

{% if product == "cloud-il" %}

> 3 × (2&nbsp;×&nbsp;₪0.0264 + 4&nbsp;×&nbsp;₪0.0164) = ₪0.3552
>
> Total: ₪0.3552 is the cost per hour of {{ ZK }} host operation.

{% endif %}

Where:
* 3 is the number of {{ ZK }} hosts.
* 2 is the number of vCPUs.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}₽0.7000{% endif %}{% if region == "int" %}$0.005600{% endif %}{% if region == "kz" %}₸3.5000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.0264{% endif %} is the cost per hour of 50% vCPU utilization.
* 4 is the amount of RAM per {{ ZK }} host (in GB).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}₽0.2800{% endif %}{% if region == "int" %}$0.002240{% endif %}{% if region == "kz" %}₸1.4000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.0164{% endif %} is the cost per hour of 1 GB RAM utilization on 50% vCPU.

Calculation for the storage cost and total cost:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}720 × (₽21.6000 + ₽7.5600) + 100×₽3.2000 = ₽21315.2000{% endif %}
> {% if region == "int" %}720 × ($0.172800 + $0.060480) + 100×$0.025600 = $170.521600{% endif %}
> {% if region == "kz" %}720 × (₸108.0000 + ₸37.8000) + 100×₸16.0000 = ₸106576.0000{% endif %}
>
> Total: {% if region == "ru" %}₽21315.2000{% endif %}{% if region == "int" %}$170.521600{% endif %}{% if region == "kz" %}₸106576.0000{% endif %} is the cost of using the cluster for 30 days.

{% endif %}

{% if product == "cloud-il" %}

> 720 × (₪1.6818 + ₪0.3552) + 100&nbsp;×&nbsp;₪0.1440 = ₪1481.0400

> Total: ₪1481.0400 is the cost of using the cluster for 30 days.

{% endif %}

Where:
* 720 is the number of hours in 30 days.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}₽21.6000{% endif %}{% if region == "int" %}$0.172800{% endif %}{% if region == "kz" %}₸108.0000{% endif %}{% endif %}{% if product == "cloud-il" %}₪1.6818{% endif %} is the cost per hour of {{ CH }} host operation.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}₽7.5600{% endif %}{% if region == "int" %}$0.060480{% endif %}{% if region == "kz" %}₸37.8000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.3552{% endif %} is the cost per hour of {{ ZK }} host operation.
* 100 is the amount of HDD network storage (in GB).
* {% if product == "yandex-cloud" %}{% if region == "ru" %}₽3.2000{% endif %}{% if region == "int" %}$0.025600{% endif %}{% if region == "kz" %}₸16.0000{% endif %}{% endif %}{% if product == "cloud-il" %}₪0.1440{% endif %} is the cost of using 1 GB of network HDD storage per month.

{% if product == "yandex-cloud" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mch-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

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

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

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


### Egress traffic {#prices-traffic}

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
