---
editable: false
---

# Pricing policy for Managed Service for Elasticsearch

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* For a `Running` cluster, you pay both for the computing resources and storage size.
* For a `Stopped` cluster, you pay only for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mes-short-name }} {#rules}

The cost of {{ mes-name }} usage is based on:

* {{ ES }} edition used.

* Computing resources allocated to cluster hosts (including hosts with the `Master node role`).

* Storage type and size (disk space).

* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources and {{ ES }} edition used. Supported resource configurations are shown in [{#T}](concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

You can select the host class both for the hosts with the `Data node` role and hosts with the `Master node` role.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ ES }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.

* Storage taken up by backups over specified cluster storage.

   * Storing backups is free of charge as long as the total amount of data in a cluster together with all the backups stays under the selected storage size.

   * When performing automatic backups, {{ mes-short-name }} does not create a new copy, but stores data changes with respect to the previous backup. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).



## Pricing {#prices}


All prices are shown without VAT.


{% note info %}

As of June 13, 2022, the `Gold` [edition](./concepts/es-editions.md) in {{ mes-name }} clusters is no longer supported. You cannot create a new cluster with this edition or switch to it from `Basic` or `Platinum`. On July 6, 2022, the `Gold` edition of all clusters will be automatically upgraded to `Platinum` at the same cost until the end of 2022.

{% endnote %}




{% include [usd-hosts-and-storage.md](../_pricing/managed-elasticsearch/usd-hosts-and-storage.md) %}


### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


