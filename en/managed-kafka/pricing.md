---
editable: false
---

# Pricing for {{ mkf-name }}


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* For a `Running` cluster, you pay both for the computing resources and storage size.
* For a `Stopped` cluster, you pay only for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mkf-short-name }} {#rules}

The cost of {{ mkf-name }} usage is based on:

* Storage type and size (disk space).

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts) and the type of hosts.

* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

You can choose the host class for {{ KF }} broker hosts and {{ ZK }} hosts (as appropriate for the expected replication load).


There are different ways to calculate the cost depending on the [host type](./concepts/index.md):

* Standard hosts

   The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

* Dedicated hosts

   {% include [Dedicated hosts prices](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}


{% note warning %}

When you create a cluster with two or more {{ KF }} broker hosts, three {{ ZK }} hosts with the minimal host class are created automatically in three availability zones to provide replication and fault tolerance for the cluster. If you create a cluster with a single broker host, no {{ ZK }} hosts are created.

{% endnote %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when a broker host or {{ ZK }} doesn't perform its main functions.

### Disk space usage {#rules-storage}

You pay for the storage allocated for DB clusters.


* You can only order local SSD storage (`local-ssd`) for clusters with three or more broker hosts:
   * For Intel Cascade Lake: In 100 GB increments.
   * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.
* You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more broker hosts.


The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

{% list tabs %}

* Standard hosts

   For example, you created a cluster:

   * With 3 {{ KF }} broker hosts with the `s3-c2-m8` class (Intel Ice Lake, 2 vCPU, 100% vCPU, 8 GB RAM).
   * With 3 automatically created {{ ZK }} hosts with the `b3-c1-m4` class (Intel Ice Lake, 2 vCPU, 50% vCPU, 4 GB RAM). Each {{ ZK }} host gets 10 GB of network SSD storage.
   * With 100 GB of network HDD storage (allocated to each broker host).

   Hourly cost to run hosts ({{ KF }} and {{ ZK }}): 
      3 × (2 × $0.012080 + 8 × $0.003200) + 3 × (2 × $0.005600 + 4 × $0.002240) = $0.209760

   Storage cost (HDD and SSD): 
      3 × 100 × $0.025600 + 3 × 10 × $0.104080 = $10.802400


   Total monthly cluster cost (hosts and storage): 
      720 × $0.209760 + $10.802400 = $161.829600
   
{% endlist %}


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mkf-name}} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}


All prices are shown without VAT.



Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The cost of fast local storage also depends on the type of hosts.


### {{ KF }} broker host computing resources {#prices-kafka-brokers}


{% list tabs %}

* Standard hosts

   {% include notitle [USD: standard broker hosts](../_pricing/managed-kafka/usd-hosts-standard.md) %}


* Dedicated hosts

   {% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

   {% include notitle [USD: dedicated broker hosts](../_pricing/managed-kafka/usd-hosts-dedicated.md) %}


{% endlist %}



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



### Outgoing traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



