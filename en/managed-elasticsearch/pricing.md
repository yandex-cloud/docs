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

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ ES }} host is not performing its main functions.

### Disk space usage {#rules-storage}

You pay for the storage allocated for DB clusters. The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).


## Discount for committed volumes of services (CVoS) {#cvos}

You can get a guaranteed discount on Yandex.Cloud resource usage when you plan for one or three years ahead.

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

## Pricing {#prices}




{% include notitle [usd-hosts-and-storage.md](../_pricing/managed-elasticsearch/usd-hosts-and-storage.md) %}


### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


## Estimated prices for host classes {#calculated-host-price}

Prices for host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-elasticsearch#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}




{% include notitle [usd-calculated.md](../_pricing/managed-elasticsearch/usd-calculated.md) %}

