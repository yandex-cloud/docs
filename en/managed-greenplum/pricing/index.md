---
editable: false
---

# Pricing policy for {{ mgp-name }}

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

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](../concepts/instance-types.md) section. Prices for using vCPU and RAM are given in the [Prices](#prices) section.

{% if audience == "draft" %}

There are different ways to calculate the cost depending on the [host type](../concepts/):

* Standard hosts

  The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

* Dedicated hosts

  You only pay for [{{ compute-full-name }} computing resources](../../compute/pricing.md#prices-dedicated-host).

  The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} markup for using these resources.

{% endif %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ GP }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.
  * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with two master hosts:
    * For Intel Cascade Lake: In increments of 100 GB.
    * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.
  * Storage on non-replicated network drives (`network-ssd-nonreplicated`) can only be ordered for clusters with two master hosts in increments of 93 GB.

* Space used by DB backups in excess of the storage specified for the cluster.

  * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

  * During an automatic backup, {{ mgp-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

  * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if audience == "cvos" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

{{mgp-name}} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

{% endif %}

## Pricing {#prices}

All prices are shown with VAT.

Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The cost of fast local storage also depends on the type of hosts.

### Host computing resources {#prices-hosts}

{% list tabs %}

- Standard hosts

  {% if region == "ru" %} {% include notitle [RUB: standard hosts](../../_pricing/managed-greenplum/rub-hosts-standard.md) %}{% endif %}
  {% if region == "kz" %} {% include notitle [KZT: standard hosts](../../_pricing/managed-greenplum/kzt-hosts-standard.md) %}{% endif %}
  {% if region == "int" %} {% include notitle [USD: standard hosts](../../_pricing/managed-greenplum/usd-hosts-standard.md) %}{% endif %}

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Standard hosts

  {% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

  {% if region == "ru" %} {% include notitle [rub-storage-standard.md](../../_pricing/managed-greenplum/rub-storage-standard.md) %} {% endif %}
  {% if region == "kz" %} {% include notitle [kzt-storage-standard.md](../../_pricing/managed-greenplum/kzt-storage-standard.md) %} {% endif %}
  {% if region == "int" %} {% include notitle [usd-storage-standard.md](../../_pricing/managed-greenplum/usd-storage-standard.md) %} {% endif %}

{% if audience== "draft" %}

- Dedicated hosts

  The usage cost includes two components:
  * [The cost of using {{ compute-full-name }} storage](../../compute/pricing.md#prices-dedicated-host).
  * The cost of storing backups in excess of the free space in cluster storage.

  {% if region == "ru" %} {% include notitle [rub-storage-dedicated.md](../../_pricing/managed-greenplum/rub-storage-dedicated.md) %} {% endif %}
  {% if region == "kz" %} {% include notitle [kzt-storage-dedicated.md](../../_pricing/managed-greenplum/kzt-storage-dedicated.md) %} {% endif %}
  {% if region == "int" %} {% include notitle [usd-storage-dedicated.md](../../_pricing/managed-greenplum/usd-storage-dedicated.md) %} {% endif %}

{% endif %}

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %} {% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %} {% endif %}
{% if region == "kz" %} {% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %} {% endif %}
{% if region == "int" %} {% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %} {% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
