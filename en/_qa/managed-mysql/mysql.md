# Questions about {{ MY }}

#### What {{ MY }} versions does {{ mmy-short-name }} support? {#supported-version}

{{ mmy-short-name }} supports {{ MY }} 5.7 and {{ MY }} 8.

#### Are DB cluster backups enabled by default? {#backup}

Yes, backup is enabled by default. For {{ MY }} clusters, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

#### Are {{ MY }} database cluster connections encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in {{ MY }}? {#read-only-instance}

A read-only replica is a host in a {{ MY }} DB cluster that can only be read. Its data is synced with the master host (if the cluster has more than one host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What limitations are imposed on {{ MY }} database clusters? {#instance-limitations}

For more information about {{ mmy-short-name }} limits, see [{#T}](../../managed-mysql/concepts/limits.md). Characteristics of clusters that can be created using {{ mmy-short-name }} are given in [{#T}](../../managed-mysql/concepts/instance-types.md).

