---
editable: false
---

# Pricing for {{ mms-name }}

## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* `Running` cluster: You pay for software licenses, computing resources, storage, and backups.
* `Stopped` cluster: You're charged for storage and backups in full, but pricing for software licenses is described in [{#T}](#license). Computing resources are free of charge.

  {% note alert %}

  If a cluster uses local storage (`local-ssd`), its computing resources are not released when it's stopped and are charged in full.

  {% endnote %}

## What goes into the cost of using {{ mms-short-name }} {#rules}

The cost of {{ mms-name }} usage is based on:

* The cost of licenses for Windows Server Datacenter and Microsoft SQL Server.

{% include [pricing-rules](../../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Using software licenses {#license}

You're charged for using licenses on an pre-payment basis. This means that a fee is charged at the beginning of a billing period before you actually start using the service resources. In this case:

* The billing period is one calendar month.
* If you create a new cluster or recover an existing one from a backup at some point during a billing cycle, you will be charged the full cost of the licenses for the entire billing cycle.
* If you stop or delete your cluster during the billing period, license costs for this period are not refunded.
* The first time a cluster that was stopped prior to the current billing cycle is restarted, you will be charged the full cost of the licenses for the entire billing cycle. If you stop and start a cluster multiple times within one period, you need to pay the license cost only at the first start.
* If you change a cluster configuration and reduce resource usage during a billing cycle, the cost of the licenses released in this period is not subject to refund. The new pricing will take effect on the first day of the following billing cycle.
* If you change your cluster configuration and increase resource usage during a billing cycle, you will need additional licenses. If this is the case, you will be charged the full cost of these licenses for the entire billing cycle regardless of the date you made the changes.
* Multi-host {{ MS }} clusters with [non-readable secondary replicas](../concepts/replication.md#readable-and-non-readable-replicas) only require a Microsoft SQL Server Enterprise license for the primary replica.
* Multi-host {{ MS }} clusters with [readable secondary replicas](../concepts/replication.md#readable-and-non-readable-replicas) require a Microsoft SQL Server Enterprise license for each replica.

### DB host usage {#rules-hosts-uptime}

The cost of using DB hosts is calculated according to their class. Exact class characteristics are given in [{#T}](../concepts/instance-types.md). The host usage fee is charged in accordance with the agreement.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when the DB host is not performing its main functions.

### Disk space usage {#rules-storage}

The disk space usage fee is charged in accordance with the agreement. The following is charged:

* Storage allocated for DB clusters.

    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with three or more hosts:
       * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
       * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.

    * Storage on non-replicated network drives (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts in 93 GB increments.

* Space used by DB backups in excess of the storage amount specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During the backup process, {{ mms-short-name }} creates a full backup of all the databases.

    * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

## Pricing {#prices}


All prices are shown without VAT.





{% include [usd-pricing.md](../../_pricing/managed-sqlserver/usd-pricing.md) %}


### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}


