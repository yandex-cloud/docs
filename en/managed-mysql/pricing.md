---
title: "Pricing for {{ mmy-name }}"
description: "The cost of {{ mmy-name }} usage is based on storage type and size (disk space), the computing resources allocated to the hosts in the cluster, settings and number of backups and outgoing traffic from cloud to the internet."
editable: false
---

# Pricing for {{ mmy-name }}

{{ mmy-name }} usage is rated by the rules described in this section.


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmy-short-name }} {#rules}

The {{ mmy-name }} usage cost is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ MY }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

   
   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
      * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
      * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments.

   * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.


* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * The number of hosts in the cluster doesn't affect the size of the storage and, consequently, of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mmy-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}


All prices are shown without VAT.


### Host computing resources {#prices-hosts}





{% include [usd-host.md](../_pricing/managed-mysql/usd-host.md) %}




### Storage and backups {#prices-storage}





{% include [usd-storage.md](../_pricing/managed-mysql/usd-storage.md) %}




### Egress traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



