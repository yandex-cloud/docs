---
editable: false
---

# {{ mos-name }} pricing

In this section, you can find {{ mos-name }} pricing [rules](#rules) and [effective prices](#prices) for the service resources.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and your storage size.
* For a `Stopped` cluster, you only pay for your storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mos-short-name }} {#rules}

The {{ mos-name }} usage cost is based on:

* Computing resources allocated to cluster hosts (including hosts with the `MANAGER` role).

* Disk type and disk space.

* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

Host operation cost depends on what resources you allocate for it. You can find supported resource configurations in the [Host classes](concepts/instance-types.md) section, and vCPU and RAM prices, in the [Prices](#prices) section.

You can select host class both for hosts with the `DATA` role and hosts with the `MANAGER` and `DASHBOARDS` roles.

Host operation cost is charged per hour. The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You are not paying for the time when the {{ OS }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for clusters.

* Storage taken up by backups over specified cluster storage.

   * Backups are stored free of charge as long as the combined size of the data in the cluster and all backups is smaller than the selected storage size.

   * When performing automatic backups, {{ mos-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

   * The number of hosts in a cluster does not affect the storage volume and, consequently, the free volume of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mos-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. For non-supported resources, CVoS columns feature dashes under [Prices](#prices). Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}




{% include [usd-hosts-and-storage.md](../_pricing/managed-opensearch/usd-hosts-and-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
