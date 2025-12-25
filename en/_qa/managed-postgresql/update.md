#### Why did my cluster switch to the _Updating_ status during an unscheduled backup? {#updating-while-backup}

Once the backup process is started, the cluster changes its status to **Updating**. You cannot cancel this operation. Please wait for it to complete.

The operation’s duration depends on a number of factors, including database size, cluster configuration, and the nature of the stored data. The average [cluster restoration speed](../../managed-postgresql/operations/cluster-backups.md#restore) is approximately 100 MB/s.

#### Can I create two {{ PG }} databases at the same time? {#multi-db}

You cannot perform multiple cluster operations simultaneously due to architectural constraints of the technologies used in {{ yandex-cloud }}.

#### How can I change the number of connections available for a user? {#user-conn-number}

You can change the number of connections by [updating the following settings](../../managed-postgresql/operations/cluster-users.md#update-settings):
* [**Conn limit**](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit): Maximum number of host connections per user. The default value is 50. The minimum value is 10.
* [**Max connections**](../../managed-postgresql/concepts/settings-list.md#setting-max-connections): Maximum number of connections reserved for all users. The default value is `200 × <number_of_vCPUs_per_host>`. Note that this number includes 15 system connections. For example, with `"max_connections": 100`, you can reserve no more than 85 user connections per cluster host.

#### Can I change the host class (standard, memory-optimized, burstable) for an existing host? {#host-class}

Yes, you can do this by following the procedure in [Changing cluster settings](../../managed-postgresql/operations/update.md#change-resource-preset).

#### Can I change the disk type in an existing cluster? {#disk-type}

Yes, you can. To do this, [restore the cluster from a backup](../../managed-postgresql/operations/cluster-backups.md#restore) and specify the required disk type when configuring the new cluster.

#### Can I manage a cluster using SQL commands? {#sql-control}

Cluster management via SQL commands has certain restrictions. For more information, see [{#T}](../../managed-postgresql/concepts/sql-limits.md).

#### Can I create a database using SQL commands? {#create-db-sql}

No, you cannot create a database via SQL. {{ mpg-name }} clusters only support database creation via {{ yandex-cloud }} interfaces.

#### How to take a cluster out of read-only mode? {#read-only-exit}

Follow the steps described in [{#T}](../../managed-postgresql/concepts/storage.md#read-only-solutions) and [{#T}](../../managed-postgresql/operations/storage-space.md#read-only-solutions).
