---
editable: false
---

# {{ mkf-name }} pricing

In this section, you can find {{ mkf-name }} pricing [rules](#rules) and [effective prices](#prices) for the service's resources.


{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* For a `Running` cluster, you pay both for the computing resources and storage size.
* For a `Stopped` cluster, you pay only for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mkf-short-name }} {#rules}

The {{ mkf-name }} usage cost is based on:

* Disk type and storage size.

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts) and the type of hosts.

* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in the [Host classes](concepts/instance-types.md) section, while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

You can choose the host class for {{ KF }} broker hosts and {{ ZK }} hosts (as appropriate for the expected replication load).


There are different ways to calculate the cost depending on the [host type](./concepts/index.md):

* Standard hosts

   The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

* Dedicated hosts

   {% include [Dedicated hosts prices](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}


{% note warning %}

When you create a cluster with two or more {{ KF }} broker hosts, three {{ ZK }} hosts with a minimal host class are created automatically in three availability zones. If you create a cluster with a single broker host, no {{ ZK }} hosts are created.

{% endnote %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when a broker host or {{ ZK }} is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the storage allocated for DB clusters.


* You can only order local SSD storage (`local-ssd`) for clusters with three or more broker hosts:
   * For Intel Cascade Lake: In increments of 100 GB.
   * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.
* You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more broker hosts.


The cost is specified for one month of use and is based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

{% list tabs %}

* Standard hosts

   The cost of using a cluster with the following parameters for 30 days:

   * **{{ KF }} broker hosts**: 3 `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
   * **Storage for {{ KF }} broker hosts**: 100 GB of HDD network storage per broker host.
   * **{{ ZK }} hosts** (created automatically): 3 `b3-c1-m4` hosts: Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM.
   * **Storage for {{ ZK }} hosts**: 10 GB of SSD network storage per host.

   Cost calculation for {{ KF }} broker hosts:

   
   > 
   > 3 × (2&nbsp;×&nbsp;$0.012080 + 8&nbsp;×&nbsp;$0.003200) = $0.149280
   > 
   >
   > Total: $0.149280 is the cost per hour of operation of {{ KF }} broker hosts.



   Where:
   * 3 is the number of {{ KF }} broker hosts.
   * 2 is the number of vCPUs.
   * $0.012080 is the cost per hour of 100% vCPU utilization.
   * 8 is the amount of RAM per host (in GB).
   * $0.003200 is the cost per hour of 1 GB RAM utilization on 100% vCPU.

   Calculating the cost of storage for {{ KF }} broker hosts:

   
   > 
   > 3 × 100 × $0.025600 = $7.680000
   > 
   >
   > Total: $7.680000 is the cost of storage for {{ KF }} broker hosts.



   Where:
   * 3 is the number of {{ KF }} broker hosts.
   * 100: Amount of HDD network storage (in GB).
   * $0.025600: Cost of using 1 GB of network HDD storage per month.

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
   * 4 is the amount of RAM per host (in GB).
   * $0.002240 is the cost per hour of 1 GB RAM utilization on 50% vCPU.

   Calculating the cost of storage for {{ ZK }} hosts:

   
   > 
   > 3 × 10 × $0.104080 = $3.122400
   > 
   >
   > Total: $3.122400 is the cost of storage for {{ ZK }} hosts.



   Where:
   * 3 is the number of {{ ZK }} hosts.
   * 10 is the amount of SSD network storage (in GB).
   * $0.104080 is the cost of using 1 GB of network SSD storage per month.

   Total cost calculation:

   
   > 
   > 720 × ($0.149280 + $0.060480) + $7.680000 + $3.122400 = $161.829600
   > 
   >
   > Total: $161.829600 is the cost of using the cluster for 30 days.



   Where:
   * 720: Number of hours in 30 days.
   * $0.149280 is the cost per hour of {{ KF }} broker host operation.
   * $0.060480 is the cost per hour of {{ ZK }} host operation.
   * $7.680000 is the cost of storage for {{ KF }} broker hosts.
   * $3.122400 is the cost of storage for {{ ZK }} hosts.

{% endlist %}


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mkf-name }} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns feature dashes under [Prices](#prices). Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}


All prices are shown without VAT.



Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

The cost of fast local storage also depends on the type of hosts.


### {{ KF }} broker host computing resources {#prices-kafka-brokers}


#### Standard hosts {#prices-kafka-standard}

{% include notitle [USD: standard broker hosts](../_pricing/managed-kafka/usd-hosts-standard.md) %}


#### Dedicated hosts {#prices-kafka-dedicated}

{% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

{% include notitle [USD: dedicated broker hosts](../_pricing/managed-kafka/usd-hosts-dedicated.md) %}




### {{ ZK }} host computing resources {#prices-zookeeper}


{% note info %}

You can't order {{ ZK }} host resources using a CVoS.

{% endnote %}

{% list tabs %}

* Standard hosts

   {% include notitle [USD: standard ZooKeeper hosts](../_pricing/managed-kafka/usd-hosts-zk-standard.md) %}


* Dedicated hosts

   {% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

   Verify the cost with [technical support]({{ link-console-support }}).



{% endlist %}



### Storage {#prices-storage}


{% include notitle [USD: Storage prices](../_pricing/managed-kafka/usd-storage.md) %}



### Egress traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



