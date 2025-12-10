#### Which {{ MY }} versions does {{ mmy-short-name }} support? {#supported-version}

{{ mmy-short-name }} supports {{ MY }} 5.7 and {{ MY }} 8.

#### Is database cluster backup enabled by default? {#backup}

Yes, backups are enabled by default. The {{ MY }} cluster backup policies provide full daily backups and continuous transaction log archiving. This enables you to restore your cluster to any point in time within the backup retention period, except for the last 30 seconds.

#### Is encryption enabled for {{ MY }} database cluster connections? {#encryption}

Connections between your database cluster and application are always encrypted with SSL. You cannot disable encryption for cluster connections.

#### What is a read-only replica in {{ MY }}? {#read-only-instance}

A read-only replica is a {{ MY }} database cluster host available only for reads that synchronizes its data with the master host. This applies only to clusters with more than one host. You can use a read-only replica to reduce the load on the master host experiencing high read traffic to its database.

#### What restrictions are placed on {{ MY }} database clusters? {#instance-limitations}

For details, see [Quotas and limits](../../managed-mysql/concepts/limits.md) for {{ mmy-short-name }}. To learn about the properties of the clusters you can create with {{ mmy-short-name }}, see [Host classes](../../managed-mysql/concepts/instance-types.md).

#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when [updating your cluster](../../managed-mysql/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-mysql/operations/cluster-backups.md#restore) from a backup.
