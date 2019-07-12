# Questions about MySQL

#### Which MySQL versions does Managed Service for MySQL support? {#supported-version}

Managed Service for MySQL supports only MySQL 5.7.

#### Is DB cluster backup enabled by default? {#backup}

Yes, backup is enabled by default. For MySQL clusters, a full backup is performed once a day with all DB cluster transaction logs saved. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

#### Is a MySQL DB cluster connection encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in MySQL? {#read-only-instance}

A read-only replica is a host in a MySQL DB cluster that can only be read. Its data is synced with the master host (if the cluster has more than one host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What limitations are imposed on MySQL database clusters? {#instance-limitations}

Learn more about Managed Service for MySQL limitations in the section [#T](../concepts/limits.md). The section [#T](../concepts/instance-types.md) provides characteristics of clusters that can be created using Managed Service for MySQL.

