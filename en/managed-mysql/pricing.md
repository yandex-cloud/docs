---
editable: false
---

# Pricing for {{ mmy-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmy-short-name }} {#rules}

The cost of {{ mmy-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one minute (for example, the cost of 1.5 minutes of operation is the same as the cost of 2 minutes of operation). You are not charged for time when the {{ MY }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with three or more hosts:
        * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
        * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.

    * Storage on non-replicated network drives (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts in 93 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, the cost of storing 1 GB for 1.5 minutes is equal to the cost of storage for 2 minutes).


## Pricing {#prices}



All prices are shown without VAT.

### Host computing resources {#prices-hosts}




{% include notitle [usd-host.md](../_pricing/managed-mysql/usd-host.md) %}

### Storage and backups {#prices-storage}




{% include notitle [usd-storage.md](../_pricing/managed-mysql/usd-storage.md) %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

