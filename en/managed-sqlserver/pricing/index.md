---
editable: false
---

# Pricing for {{ mms-name }}

{% note info %}

* This pricing policy is valid through February 28, 2022.
* For the pricing policy that will be in effect starting March 1, 2022, see [{#T}](pricing-01032022.md).

{% endnote %}

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* `Running` cluster: You pay for software licenses, computing resources, storage, and backups.
* `Stopped` cluster: You're charged for storage and backups in full, but pricing for software licenses is described in [{#T}](#license). Computing resources are free of charge.

  {% note alert %}

  If a cluster uses local SSD storage (`local-ssd`), its computing resources are not released when it is stopped and are charged in full.

  {% endnote %}

## What goes into the cost of using {{ mms-short-name }} {#rules}

The cost of {{ mms-name }} usage is based on:

* The cost of licenses for Windows Server Datacenter and Microsoft SQL Server.

{% include [pricing-rules](../../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Software license usage {#license}

You're charged for using licenses on an pre-payment basis. This means that a fee is charged at the beginning of a billing period before you actually start using the service resources. In this case:

* The billing period is one calendar month.
* If you create a new cluster during the billing period, the license cost is calculated based on the number of days remaining in the billing period. For example, if there are 30 days in the month and 7 days left until the end of the month, you'll pay 7/30 of the monthly license cost.
* If you stop or delete your cluster during the billing period, license costs for this period are not refunded.
* If you start a cluster that was stopped in the previous period, you need to pay the full license cost for the entire billing period. If you stop and start a cluster multiple times within one period, you need to pay the license cost only at the first start.
* If you change the cluster configuration and reduce resource consumption, the cost of released licenses for this period is not refunded. A new cost is valid from the first day of the following month.
* If you change the cluster configuration and increase resource consumption, you need additional licenses. Their cost is calculated based on the number of days remaining in the billing period. For example, if there are 30 days in the month and 7 days left until the end of the month, you'll additionally pay 7/30 of the monthly cost of new licenses.
* Multi-host {{ MS }} clusters with [unreadable secondary replicas](../concepts/replication.md#readable-and-non-readable-replicas) require only one Microsoft SQL Server Enterprise license: for the primary replica.
* Multi-host {{ MS }} clusters with [readable secondary replicas](../concepts/replication.md#readable-and-non-readable-replicas) require a Microsoft SQL Server Enterprise license for each replica.

### DB host usage {#rules-hosts-uptime}

The cost of using DB hosts is calculated according to their class. Exact class characteristics are given in [{#T}](../concepts/instance-types.md). The host usage fee is charged in accordance with the agreement.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when the DB host is not performing its main functions.

### Disk space usage {#rules-storage}

The disk space usage fee is charged in accordance with the agreement. The following is charged:

* Storage allocated for DB clusters.

    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
       * For Intel Cascade Lake: In increments of 100 GB.
       * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.

    * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mms-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

## Pricing {#prices}

  
All prices are shown without VAT.




{% include [usd-pricing.md](../../_pricing/managed-sqlserver/usd-pricing.md) %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

