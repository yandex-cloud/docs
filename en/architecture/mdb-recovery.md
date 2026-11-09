---
title: Restoring database clusters in {{ yandex-cloud }} in case of an availability zone failure
description: 'The process of restoring managed database clusters if an availability zone fails: restoring from a backup, replacing hosts, and contacting support.'
---

# Restoring database clusters in case of an availability zone failure

If one of the availability zones is unavailable, the process depends on the host location and cluster state. In the examples below, the `ru-central1-b` is assumed to be unavailable. Select the appropriate use case:

* [All cluster hosts are in the unavailable zone](#all-hosts-in-zone-b).
* [Some hosts are in the available zone; the master switched](#master-switched).
* [Some hosts are in the available zone; the master did not switch, and the cluster is read-only](#read-only).
* [The cluster does not have hosts in the unavailable zone](#no-hosts-in-zone-b).

## All cluster hosts are in the unavailable zone {#all-hosts-in-zone-b}

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

## Some hosts are in the available zone; the master switched {#master-switched}

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

## Master did not switch, and the cluster is read-only {#read-only}

This use case is suitable for a multi-host cluster with some hosts in the `ru-central1-b` zone, if a master did not switch, and the cluster switched to read-only (RO).

Automatic master switch may not occur because of the risk of data loss. In this use case, you cannot switch the master manually.

1. [Contact support]({{ link-console-support }}). Specify the cluster ID and describe its state.
1. Wait for the support team to switch your master.
1. Perform the actions described in the [use case where the master switched](#master-switched).

## The cluster does not have hosts in the unavailable zone {#no-hosts-in-zone-b}

To prepare for possible failures of other availability zones:

1. Check the cluster’s and application’s configuration using [these recommendations on fault tolerance](fault-tolerance.md). Consider your service requirements to the host location and number.
1. If you need to set up data transfer and replication, check [these {{ data-transfer-name }} guides](../data-transfer/operations/index.md) and [requirements on preparing the source and target](../data-transfer/operations/prepare.md).

## Restoring a cluster from a backup using the {{ OS }} API {#mos-backup}

You can connect {{ objstorage-name }} to a {{ mos-name }} cluster as a snapshot repository. You will be able to create backups manually or on schedule using the [{{ OS }} Snapshot API](https://docs.opensearch.org/latest/api-reference/snapshots/index/).

1. [Create a repository](https://docs.opensearch.org/latest/api-reference/snapshots/create-repository/) to store snapshots specifying {{ objstorage-name }}.
1. [Create a policy](https://docs.opensearch.org/latest/tuning-your-cluster/availability-and-recovery/snapshots/sm-api/) for regular snapshot creation.
1. [Configure access permissions](../managed-opensearch/operations/s3-access.md#configure-acl) and [add the snapshot repository](../managed-opensearch/operations/s3-access.md#register-snapshot-repository) for your {{ mos-name }} cluster.
1. [Configure access permissions](../managed-opensearch/operations/s3-access.md#configure-acl) and [add the snapshot repository](../managed-opensearch/operations/s3-access.md#register-snapshot-repository) for your {{ mos-name }} cluster.

## Migrating a database from {{ mpg-name }} to a different {{ PG }} cluster using logical replication {#pg-replication}

A {{ mpg-name }} cluster supports [logical replication](https://www.postgresql.org/docs/current/logical-replication.html). This allows you to use built-in {{ PG }} tools for migrating databases across different {{ PG }} clusters.

To migrate a database, follow [this tutorial](../tutorials/dataplatform/outbound-replication.md).