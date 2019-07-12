# Questions about PostgreSQL

#### How do I import data to a PostgreSQL database cluster in Managed Service for PostgreSQL? {#migrate}

Use the built-in `pg_dump` tool for migrating data to the PostgreSQL cluster Managed Service for PostgreSQL.

#### Which versions of PostgreSQL support {{ mpg-short-name }? {#supported-version}

Managed Service for PostgreSQL supports PostgreSQL 10 and 11.

#### Is DB cluster backup enabled by default? {#backup}

Yes, backup is enabled by default. For PostgreSQL clusters, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

#### Are PostgreSQL database cluster connections encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in PostgreSQL? {#read-only-instance}

A read-only replica is a host in a PostgreSQL database cluster that can only be read. Its data is synced with the master host (applies only if the cluster has more than one host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What PostgreSQL extensions are supported in Managed Service for PostgreSQL? {#pg-extension}

The list of supported PostgreSQL extensions is provided in [#T](../operations/cluster-extensions.md).

#### What limitations are imposed on PostgreSQL database clusters? {#instance-limitations}

For more information about Managed Service for PostgreSQL restrictions, see [#T](../concepts/limits.md). Characteristics of clusters that can be created using Managed Service for PostgreSQL are given in [#T](../concepts/instance-types.md).

