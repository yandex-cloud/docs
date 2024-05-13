---
editable: false
---

# {{ mch-short-name }} pricing

In this section, you can find {{ mch-name }} pricing [rules](#rules) and [effective prices](#prices) for the service's resources.


{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mch-short-name }} {#rules}

The {{ mch-name }} usage cost is based on:

* Disk type and storage size.

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts).

* Settings and number of backups.

* Egress traffic from {{ yandex-cloud }}.

The incoming traffic and the number of requests to the hybrid storage are free-of-charge.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in the [Host classes](concepts/instance-types.md) section, while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

You can choose host class both for {{ CH }} and {{ ZK }} hosts (according to the expected replication load).

{% note warning %}

In clusters with disabled [{{ CK }}](./concepts/replication.md#ck) support and with two or more {{ CH }} hosts, 3 {{ ZK }} hosts with the minimal class are automatically created to provide replication and fault tolerance.

{% endnote %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when the DBMS or {{ ZK }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You are charged for the following:

* Storage allocated for DB clusters.


* You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
   * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
   * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.
* Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts, in increments of 93 GB.


* The size of [local](concepts/storage.md#local-storage-features) and [network](concepts/storage.md) storage used for data backups:

   * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.

   * If the combined size of the database and all backups exceeds the cluster storage size, you only pay for the portion in excess of the storage size.

   * During an automatic backup, {{ mch-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

   * The number of hosts in a cluster does not affect the storage size and, therefore, the free volume of backups.

   For example, if there are N free GB of space in the cluster, the first N GB of backups are stored free of charge.

* The storage size used by cold data backups of a [hybrid storage](concepts/storage.md#hybrid-storage-features):

   * Cold data backups are stored in the same {{ objstorage-name }} bucket as the data itself.

   * The cost of using {{ objstorage-name }} considers both the space used by the backups and the space used by the data itself.

   * During an automatic backup, {{ mch-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

The cost is specified for one month of use and based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **{{ CH }} hosts**: 3 `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ZK }} hosts** (created automatically): 3 `b3-c1-m4` hosts: Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM.
* **Storage**: 100 GB of HDD network storage.

Cost calculation for {{ CH }} hosts:


> 
> 3 × (2&nbsp;×&nbsp;$0.013760 + 8&nbsp;×&nbsp;$0.003760) = $0.172800
> 
>
> Total: $0.172800 is the cost per hour of {{ CH }} host operation.



Where:
* 3 is the number of {{ CH }} hosts.
* 2 is the number of vCPUs.
* $0.013760 is the cost per hour of 100% vCPU utilization.
* 8 is the amount of RAM per {{ CH }} host (in GB).
* $0.003760 is the cost per hour of 1 GB RAM utilization on 100% vCPU.

Cost calculation for {{ ZK }} hosts:


> 
> 3 × (2&nbsp;×&nbsp;$0.005600 + 4&nbsp;×&nbsp;$0.002240) = $0.060480
> 
>
> Total: $0.060480 is the cost per hour of {{ ZK }} host operation.



Where:
* 3 is the number of {{ ZK }} hosts.
* 2 is the number of vCPUs.
* $0.005600 is the cost per hour of 50% vCPU utilization.
* 4 is the amount of RAM per {{ ZK }} host (in GB).
* $0.002240 is the cost per hour of 1 GB RAM utilization on 50% vCPU.

Calculation for the storage cost and total cost:


> 
> 720 × ($0.172800 + $0.060480) + 100&nbsp;×&nbsp;$0.025600 = $170.521600
> 
>
> Total: $170.521600 is the cost of using the cluster for 30 days.



Where:
* 720: Number of hours in 30 days.
* $0.172800: Cost per hour of {{ CH }} host operation.
* $0.060480: Cost per hour of {{ ZK }} host operation.
* 100: Amount of HDD network storage (in GB).
* $0.025600: Cost of using 1 GB of network HDD storage per month.


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mch-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns feature dashes under [Prices](#prices). Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}



All prices are shown without VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### {{ CH }} host computing resources {#prices-clickhouse}





{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}




### {{ ZK }} host computing resources {#prices-zookeeper}


{% note info %}

You can't order {{ ZK }} host resources using a CVoS.

{% endnote %}




{% include [usd-host-zoo.md](../_pricing/managed-clickhouse/usd-host-zoo.md) %}




### Storage and backups {#prices-storage}





{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}




### Egress traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}




{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
