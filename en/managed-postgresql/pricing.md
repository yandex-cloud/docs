---
title: "Pricing for {{mpg-name }}"
description: "The cost of {{ mpg-name }} usage is calculated based on the disk type and storage size, computing resources allocated to cluster hosts, the settings and number of backups, and the amount of outgoing traffic from {{ yandex-cloud }} to the internet."

editable: false
---

# {{ mpg-name }} pricing

In this section, you can find {{ mpg-name }} pricing [rules](#rules) and [effective prices](#prices) for the service resources.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mpg-short-name }} {#rules}

The {{ mpg-name }} usage cost is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

Host operation cost is charged per hour based on host class. You can find detailed class specifications in the [Host classes](concepts/instance-types.md) section.

The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You are not paying for the time when the {{ PG }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for DB clusters.

   * You can only order local SSD (`local-ssd`) storage for clusters with three or more hosts:
            * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
      * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.

   * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

* Space used by DB backups in excess of the storage amount specified for the cluster.

   {% note info %}

   The cluster's storage size is equal to the total storage size of all of its hosts.

   {% endnote %}

   * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.

   * When performing automatic backups, {{ mpg-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

   * Adding hosts increases the cluster's total storage size and, consequently, the free volume of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mpg-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. For non-supported resources, CVoS columns feature dashes under [Prices](#prices). Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}




{% include [usd-host-resources.md](../_pricing/managed-postgresql/usd-host-resources.md) %}


### Storage and backups {#prices-storage}

{% include [ice-lake-local-ssd-note](../_includes/ice-lake-local-ssd-note.md) %}




{% include [usd-storage.md](../_pricing/managed-postgresql/usd-storage.md) %}


Pricing for backup storage has the following specifics:

* Backups are stored free of charge as long as the combined size of the database and all backups is less than the total storage size.

* [Adding a host](./operations/hosts#add) increases the total cost per cluster. However, expenses for storing backups beyond the storage size will be lower due to the increased total storage size.

* To reduce expenses for storing backups beyond the storage size:

   * Reduce the retention period of automatic backups in the [advanced settings](./operations/update#change-additional-settings).
   * [Delete backups](./operations/cluster-backups.md#delete) created manually.

* {% include [backup-wal](../_includes/mdb/mpg/backup-wal.md) %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}