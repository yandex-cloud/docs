# Questions about [!KEYREF MG]

#### Why should I use [!KEYREF MG] in [!KEYREF mdb-short-name] and not my own installation on a VM? {#mongodb-advantages-vm}

[!KEYREF mdb-short-name] automates routine database maintenance:

- Quick DB deployment with the necessary available resources.
- Data backup.
- Regular software updates.
- DB cluster failover.
- Database usage monitoring and statistics.

#### How can I load data to [!KEYREF MG]? {#load-data}

#### What happens to a cluster if one of its hosts fails? {#node-out}

If there are more than one replica in the database cluster, it will continue working if a host fails.

The only way data may be lost is if the cluster's only host fails.

#### Is it possible to deploy a [!KEYREF MG] cluster in multiple availability zones? {#multiple-az}

Yes, it is. A database cluster may consist of hosts that reside in different availability zones and even different availability regions.

#### How is backup performed for[!KEYREF MG] clusters? {#backup}

Backups are created every 24 hours and stored for seven days after being created. You can restore data only as of backup creation time.

#### How does replication work for [!KEYREF MG]? {#replication}

[!KEYREF mdb-short-name] uses the standard [!KEYREF MG] replication mechanism: if a cluster has multiple active hosts, the primary server that handles write requests is automatically selected from them.

For more information about how replication works in [!KEYREF MG], read the [DBMS documentation](https://docs.mongodb.com/manual/replication/).

#### What limitations are imposed on [!KEYREF MG] database clusters? {#cluster-limitations}

The following limitations are imposed on the [!KEYREF MG] clusters:

- Each cluster may have a maximum of five hosts.
- The maximum storage capacity for each [!KEYREF MG] cluster is 512 GB.

For more information about the limitations of the DB service, see [[!TITLE]](../concepts/limits.md).

