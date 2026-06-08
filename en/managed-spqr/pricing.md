---
title: '{{ mspqr-full-name }} pricing policy'
description: This article covers the {{ mspqr-name }} pricing policy.
editable: false
keywords:
  - keyword: '{{ SPQR }}'
  - keyword: '{{ mspqr-full-name }}'
  - keyword: '{{ mspqr-name }}'
---

# {{ mspqr-name }} pricing policy



In this section, you can find the {{ mspqr-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mspqr-name }} {#rules}

The {{ mspqr-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Database host usage {#rules-hosts-uptime}

The host operation cost is charged per hour based on the host class. For detailed class specifications, see [Host classes](concepts/instance-types.md).

The minimum billing unit is one minute, e.g., 1.5 minutes of host operation cost the same as two minutes. You will not be charged for the time when the host is unavailable for basic operations.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for database clusters.

    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:

        * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
        * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.

    * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

* Space occupied by DB backups beyond the storage size specified for the cluster.

    {% note info %}

    The cluster's storage size is equal to the total storage size of all of its hosts.

    {% endnote %}

    * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.

    * When performing automatic backups, {{ mspqr-name }} does not create a new backup but saves the database changes introduced since the previous one. This means the storage space used by automatic backups increases only in proportion to the size of updates.

    * Adding hosts increases the cluster's total storage size and, consequently, the free amount of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes costs the same as for 2 minutes.

## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mpg-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at your current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}

{% include [ice-lake-local-ssd-note](../_includes/ice-lake-local-ssd-note.md) %}

Pricing for backup storage has the following specifics:

* Backups are stored free of charge as long as the combined size of the database and all backups is smaller than the total storage size.

* Adding a host increases the total cost per cluster. However, expenses for storing backups beyond the storage size will be lower due to the increased total storage size.

* To reduce expenses for storing backups beyond the storage size:

    * Reduce the retention period for automatic backups in the [advanced settings](./operations/cluster-update.md).
    * Delete the backups created manually.

* {% include [backup-wal](../_includes/mdb/mpg/backup-wal.md) %}



{% note info %}

The prices indicated are valid from June 16, 2026.

{% endnote %}

{% include [usd-prices](../_pricing/managed-spqr/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
