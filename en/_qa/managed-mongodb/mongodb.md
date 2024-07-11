#### Why should I use {{ MG }} in {{ mmg-short-name }} rather than my own VM-based installation? {#mongodb-advantages-vm}

{{ mmg-short-name }} automates routine database maintenance:

- Quick DB deployment with the necessary available resources.
- Data backup.
- Regular software updates.
- Providing DB cluster failover.
- Database usage monitoring and statistics.


#### What happens to a cluster if one of its hosts fails? {#node-out}

If there are more than one replica in the database cluster, it will continue working if a host fails.

The only way data may be lost is if the cluster's only host fails.


#### Can I deploy a {{ MG }} cluster in multiple availability zones? {#multiple-az}

Yes, you can. A database cluster may consist of hosts that reside in different availability zones and even different availability regions.


#### What is the backup procedure for {{ MG }} clusters? {#backup}

Backups are created every 24 hours and stored for seven days after being created. You can restore data only as of the backup creation time.


#### How does replication work for {{ MG }}? {#replication}

{{ mmg-short-name }} uses {{ MG }} standard replication: if a cluster has multiple active hosts, one of them is automatically elected as the primary server for handling write queries.

For more information about how replication works in {{ MG }}, read the [relevant documentation](https://docs.mongodb.com/manual/replication/).


#### What limitations are imposed on {{ MG }} database clusters? {#cluster-limitations}

For more information on limits in {{ mmg-name }}, see [Quotas and limits](../../managed-mongodb/concepts/limits.md).

#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../../managed-mongodb/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-mongodb/operations/cluster-backups.md#restore) from a backup.

#### How do I get access to the local.oplog.rs service collection? {#oplog-permission}

To grant a user read access to `oplog`, assign them the `mdbReplication` role in the `admin` database. To do this, run the following command in the {{ yandex-cloud }} CLI:

```bash
{{ yc-mdb-mg }} user update <username> \
  --cluster-name <cluster_name> \
  --permission database=admin,role=mdbReplication,role=<other_role>,... \
  --permission database=<other_DB_name>,role=<role>,...
```

To avoid deleting user roles that are already assigned, list both the existing and new roles in the command.
