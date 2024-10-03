---
title: Maintenance in {{ mgp-full-name }}
description: Maintenance in {{ mgp-name }} means automatic installation of DBMS updates and fixes for hosts (including disabled clusters), changing host class and storage size, and other maintenance activities.
---

# Maintenance in {{ mgp-name }}

There are two classes of maintenance operations in {{ mgp-name }}:

* [Non-routine cluster maintenance operations](#irregular-ops)
* [Routine database maintenance operations](#regular-ops)

## Non-routine maintenance operations {#irregular-ops}

Non-routine maintenance operations involve cluster software updates and post-failure host recovery. They may result in changes to cluster settings and a cluster's restart. During these operations current queries will be aborted and incomplete transactions will be canceled.

Non-routine maintenance operations related to updates are performed in a [specified order](#maintenance-order) during a [maintenance window](#maintenance-window). These operations include:

* Installing minor {{ GP }} updates. This results in DBMS restart.
* Installing PXF updates. This results in PXF restart.
* Restarting cluster hosts required for cloud infrastructure scheduled maintenance (replacing failed components, installing system updates, performing scheduled hardware maintenance, etc.).
* Installing security updates on cluster hosts. This results in host restart.

Non-routine maintenance operations related to cluster recovery can be performed at any time as needed. These operations include:

* Recovering data after a physical host or non-replicated disk fails in the cloud infrastructure.
* [Segment rebalancing](https://docs.vmware.com/en/VMware-Greenplum/5/greenplum-database/utility_guide-admin_utilities-gprecoverseg.html): Resetting preferred segment roles after a host or its segments are restored.

### Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

### Maintenance procedure {#maintenance-order}

Maintenance related to software updates is performed as follows:

1. [Segment hosts](index.md) undergo maintenance one by one. The hosts are queued randomly. If a segment host needs to be restarted during maintenance, it becomes unavailable while being restarted.
1. Maintenance is performed on the `STANDBY` master host. If it needs to be restarted during maintenance, it becomes unavailable while being restarted.
1. Maintenance is performed on the `PRIMARY` master host. If it is restarted during maintenance and becomes unavailable, the standby master host will take its role. If you access a cluster using the FQDN of the primary master host, the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#fqdn-master) always pointing to the primary master host.

## Routine maintenance operations {#regular-ops}

Routine maintenance operations are required to ensure proper database performance. They are run regularly on a certain schedule and do not abort current queries. These operations include:

* Vacuuming (`VACUUM`) system folder tables. This operation is run three times a day.
* [Custom table vacuuming](#custom-table-vacuum).
* [Statistics collection](#get-statistics).
* [Backup](./backup.md).

Data redistribution during [cluster expansion](../concepts/expand.md) can be run as a [background process](../concepts/expand.md#setting-delay-redistribution) while not being a routine maintenance operation. The process will be started after the vacuuming of tables, but before collecting the statistics.

### Custom table vacuuming {#custom-table-vacuum}

Custom tables are vacuumed daily. Databases are handled concurrently in two threads. In each database, tables on which VACUUM has not been run yet are handled first. Then the remaining tables are handled, starting with the one on which VACUUM has not been run the longest.

Two vacuuming modes are supported:

* Sequential: Tables are handled one by one. The total operation execution time is limited with a soft timeout: when it is reached, the vacuuming of the current table is completed, and then the process is terminated.
* Concurrent: Tables are handled in two threads. This mode uses a hard timeout: when it is reached, all vacuuming processes are forced to terminate.

The default mode is sequential. To switch to concurrent table vacuuming mode, contact [technical support]({{ link-console-support }}).

The start time and timeout of the `VACUUM` operation are set up when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md).

### Statistics collection {#get-statistics}

Statistics collection (the `ANALYZE` operation) is performed after the vacuuming of tables (if [background data redistribution](../concepts/expand.md#setting-delay-redistribution) is not in progress). Databases are handled concurrently in two threads. In addition, two threads are run to collect table statistics in each database. As a result, statistics can be collected in four threads.

The [analyzedb](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/utility_guide-ref-analyzedb.html) utility is used to collect statistics. It runs the `ANALYZE` command for all [append-optimized (AO) tables](./tables.md) modified since the last time the utility collected the statistics, as well as for all heap tables without exception.

Statistics collection from each database is limited with a timeout which is specified in the settings when [creating](../operations/cluster-create.md) or [updating](../operations/update.md) a cluster. The total statistics collection time is not limited.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
