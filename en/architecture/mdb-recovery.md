---
title: Restoring database clusters in {{ yandex-cloud }} in case of an availability zone failure
description: 'The process of restoring managed database clusters if an availability zone fails: restoring from a backup, replacing hosts, and contacting support.'
---

# Restoring database clusters in case of an availability zone failure

This section offers practical advice on how to restore data if [{{ yandex-cloud }} zones are unavailable](https://status.yandex.cloud/ru/incidents/2136?retpath=%2Fru%2Ftimeline$0).

## Basic recommendations for different failures {#general}

If one of the availability zones is unavailable, the process depends on the host location and cluster state. In the examples below, the `ru-central1-b` is assumed to be unavailable. Select the appropriate use case:

* [All cluster hosts are in the unavailable zone](#all-hosts-in-zone-b).
* [Some hosts are in the available zone; the master switched](#master-switched).
* [Some hosts are in the available zone; the master did not switch, and the cluster is read-only](#read-only).
* [The cluster does not have hosts in the unavailable zone](#no-hosts-in-zone-b).

### All cluster hosts are in the unavailable zone {#all-hosts-in-zone-b}

To reduce the downtime, do not wait for the availability zone to become available again and start restoring from a backup.

1. Check the available cluster’s backups and choose the restore point. Recovery to a certain time period depends on the service and backup type.
1. Restore your cluster from a backup using your service’s guide. When configuring the new cluster, locate its hosts in different availability zones.
1. Wait until the recovery is complete, check the data, and configure your application connection to the new cluster.

{% note warning %}

Data missing for the selected restore point will be missing in the new cluster. If you do not have an appropriate backup or recovery fails, [contact support]({{ link-console-support }}).

{% endnote %}

Guide on restoring from a backup:

#|
|| **Service** | **Guide** ||
|| {{ mpg-name }} | [Restoring a cluster](../managed-postgresql/operations/cluster-backups.md#restore) ||
|| {{ mmy-name }} | [Restoring a cluster](../managed-mysql/operations/cluster-backups.md#restore) ||
|| {{ mch-name }} | [Restoring a cluster or shard](../managed-clickhouse/operations/cluster-backups.md#restore) ||
|| {{ mrd-name }} | [Restoring a cluster](../managed-valkey/operations/cluster-backups.md#restore) ||
|| {{ mmg-name }} | [Restoring a cluster](../storedoc/operations/cluster-backups.md#restore) ||
|| {{ mos-name }} | [Restoring a cluster](../managed-opensearch/operations/cluster-backups.md#restore) ||
|| {{ mgp-name }} | [Restoring a cluster](../managed-greenplum/operations/cluster-backups.md#restore) ||
|| {{ mspqr-name }} | [Restoring a cluster](../managed-spqr/operations/cluster-backups.md#restore) ||
|#

A {{ mspqr-name }} backup contains shard configuration. Restore the shard data separately in {{ mpg-name }} if needed.

### Some hosts are in the available zone; the master switched {#master-switched}

This use case is suitable for a multi-host cluster if a master switched to a host in a different availability zone.

1. Make sure your application connects to the new master and can write data.
1. If adding hosts is not available, add hosts to a different zones to replace the unavailable ones. If you cannot add hosts, [contact support]({{ link-console-support }}).
1. What until the new hosts sync data and will be able to operate. Then delete the hosts in the `ru-central1-b` zone considering the service limit on the minimum number of hosts. If deletion is temporarily unavailable, try again later.

Guides on managing hosts:

#|
|| **Service** | **Adding a host** | **Deleting a host** ||
|| {{ mpg-name }} | [Guide](../managed-postgresql/operations/hosts.md#add) | [Guide](../managed-postgresql/operations/hosts.md#remove) ||
|| {{ mmy-name }} | [Guide](../managed-mysql/operations/hosts.md#add) | [Guide](../managed-mysql/operations/hosts.md#remove) ||
|| {{ mrd-name }} | [Guide](../managed-valkey/operations/hosts.md#add) | [Guide](../managed-valkey/operations/hosts.md#remove) ||
|| {{ mmg-name }} | [Guide](../storedoc/operations/hosts.md#add-host) | [Guide](../storedoc/operations/hosts.md#remove-host) ||
|#

### Master did not switch, and the cluster is read-only {#read-only}

This use case is suitable for a multi-host cluster with some hosts in the `ru-central1-b` zone, if a master did not switch, and the cluster switched to read-only (RO).

Automatic master switch may not occur because of the risk of data loss. In this use case, you cannot switch the master manually.

1. [Contact support]({{ link-console-support }}). Specify the cluster ID and describe its state.
1. Wait for the support team to switch your master.
1. Perform the actions described in the [use case where the master switched](#master-switched).

### The cluster does not have hosts in the unavailable zone {#no-hosts-in-zone-b}

To prepare for possible failures of other availability zones:

1. Check the cluster’s and application’s configuration using [these recommendations on fault tolerance](fault-tolerance.md). Consider your service requirements to the host location and number.
1. If you need to set up data transfer and replication, check [these {{ data-transfer-name }} guides](../data-transfer/operations/index.md) and [requirements on preparing the source and target](../data-transfer/operations/prepare.md).

## Data migration from managed database backups to third-party clusters {#outbound-backup}

If {{ yandex-cloud }} managed database backups are stored in {{ objstorage-name }} with replication across three zones, your data is preserved.
To save a copy of your data, you can upload managed database hosts in available zones as per the guides below:

#|
|| **Service** | **Guide** ||
|| {{ mpg-name }} | [Restoring a cluster from `pg_dump`](https://www.postgresql.org/docs/current/app-pgdump.html) ||
|| {{ mmy-name }} | [Restoring a cluster from a dump](../tutorials/dataplatform/mysql-data-migration/logical-dump-migration.md#dump) ||
|| {{ mmg-name }} | [Restoring a cluster from a dump](../tutorials/dataplatform/storedoc-data-migration.md#dump) ||
|| {{ mrd-name }} | [Restoring a cluster from a dump](../tutorials/dataplatform/valkey-data-migration.md#create-dump) ||
|| {{ mch-name }} | [Restoring from S3](https://clickhouse.com/docs/concepts/features/backup-restore/s3-endpoint) ||
|| {{ mos-name }} | [Restoring a cluster from a backup using the {{ OS }} API](../managed-opensearch/operations/cluster-backups.md#mos-backup) ||
|| {{ mkf-name }} | No automatic backups are provided||
|| {{ mgp-name }} | Use `PXF writable external table` to upload tables to parquet or any other file format available in PXF. Or use the standard `pg_dump` {{ PG }} utility to upload data from specific tables. ||
|#

## Data migration from managed database services to a third-party cluster using replication {#pg-replication}

If you have an available {{ yandex-cloud }} host, you can copy its data to a self-hosted database instance using replication:

#|
|| **Service** | **Guide** ||
|| {{ mpg-name }} | [Migrating a database using logical replication](../tutorials/dataplatform/outbound-replication.md) ||
|| {{ mmy-name }} | [Migrating a database from {{ yandex-cloud }} to a third-party cluster](../tutorials/dataplatform/mmy-to-mysql-migration.md) ||
|| {{ mrd-name }} | [Restoring data from an available host](../managed-valkey/operations/data-recovery.md) ||
|#

## Data migration from managed database services to a Selectel cluster using {{ mtr-name }} {#selectel-trino}

There is a method available for data migration to Selectel infrastructure using {{ mtr-name }}:

#|
|| **Service** | **Guide** ||
|| {{ mpg-name }} | [Migrating data from {{ PG }} to a {{ PG }} cloud database using {{ TR }}](https://docs.selectel.ru/migrations/migrate-data-postgres-to-cloud-postgres-trino/) ||
|| {{ mmy-name }} | [Migrating data from {{ MY }} to a {{ MY }} cloud database using {{ TR }}](https://docs.selectel.ru/migrations/migrate-mysql-data-to-cloud-mysql-with-trino/) ||
|| {{ mch-name }} | [Migrating data from {{ CH }} to a {{ CH }} cloud database using {{ TR }}](https://docs.selectel.ru/migrations/migrate-clickhouse-data-to-cloud-clickhouse-with-trino/) ||
|#
