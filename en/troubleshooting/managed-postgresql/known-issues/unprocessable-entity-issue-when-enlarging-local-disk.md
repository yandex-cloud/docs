# Resolving issues with updating configurations of clusters with local-ssd disks


## Issue description {#issue-description}

When trying to increase the storage size or change the host class of a Managed Service for PostgreSQL cluster with `local-ssd` disks, you see one or more error messages:

* `UNPROCESSABLE ENTITY`
* `GATEWAY_REQUEST_ERROR`.

## Solution {#issue-resolution}

You cannot expand your cluster storage because the cluster uses `local-ssd` disks.

Try increasing the cluster size in steps of 100 GB (for Intel Broadwell and Intel Cascade Lake platforms) or in steps of 368 GB (for the Intel Ice Lake platform). Make sure to [back up](../../../managed-postgresql/operations/cluster-backups.md#create-backup) your data in advance.

For clusters with this type of disk storage, we recommend you to change the host class by [creating](../../../managed-postgresql/operations/cluster-backups.md#create-backup) and then [restoring](../../../managed-postgresql/operations/cluster-backups.md#restore) a backup.

## If the issue persists {#if-issue-still-persists}

If you have a critical need to change the configuration of an existing cluster with `local-ssd` disks, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. ID of the Managed Service for PostgreSQL cluster for which you want to change the disk size or host class.
2. Description of the use case where you need to change the disk configuration of an existing cluster.

When you update the configuration of an existing cluster on `local-ssd` disks, maintenance will be sequentially launched on all cluster hosts (including the master host).
The replicas are queued randomly. A replica becomes unavailable while it is being restarted during maintenance.
If it is restarted and becomes unavailable, one of the replicas takes its role.

In case you use the master host's [FQDN](../../../managed-postgresql/concepts/network.md#hostname) to access the cluster, such a cluster may become unavailable.
To make your application continuously available, access the cluster using a [special FQDN](../../../managed-postgresql/operations/connect.md#fqdn-master) that always points to the master host.
