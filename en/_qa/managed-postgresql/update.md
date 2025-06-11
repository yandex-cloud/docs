#### Why did the cluster change its status to `Updating` during an unscheduled backup? {#updating-while-backup}

The cluster changes its status to **Updating** right after the backup process is launched. You cannot cancel this operation. Wait for it to complete instead.

The time this operation is performed depends on a number of factors, such as DB size, cluster configuration, and the nature of data being stored. The average speed when [recovering a cluster from a backup](../../managed-postgresql/operations/cluster-backups.md#restore) is about 100 Mbps.

#### Can I create two {{ PG }} databases at the same time? {#multi-db}

You cannot apply multiple transactions to a cluster at the same time. It is an architectural feature of the technologies utilized by {{ yandex-cloud }}.

#### Can I change the number of connections available to a user? {#user-conn-number}

Yes, you can. To do this, [change the values of the relevant settings](../../managed-postgresql/operations/cluster-users.md#update-settings):
* [**Conn limit**](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit): Maximum number of host connections per user. The default is 50. The minimum is 10.
* [**Max connections**](../../managed-postgresql/concepts/settings-list.md#setting-max-connections): Maximum number of connections reserved for all users. The default value is `200 × <number_of_vCPUs_per_host>`. You have to keep in mind that this number includes 15 service connections, e.g., given a cluster with `"max_connections": 100`, you can reserve a maximum of 85 connections per cluster host for users.

#### Can I change the class of an existing host (standard, memory-optimized, burstable)? {#host-class}

Yes, you can by following the procedure in [Changing cluster settings](../../managed-postgresql/operations/update.md#change-resource-preset).

#### Can I change the an existing cluster's disk type? {#disk-type}

Yes, you can. To do this, [restore the cluster from a backup](../../managed-postgresql/operations/cluster-backups.md#restore) and specify the desired disk type when configuring the new cluster.

#### Can I manage a cluster using SQL commands? {#sql-control}

There are some restrictions for cluster management using SQL commands. For more information, see [{#T}](../../managed-postgresql/concepts/sql-limits.md).

#### Why cannot I stop a cluster? {#stop-cluster}

Error message:

```text
ERROR: rpc error: code = FailedPrecondition desc = Cluster has no backups
```

A cluster that has no backups cannot be [stopped](../../managed-postgresql/operations/cluster-stop.md#stop-cluster). To fix the error and stop the cluster, [create its backup](../../managed-postgresql/operations/cluster-backups.md#create-backup).


#### Why do I get the `max_connections is less than sum of users connection limit` error when modifying a cluster? {#max-connections-error}

This error may occur when downgrading a host class in a cluster if the sum of connection limits for all users is less then the total cluster connection limit ([Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections)).

Solution: First reduce the limits set for users so their sum is less than `<Max_connections_value> — 15` and then proceed with host class downgrade.