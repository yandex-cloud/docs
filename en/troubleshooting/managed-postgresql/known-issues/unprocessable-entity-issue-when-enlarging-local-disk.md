# Fixing issues with updating configurations of clusters with `local-ssd`



## Issue description {#issue-description}

When trying to increase the storage size or change the host class of a {{ mpg-name }} cluster with `local-ssd`, you get one or multiple error messages:

* `UNPROCESSABLE ENTITY`
* `GATEWAY_REQUEST_ERROR`

## Solution {#issue-resolution}

You cannot increase your cluster storage size because the cluster uses `local-ssd`.

Try increasing the cluster size in increments of 100 GB for Intel Broadwell and Intel Cascade Lake, or in increments of 368 GB for the Intel Ice Lake. Make sure to [back up](../../../managed-postgresql/operations/cluster-backups.md#create-backup) your data in advance.

For clusters with this type of disk storage, we recommend changing the host class by [creating](../../../managed-postgresql/operations/cluster-backups.md#create-backup) and then [restoring](../../../managed-postgresql/operations/cluster-backups.md#restore) a backup.

## If the issue persists {#if-issue-still-persists}

If you need to change the configuration of an existing cluster with `local-ssd`, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the {{ mpg-name }} cluster for which you want to change the disk size or host class.
1. Description of the scenario where you need to change the disk configuration of an existing cluster.

{% note warning %}

When you update the configuration of an existing cluster with `local-ssd`, all cluster hosts will be undergoing maintenance one by one, including the master host.

The replicas will be queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable. If the master host needs restarting and becomes unavailable, one of the replicas will assume its role.

In case you use the master host's [FQDN](../../../managed-postgresql/concepts/network.md#hostname) to access the cluster, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [specific FQDN](../../../managed-postgresql/operations/connect.md#fqdn-master) that always points to the master host.

{% endnote %}
