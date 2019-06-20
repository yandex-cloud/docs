# Questions about {{ PG }}

#### How to import data to a {{ PG }} database cluster in {{ mpg-short-name }}? {#migrate}

Use the built-in tool `pg_dump` to migrate data to a {{ PG }} cluster in {{ mpg-short-name }}.

#### Which {{ PG }} versions does {{ mpg-short-name }} support? {#supported-version}

{{ mpg-short-name }} supports only {{ PG }} 10 and 11.

#### Is DB cluster backup enabled by default? {#backup}

Yes, backup is enabled by default. For {{ PG }} clusters, a full backup is performed once a day with all DB cluster transaction logs saved. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

#### Is a {{ PG }} DB cluster connection encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in {{ PG }}? {#read-only-instance}

A read-only replica is a host in a {{ PG }} DB cluster that can only be read. Its data is synced with the master host (applies only if the cluster has more than one host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What extensions for {{ PG }} are supported in {{ mpg-short-name }}? {#pg-extension}

The list of supported extensions for {{ PG }} is given in the section [#T](../operations/cluster-extensions.md).

#### What limitations are imposed on {{ PG }} database clusters? {#instance-limitations}

Learn more about {{ mpg-short-name }} limitations in the section [#T](../concepts/limits.md). The section [#T](../concepts/instance-types.md) provides characteristics of clusters that can be created using {{ mpg-short-name }}.

