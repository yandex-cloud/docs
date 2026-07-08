#### Why did my cluster switch to the _Updating_ status during an unscheduled backup? {#updating-while-backup}

Once the backup process is started, the cluster changes its status to **Updating**. You cannot cancel this operation. Please wait for it to complete.

The time this operation is performed depends on a number of factors, such as DB size, cluster configuration, and the nature of data being stored. The average speed when [recovering a cluster from a backup](../../managed-postgresql/operations/cluster-backups.md#restore) is about 100 Mbps.

#### Can I create two {{ PG }} databases at the same time? {#multi-db}

You cannot apply multiple transactions to a cluster at the same time. It is an architectural feature of the technologies utilized by {{ yandex-cloud }}.

#### Can I change the number of connections available to a user? {#user-conn-number}

Yes, you can. To do this, [change the values of the relevant settings](../../managed-postgresql/operations/cluster-users.md#update-settings):
* [**Conn limit**](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit): Maximum number of host connections per user. The default value is 50. The minimum value is 10.
* [**Max connections**](../../managed-postgresql/concepts/settings-list.md#setting-max-connections): Maximum number of connections reserved for all users. The default value is `200 × <number_of_vCPUs_per_host>`. You have to keep in mind that this number includes 15 service connections, e.g., given a cluster with `"max_connections": 100`, you can reserve a maximum of 85 connections per cluster host for users.

#### Can I change the class of an existing host (standard, memory-optimized, burstable)? {#host-class}

Yes, you can do this by following the procedure in [Changing cluster settings](../../managed-postgresql/operations/update.md#change-resource-preset).

#### Can I change the disk type in an existing cluster? {#disk-type}

Yes, you can. To do this, [restore the cluster from a backup](../../managed-postgresql/operations/cluster-backups.md#restore) and specify the required disk type when configuring the new cluster.

#### Can I manage a cluster using SQL commands? {#sql-control}

Cluster management via SQL commands has certain restrictions. For more information, see [{#T}](../../managed-postgresql/concepts/sql-limits.md).

#### Can I create a database using SQL commands? {#create-db-sql}

No, you cannot create a database via SQL. {{ mpg-name }} clusters only support database creation via {{ yandex-cloud }} interfaces.

#### How to take a cluster out of read-only mode? {#read-only-exit}

Follow the steps described in [{#T}](../../managed-postgresql/concepts/storage.md#read-only-solutions) and [{#T}](../../managed-postgresql/operations/storage-space.md#read-only-solutions).
