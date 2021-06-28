# Questions about {{ PG }}

#### How do I import data to a {{ PG }} database cluster in {{ mpg-short-name }}? {#migrate}

Use the `pg_dump` built-in tool to migrate data to a {{ PG }} cluster in {{ mpg-short-name }}.

#### What {{ PG }} versions does {{ mpg-short-name }} support? {#supported-version}

{{ mpg-short-name }} supports {{ PG }} 10, 11, 12, and 13 as well as PostgreSQL 10, 11, and 12 for 1C.

#### Are DB cluster backups enabled by default? {#backup}

Yes, backup is enabled by default. For {{ PG }} clusters, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

#### Are {{ PG }} database cluster connections encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in {{ PG }}? {#read-only-instance}

A read-only replica is a host in a {{ PG }} DB cluster that can only be read. Its data is synced with the master host (applies only if the cluster has more than 1 host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What {{ PG }} extensions are supported in {{ mpg-short-name }}? {#pg-extension}

The list of supported {{ PG }} extensions is provided in [{#T}](../operations/cluster-extensions.md).

#### What limitations are imposed on {{ PG }} database clusters? {#instance-limitations}

For more information about {{ mpg-short-name }} limitations, see [{#T}](../concepts/limits.md). Characteristics of clusters that can be created using {{ mpg-short-name }} are given in [{#T}](../concepts/instance-types.md).

#### Which LC_COLLATE and LC_CTYPE values are set for databases by default? {#which-lc-collate-and-lc-lctype-values-are-set-for-databases-by-default}

When databases are created, `LC_CTYPE=C` and `LC_COLLATE=C` are set by default. You can't change these settings for the database you create along with the cluster. However, you can [create a new database](../operations/databases.md) and set the values you need for it.

