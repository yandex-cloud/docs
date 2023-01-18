---
editable: false
---

# Pricing for {{ mkf-name }}

{{ mkf-name }} usage is rated by the rules described in this section.

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

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

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

You can choose the host class for {{ KF }} broker hosts and {{ ZK }} hosts (as appropriate for the expected replication load).

{% if product == "yandex-cloud" and audience != "internal" %}

There are different ways to calculate the cost depending on the [host type](./concepts/index.md):

* Standard hosts

   The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

* Dedicated hosts

   {% include [Dedicated hosts prices](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

{% endif %}

{% note warning %}

When you create a cluster with two or more {{ KF }} broker hosts, three {{ ZK }} hosts with the minimal host class are created automatically in three availability zones to provide replication and fault tolerance for the cluster. If you create a cluster with a single broker host, no {{ ZK }} hosts are created.

{% endnote %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when a broker host or {{ ZK }} doesn't perform its main functions.

### Disk space usage {#rules-storage}

You pay for the storage allocated for DB clusters.

{% if product == "yandex-cloud" %}

* You can only order local SSD storage (`local-ssd`) for clusters with three or more broker hosts:
   * For Intel Cascade Lake: In increments of 100 GB.
   * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.
* You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more broker hosts.

{% endif %}

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if product == "yandex-cloud" %}

### Example of cluster cost calculation {#example}

{% list tabs %}

* Standard hosts

   The cost of using a cluster with the following parameters for 30 days:

   * **{{ KF }} broker hosts**: 3 `s2.micro` hosts: Intel Cascade Lake, 2 × 100% vCPU, 8 GB RAM.
   * **Storage for {{ KF }} broker hosts**: 100 GB of HDD network storage per broker host.
   * **{{ ZK }} hosts** (created automatically): 3 `b2.medium` hosts: Intel Cascade Lake, 2 × 50% vCPU, 4 GB RAM.
   * **Storage for {{ ZK }} hosts**: 10 GB of SSD network storage per host.

   Cost calculation:

   {% if region == "ru" %}
   > 3 × (2 × ₽1.6800 + 8 × ₽2.1000) + 8 × (₽0.4500) = ₽20.8800
   > {% endif %}
   > {% if region == "int" %}
   > 3 × (2 × $0.013440 + 8 × $0.016800) + 8 × ($0.003600) = $0.167040
   > {% endif %}
   > {% if region == "kz" %}
   > 3 × (2 × ₸8.4000 + 8 × ₸10.5000) + 8 × (₸2.2500) = ₸104.4000
   > {% endif %}
   >
   > Total: {% if region == "ru" %}₽20.8800{% endif %}{% if region == "int" %}$0.167040{% endif %}{% if region == "kz" %}₸104.4000{% endif %} is the cost per hour of operation of {{ KF }} broker hosts.

   Where:
   * 3 is the number of {{ KF }} broker hosts.
   * 2 is the number of vCPUs.
   * {% if region == "ru" %}₽1.6800{% endif %}{% if region == "int" %}$0.013440{% endif %}{% if region == "kz" %}₸8.4000{% endif %} is the cost of using 100% vCPU per hour.
   * 8 is the amount of RAM per host (in GB).
   * {% if region == "ru" %}₽0.4500{% endif %}{% if region == "int" %}$0.003600{% endif %}{% if region == "kz" %}₸2.2500{% endif %} is the cost of using 1GB of RAM on 100% vCPU per hour.

   > {% if region == "ru" %}3 × 100 × ₽3.2000 = ₽960.0000{% endif %}
   > {% if region == "int" %}3 × 100 × $0.025600 = $7.680000{% endif %}
   > {% if region == "kz" %}3 × 100 × ₸16.0000 = ₸4800.0000{% endif %}
   >
   > Total: {% if region == "ru" %}₽960.0000{% endif %}{% if region == "int" %}$7.680000{% endif %}{% if region == "kz" %}₸4800.0000{% endif %} is the cost of storage for {{ KF }} broker hosts.

   Where:
   * 3 is the number of {{ KF }} broker hosts.
   * 100 is the amount of HDD network storage (in GB).
   * {% if region == "ru" %}₽3.2000{% endif %}{% if region == "int" %}$0.025600{% endif %}{% if region == "kz" %}₸16.0000{% endif %} is the cost of using 1 GB of network HDD storage per month.

   > {% if region == "ru" %}3 × (2 × ₽0.7800 + 4 × ₽0.3200) = ₽8.5200{% endif %}
   > {% if region == "int" %}3 × (2 × $0.006240 + 4 × $0.002560) = $0.068160{% endif %}
   > {% if region == "kz" %}3 × (2 × ₸3.9000 + 4 × ₸1.6000) = ₸42.6000{% endif %}
   >
   > Total: {% if region == "ru" %}₽8.5200{% endif %}{% if region == "int" %}$0.068160{% endif %}{% if region == "kz" %}₸42.6000{% endif %} is the cost per hour of {{ ZK }} host operation.

   Where:
   * 3 is the number of {{ ZK }} hosts.
   * 2 is the number of vCPUs.
   * {% if region == "ru" %}₽0.7800{% endif %}{% if region == "int" %}$0.006240{% endif %}{% if region == "kz" %}₸3.9000{% endif %} is the cost of using 50% vCPU per hour.
   * 4 is the amount of RAM per host (in GB).
   * {% if region == "ru" %}₽0.3200{% endif %}{% if region == "int" %}$0.002560{% endif %}{% if region == "kz" %}₸1.6000{% endif %} is the cost of using 1GB of RAM on 50% vCPU per hour.

   > {% if region == "ru" %}3 × 10 × ₽13.0100 = ₽390.3000{% endif %}
   > {% if region == "int" %}3 × 10 × $0.104080 = $3.122400{% endif %}
   > {% if region == "kz" %}3 × 10 × ₸65.0500 = ₸1951.5000{% endif %}
   >
   > Total: {% if region == "ru" %}₽390.3000{% endif %}{% if region == "int" %}$3.122400{% endif %}{% if region == "kz" %}₸1951.5000{% endif %} is the cost of storage for {{ ZK }} hosts.

   Where:
   * 3 is the number of {{ ZK }} hosts.
   * 10 is the amount of SSD network storage (in GB).
   * {% if region == "ru" %}₽13.0100{% endif %}{% if region == "int" %}$0.104080{% endif %}{% if region == "kz" %}₸65.0500{% endif %} is the cost of using 1 GB of network SSD storage per month.

   > {% if region == "ru" %}720 × (₽20.8800 + ₽8.5200) + ₽960.0000 + ₽390.3000 = ₽22518.300{% endif %}
   > {% if region == "int" %}720 × ($0.167040 + $0.068160) + $7.680000 + $3.122400 = $180.146400{% endif %}
   > {% if region == "kz" %}720 × (₸104.4000 + ₸42.6000) + ₸4800.0000 + ₸1951.5000 = ₸112591.5000{% endif %}
   >
   > Total: {% if region == "ru" %}₽22518.300{% endif %}{% if region == "int" %}$180.146400{% endif %}{% if region == "kz" %}₸112591.5000{% endif %} is the cost of using the cluster for 30 days.

   Where:
   * 720 is the number of hours in 30 days.
   * {% if region == "ru" %}₽20.8800{% endif %}{% if region == "int" %}$0.167040{% endif %}{% if region == "kz" %}₸104.4000{% endif %} is the cost per hour of operation of {{ KF }} broker hosts.
   * {% if region == "ru" %}₽8.5200{% endif %}{% if region == "int" %}$0.068160{% endif %}{% if region == "kz" %}₸42.6000{% endif %} is the cost per hour of {{ ZK }} host operation.
   * {% if region == "ru" %}₽960.0000{% endif %}{% if region == "int" %}$7.680000{% endif %}{% if region == "kz" %}₸4800.0000{% endif %} is the cost of storage for {{ KF }} broker hosts.
   * {% if region == "ru" %}₽390.3000{% endif %}{% if region == "int" %}$3.122400{% endif %}{% if region == "kz" %}₸1951.5000{% endif %} is the cost of storage for {{ ZK }} hosts.

{% endlist %}

{% endif %}

{% if product == "yandex-cloud" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mkf-name }} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

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

{% if product == "yandex-cloud" %}

Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The cost of fast local storage also depends on the type of hosts.

{% endif %}

### {{ KF }} broker host computing resources {#prices-kafka-brokers}

{% if product == "yandex-cloud" %}

{% list tabs %}

* Standard hosts

   {% if region == "ru" %} {% include notitle [RUB: standard broker hosts](../_pricing/managed-kafka/rub-hosts-standard.md) %}{% endif %}
   {% if region == "kz" %} {% include notitle [KZT: standard broker hosts](../_pricing/managed-kafka/kzt-hosts-standard.md) %}{% endif %}
   {% if region == "int" %}{% include notitle [USD: standard broker hosts](../_pricing/managed-kafka/usd-hosts-standard.md) %}{% endif %}

{% if audience != "internal" %}

* Dedicated hosts

   {% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

   {% if region == "ru" %} {% include notitle [RUB: dedicated broker hosts](../_pricing/managed-kafka/rub-hosts-dedicated.md) %}{% endif %}
   {% if region == "kz" %} {% include notitle [KZT: dedicated broker hosts](../_pricing/managed-kafka/kzt-hosts-dedicated.md) %}{% endif %}
   {% if region == "int" %}{% include notitle [USD: dedicated broker hosts](../_pricing/managed-kafka/usd-hosts-dedicated.md) %}{% endif %}

{% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ILS: standard broker hosts](../_pricing/managed-kafka/ils-hosts-standard.md) %}

{% endif %}

### {{ ZK }} host computing resources {#prices-zookeeper}

{% if product == "yandex-cloud" %}

{% note info %}

You can't order {{ ZK }} host resources using a CVoS.

{% endnote %}

{% list tabs %}

* Standard hosts

   {% if region == "ru" %} {% include notitle [RUB: standard ZooKeeper hosts](../_pricing/managed-kafka/rub-hosts-zk-standard.md) %}{% endif %}
   {% if region == "kz" %} {% include notitle [KZT: standard ZooKeeper hosts](../_pricing/managed-kafka/kzt-hosts-zk-standard.md) %}{% endif %}
   {% if region == "int" %}{% include notitle [USD: standard ZooKeeper hosts](../_pricing/managed-kafka/usd-hosts-zk-standard.md) %}{% endif %}

{% if audience != "internal" %}

* Dedicated hosts

   {% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

   Verify the cost with [technical support]({{ link-console-support }}).

   {% if audience == "draft" %}
   {% if region == "ru" %} {% include notitle [RUB: dedicated ZooKeeper hosts](../_pricing/managed-kafka/rub-hosts-zk-dedicated.md) %}{% endif %}
   {% if region == "kz" %} {% include notitle [KZT: dedicated ZooKeeper hosts](../_pricing/managed-kafka/kzt-hosts-zk-dedicated.md) %}{% endif %}
   {% if region == "int" %}{% include notitle [USD: dedicated ZooKeeper hosts](../_pricing/managed-kafka/usd-hosts-zk-dedicated.md) %}{% endif %}
   {% endif %}

{% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ILS: standard ZooKeeper hosts](../_pricing/managed-kafka/ils-hosts-zk-standard.md) %}

{% endif %}

### Storage {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %} {% include notitle [RUB: Storage prices](../_pricing/managed-kafka/rub-storage.md) %}{% endif %}
{% if region == "kz" %} {% include notitle [KZT: Storage prices](../_pricing/managed-kafka/kzt-storage.md) %}{% endif %}
{% if region == "int" %}{% include notitle [USD: Storage prices](../_pricing/managed-kafka/usd-storage.md) %}{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ILS: Storage prices](../_pricing/managed-kafka/ils-storage.md) %}

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