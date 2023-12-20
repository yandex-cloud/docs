---
editable: false
---

# {{ mos-name }} pricing

In this section, you can find {{ mos-name }} pricing [rules](#rules) and [effective prices](#prices) for the service's resources.


{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* For a `Running` cluster, you pay both for the computing resources and storage size.
* For a `Stopped` cluster, you pay only for the storage size.


{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}



## What is included in {{ mos-short-name }} cost {#rules}

The {{ mos-name }} usage cost is based on:

* Computing resources allocated to cluster hosts (including hosts with the `MANAGER` role).

* Disk type and disk space.

* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}


The cost of host operation is determined by the allocated computing resources. Supported resource configurations are shown in the [Host classes](concepts/instance-types.md) section; vCPUs and RAM prices are quoted in the [Prices](#prices) section.

You can select host class both for hosts with the `DATA` role and hosts with the `MANAGER` and `DASHBOARDS` roles.



You are charged per hour of host operation. The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when the {{ OS }} host is not performing its main functions.

### Disk space usage {#rules-storage}

You are charged for the following:

* Storage allocated for clusters.

* Storage taken up by backups over specified cluster storage.

   * Storing backups is free of charge as long as the total amount of data in a cluster together with all the backups stays under the selected storage size.

   * When performing automatic backups, {{ mos-short-name }} does not create a new copy but stores data changes with respect to the previous backup. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use and is based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mos-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns feature dashes under [Prices](#prices). Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}


All prices are shown without VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}





{% include [usd-hosts-and-storage.md](../_pricing/managed-opensearch/usd-hosts-and-storage.md) %}




### Egress traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



