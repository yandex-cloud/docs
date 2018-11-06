# Questions about [!KEYREF PG]

#### How to import data to a [!KEYREF PG] database cluster in [!KEYREF mdb-short-name]? {#migrate}

Use the built-in tool `pg_dump` to migrate data to a [!KEYREF PG] cluster in [!KEYREF mdb-short-name].

#### Which [!KEYREF PG] versions does [!KEYREF mdb-short-name] support? {#supported-version}

[!KEYREF mdb-short-name] supports only [!KEYREF PG] 10.

#### Is DB cluster backup enabled by default? {#backup}

Yes, backup is enabled by default. For [!KEYREF PG] clusters, a full backup is performed once a day with all DB cluster transaction logs saved. This allows you to restore the cluster state as of any point in time during the backup storage period, except for the last 30 seconds.

#### Is a [!KEYREF PG] DB cluster connection encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in [!KEYREF PG]? {#read-only-instance}

A read-only replica is a host in a [!KEYREF PG] DB cluster that can only be read. Its data is synced with the master host (applies only if the cluster has more than 1 host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What extensions for [!KEYREF PG] are supported in [!KEYREF mdb-short-name]? {#pg-extension}

The list of supported extensions for [!KEYREF PG] is given in the section [[!TITLE]](../operations/postgresql/cluster-extensions.md).

#### What limitations are imposed on [!KEYREF PG] database clusters? {#instance-limitations}

Learn more about [!KEYREF mdb-short-name] limitations in the section [[!TITLE]](../concepts/limits.md). The section [[!TITLE]](../concepts/instance-types.md) provides characteristics of clusters that can be created using [!KEYREF mdb-short-name].

