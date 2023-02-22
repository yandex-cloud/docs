---
title: "Pricing for {{ mmy-name }}"
description: "The cost of {{ mmy-name }} usage is calculated based on the disk type and storage size, computing resources allocated to cluster hosts, the settings and number of backups, and the amount of outgoing traffic from {{ yandex-cloud }} to the internet."
editable: false
---

# Pricing for {{ mmy-name }}

{{ mmy-name }} usage is rated by the pricing policy described in this section.

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmy-short-name }} {#rules}

The {{ mmy-name }} usage cost is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

{% if product == "cloud-il" %}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

{% endif %}

{% if product == "yandex-cloud" %}

There are different ways to calculate the cost depending on the [host type](concepts/index.md):

* Standard hosts

  The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

* Dedicated hosts

  The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../compute/pricing.md#prices) and {{ mmy-name }} markup for using these resources.

Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

{% endif %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ MY }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

   {% if product == "yandex-cloud" %}

   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
      * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
      * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments.

   * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

   {% endif %}

* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * The number of hosts in the cluster doesn't affect the size of the storage and, consequently, of free backups.

The cost is specified for one month of use and is based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if product == "yandex-cloud" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mmy-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

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

Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The cost of storage on local SSDs (`local-ssd`) also depends on the host type.

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}

{% if product == "yandex-cloud" %}

{% list tabs %}

- Standard hosts

   {% if region == "ru" %} {% include [RUB: standard hosts](../_pricing/managed-mysql/rub-hosts-standard.md) %} {% endif %}
   {% if region == "kz" %} {% include [KZT: standard hosts](../_pricing/managed-mysql/kzt-hosts-standard.md) %} {% endif %}
   {% if region == "int" %} {% include [USD: standard hosts](../_pricing/managed-mysql/usd-hosts-standard.md) %} {% endif %}

- Dedicated hosts

  The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../compute/pricing.md#prices) and {{ mmy-name }} markup for using these resources.

   {% if region == "ru" %} {% include [RUB: dedicated hosts](../_pricing/managed-mysql/rub-hosts-dedicated.md) %} {% endif %}
   {% if region == "kz" %} {% include [KZT: dedicated hosts](../_pricing/managed-mysql/kzt-hosts-dedicated.md) %} {% endif %}
   {% if region == "int" %} {% include [USD: dedicated hosts](../_pricing/managed-mysql/usd-hosts-dedicated.md) %} {% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-host.md](../_pricing/managed-mysql/ils-host.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if product == "yandex-cloud" %}

{% list tabs %}

- Standard hosts

   {% include [local-ssd for Ice Lake by query only](../_includes/ice-lake-local-ssd-note.md) %}

   {% if region == "ru" %} {% include [rub-storage-standard.md](../_pricing/managed-mysql/rub-storage-standard.md) %} {% endif %}
   {% if region == "kz" %} {% include [kzt-storage-standard.md](../_pricing/managed-mysql/kzt-storage-standard.md) %} {% endif %}
   {% if region == "int" %} {% include [usd-storage-standard.md](../_pricing/managed-mysql/usd-storage-standard.md) %} {% endif %}

- Dedicated hosts

   The cost is made up of two components: the [{{ compute-full-name }} storage cost](../compute/pricing.md#prices) and the {{ mmy-name }} price for it. All prices are shown per 1 GB per month.

   {% if region == "ru" %} {% include [rub-storage-dedicated.md](../_pricing/managed-mysql/rub-storage-dedicated.md) %} {% endif %}
   {% if region == "kz" %} {% include [kzt-storage-dedicated.md](../_pricing/managed-mysql/kzt-storage-dedicated.md) %}{% endif %}
   {% if region == "int" %} {% include [usd-storage-dedicated.md](../_pricing/managed-mysql/usd-storage-dedicated.md) %} {% endif %}

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-storage.md](../_pricing/managed-mysql/ils-storage.md) %}

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
