---
editable: false
---

# Pricing for {{ mkf-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect on November 14, 2022, when {{ mkf-name }} [becomes public](../overview/concepts/launch-stages.md). Until then, the service can be used free of charge.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

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
   * For Intel Cascade Lake: In 100 GB increments.
   * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.
* You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more broker hosts.

{% endif %}

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if product == "yandex-cloud" %}

### Example of cluster cost calculation {#example}

{% list tabs %}

* Standard hosts

   For example, you created a cluster:

   * With 3 {{ KF }} broker hosts with the `s2.micro` class (Intel Cascade Lake, 2 vCPU, 100% vCPU, 8 GB RAM).
   * With 3 automatically created {{ ZK }} hosts with the `b2.medium` class (Intel Cascade Lake, 2 vCPU, 50% vCPU, 4 GB RAM). Each {{ ZK }} host gets 10 GB of network SSD storage.
   * With 100 GB of network HDD storage (allocated to each broker host).

   Hourly cost to run hosts ({{ KF }} and {{ ZK }}): `3 × (2 × {% if region == "ru" %}₽1.68{% endif %}{% if region == "int" %}$0.013440{% endif %}{% if region == "kz" %}₸8.4000{% endif %} + 8 × {% if region == "ru" %}₽0.45{% endif %}{% if region == "int" %}$0.003600{% endif %}{% if region == "kz" %}₸2,2500{% endif %}) + 3 × (2 × {% if region == "ru" %}₽0.78{% endif %}{% if region == "int" %}$0.006240{% endif %}{% if region == "kz" %}₸3.9000{% endif %} + 4 × {% if region == "ru" %}₽0.32{% endif %}{% if region == "int" %}$0.002560{% endif %}{% if region == "kz" %}₸1.6000{% endif %}) = {% if region == "ru" %}₽29.40{% endif %}{% if region == "int" %}$0.068160{% endif %}{% if region == "kz" %}₸147.0000{% endif %}`

   Storage cost (HDD and SSD): `3 × 100 × {% if region == "ru" %}₽3.20{% endif %}{% if region == "int" %}$0.025600{% endif %}{% if region == "kz" %}₸16.0000{% endif %} + 3 × 10 × {% if region == "ru" %}₽13.01{% endif %}{% if region == "int" %}$0.104080{% endif %}{% if region == "kz" %}₸65.0500{% endif %} = {% if region == "ru" %}₽1350.30{% endif %}{% if region == "int" %}$10.802400{% endif %}{% if region == "kz" %}₸6751.5000{% endif %}`

   Total monthly cluster cost (hosts and storage): `720 × {% if region == "ru" %}₽29.40{% endif %}{% if region == "int" %}$0.068160{% endif %}{% if region == "kz" %}₸147.0000{% endif %} + {% if region == "ru" %}₽1350.3{% endif %}{% if region == "int" %}$10.802400{% endif %}{% if region == "kz" %}₸6751.5000{% endif %} = {% if region == "ru" %}₽22518.3{% endif %}{% if region == "int"%}$59.877600{% endif %}{% if region == "kz" %}₸112&nbsp;411.5000{% endif %}`

{% endlist %}

{% endif %}

{% if product == "yandex-cloud" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mkf-name}} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

{% endif %}

## Pricing {% if product == "cloud-il" %}starting November 14, 2022{% endif %} {#prices}

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
