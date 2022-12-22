# Updating {{ PG }} clusters

#### Why did the cluster change its status to Updating during an unscheduled backup? {#updating-while-backup}

The cluster changes its status to **Updating** right after the backup process is launched. You cannot cancel this operation. Wait for it to complete instead.

The time this operation is performed depends on a number of factors, such as DB size, cluster configuration, and the nature of data being stored. The average speed when [recovering a cluster from a backup](../operations/cluster-backups.md#restore) is about 100 Mbps.

#### Can I create two {{ PG }} databases at the same time? {#multi-db}

You cannot apply multiple transactions to a cluster at the same time. It is an architectural feature of the technologies utilized by {{ yandex-cloud }}.

#### Can I change the number of connections available to a user? {#user-conn-number}

You can. To do this, [change the values of the relevant settings](../operations/cluster-users.md#update-settings):
* [**Conn limit**](../concepts/settings-list.md#setting-conn-limit): The maximum number of host connections per user. The default is 50. The minimum is 10.
* [**Max connections**](../concepts/settings-list.md#setting-max-connections): The maximum number of connections reserved for all users. The default is `200 × <number of vCPUs on each host>`. You have to keep in mind that this number includes 15 service connections: for instance, if a cluster has `"max_connections": 100`, you are only able to reserve at most 85 connections per cluster host for users.

#### Can I change an existing host's class (standard, memory-optimized, burstable)? {#host-class}

Yes, you can by following the procedure in [Changing cluster settings](../operations/update.md#change-resource-preset).

#### Can I change the disk type in an existing cluster from {% if audience != "internal" %}network-hdd to network-ssd or local-ssd{% else %}local-hdd to local-ssd{% endif %}? {#disk-type}

You can. To do this, [restore the cluster from a backup](../operations/cluster-backups.md#restore) and specify the desired disk type when configuring the new cluster.

#### Can I manage a cluster using SQL commands? {#sql-control}

There are some restrictions for cluster management using SQL commands. For more information, see [{#T}](../concepts/sql-limits.md).
