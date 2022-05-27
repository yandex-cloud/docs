---
editable: false
---

# Pricing for {{ mgp-name }}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [pricing-status](../../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning](../../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mgp-short-name }} {#rules}

The cost of {{ mgp-name }} usage is based on:

* Storage type and size (disk space).
* Computing resources allocated to cluster hosts and host type.
* Settings and number of backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](../concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

There are different ways to calculate the cost depending on the [host type](../concepts/):

* Standard hosts

   The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

* Dedicated hosts

   The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} markup for using these resources.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ GP }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.

   * You can only order storage using SSDs (`local-ssd`) for clusters with two master hosts:
      * For Intel Cascade Lake: In increments of 100 GB.
      * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.
   * You can only order storage on non-replicated SSDs (`network-ssd-nonreplicated`) in increments of 93 GB for clusters with two master hosts.

* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * During an automatic backup, {{ mgp-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


## Pricing {#prices}


All prices are shown without VAT.

Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The cost of storage on local SSDs (`local-ssd`) also depends on the host type.

### Host computing resources {#prices-hosts}

{% list tabs %}

- Standard hosts

   {% include [SAN disclaimer](../../_includes/mdb/mgp/san-pricing-disclaimer.md) %}

   {% include notitle [USD: standard hosts](../../_pricing/managed-greenplum/usd-hosts-standard.md) %}

- Dedicated hosts

   The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} markup for using these resources.

   {% include notitle [USD: dedicated hosts](../../_pricing/managed-greenplum/usd-hosts-dedicated.md) %}

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Standard hosts

   {% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

   {% include notitle [usd-storage-standard.md](../../_pricing/managed-greenplum/usd-storage-standard.md) %}

- Dedicated hosts

   The usage cost includes two components:
   * [The cost of using {{ compute-full-name }} storage](../../compute/pricing.md#prices-dedicated-host).
   * The cost of storing backups in excess of the free space in cluster storage:

      {% include notitle [usd-storage-dedicated.md](../../_pricing/managed-greenplum/usd-storage-dedicated.md) %}

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
