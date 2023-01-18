---
title: "Pricing for {{ mpg-name }}"
description: "The cost of {{ mpg-name }} usage is based on storage type and size (disk space), the computing resources allocated to the hosts in the cluster, settings and number of backups and outgoing traffic from {{ yandex-cloud }} to the internet."

editable: false
---

# Pricing for {{ mpg-name }}

{{ mpg-name }} usage is rated by the rules described in this section.


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mpg-short-name }} {#rules}

The {{ mpg-name }} usage cost is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. Exact class characteristics are given in [{#T}](concepts/instance-types.md).

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ PG }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

   
   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
      * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
      * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.

   * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.


* Space used by DB backups in excess of the storage amount specified for the cluster.

   {% note info %}

   The cluster's storage size is equal to the total storage size of all of its hosts.

   {% endnote %}

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * During an automatic backup, {{ mpg-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * Adding hosts increases the cluster's total storage size and, consequently, the size of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mpg-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}


All prices are shown without VAT.


### Host computing resources {#prices-hosts}





{% include notitle [usd-host-resources.md](../_pricing/managed-postgresql/usd-host-resources.md) %}




### Storage and backups {#prices-storage}





{% include notitle [usd-storage.md](../_pricing/managed-postgresql/usd-storage.md) %}




Pricing for backup storage has the following specifics:

* Backups are stored free of charge as long as the combined size of the database and all backups is less than the total storage size.

* [Adding a host](./operations/hosts#add) increases the total cost per cluster. However, expenses for storing backups beyond the storage size will be lower due to the increased total storage size.

* To reduce expenses for storing backups beyond the storage size:

   * Reduce the retention period of automatic backups in the [advanced settings](./operations/update#change-additional-settings).
   * [Delete backups](./operations/cluster-backups.md#delete) created manually.

* {% include [backup-wal](../_includes/mdb/mpg/backup-wal.md) %}

### Egress traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



