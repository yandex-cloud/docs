# Questions about {{ MG }}

#### Why should I use {{ MG }} in {{ mmg-short-name }} rather than my own VM-based installation? {#mongodb-advantages-vm}

{{ mmg-short-name }} automates routine database maintenance:

- Quick DB deployment with the necessary available resources.
- Data backup.
- Regular software updates.
- DB cluster failover.
- Database usage monitoring and statistics.

#### What happens to a cluster if one of its hosts fails? {#node-out}

If there are more than one replica in the database cluster, it will continue working if a host fails.

The only way data may be lost is if the cluster's only host fails.

#### Can I deploy a {{ MG }} cluster in multiple availability zones? {#multiple-az}

Yes. A database cluster may consist of hosts that reside in different availability zones and even different availability regions.

#### How do I back up {{ MG }} clusters? {#backup}

Backups are created every 24 hours and stored for seven days after being created. You can restore data only as of backup creation time.

#### How does replication work for {{ MG }}? {#replication}

{{ mmg-short-name }} uses {{ MG }} standard replication: if a cluster has multiple active hosts, one of them is automatically elected as the primary server for handling write queries.

For more information about how replication works in {{ MG }}, read the [DBMS documentation](https://docs.mongodb.com/manual/replication/).

#### What limitations are imposed on {{ MG }} database clusters? {#cluster-limitations}

{{ MG }} clusters are subject to the following limitations:

- Each cluster may have a maximum of five hosts.
- The maximum storage capacity for each {{ MG }} cluster is 605 GB.

For more information about {{ mmg-short-name }} limits, see [{#T}](../../managed-mongodb/concepts/limits.md).

