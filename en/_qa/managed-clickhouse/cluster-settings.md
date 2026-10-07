#### How do I create a user to access a cluster from {{ datalens-name }} with read-only permissions? {#datalens-readonly}

Follow [this guide](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user) to create a user with read-only permissions. With **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}** [enabled](../../managed-clickhouse/operations/update.md#change-additional-settings) in the cluster settings, the service will be able to [connect](../../managed-clickhouse/operations/datalens-connect.md#create-connector) to the cluster using this user.

#### How do I grant a user permissions to create and delete tables or databases? {#create-delete-role}

[Enable managing users via SQL](../../managed-clickhouse/operations/update.md#SQL-management) and grant the user the required permissions using the `GRANT` command.

For more information about the `GRANT` command, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/sql-reference/statements/grant).

#### How do I find out the internal_replication setting value? {#internal-replication}

The `internal_replication` setting information is not available in {{ yandex-cloud }} interfaces or {{ CH }} system tables. The default setting value is `true`.

#### Why do I get an `MEMORY_LIMIT_EXCEEDED` error? {#max-memory-usage}

The [Max memory usage](../../managed-clickhouse/concepts/settings-list.md) setting limits the amount of memory that a single query can use on one server. By default, its value is `0`, meaning that no limit is set.

Increase **Max memory usage** only if it is set to a non-zero value and the query exceeds this limit. In this case, you will get the following error:

```text
DB::Exception: Memory limit (total) exceeded:
would use 14.10 GiB (attempt to allocate chunk of 4219924 bytes), maximum: 14.10 GiB.
(MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

The **Max memory usage** value cannot exceed the limit set by **Max server memory usage**. If **Max memory usage** is set to `0`, the `MEMORY_LIMIT_EXCEEDED` error may be caused by the server reaching its overall memory limit. Increasing **Max memory usage** will not resolve the issue in this case. [Optimize the query]({{ ch.docs }}resources/support-center/knowledge-base/performance-optimization/memory-limit-exceeded-for-query) to reduce memory usage or [change the host class](../../managed-clickhouse/operations/update.md#change-resource-preset). For more information, see [{#T}](../../managed-clickhouse/concepts/memory-management.md).

You can [increase](../../managed-clickhouse/operations/cluster-users.md#update-settings) the **Max memory usage** value in the user settings or using SQL queries:

* For the current session:

    ```sql
    SET max_memory_usage = <value_in_bytes>;
    ```

* For an individual query:

    ```sql
    SELECT <expression>
    FROM <table_name>
    SETTINGS max_memory_usage = <value_in_bytes>;
    ```

If [user management via SQL](../../managed-clickhouse/concepts/user-access-rights.md#sql-user-management) is enabled in the cluster, you can set the **Max memory usage** value for selected users via the [settings profile]({{ ch.docs }}{{ lang }}/operations/access-rights#settings-profiles-management). For example, to set a value for a single user:

```sql
CREATE SETTINGS PROFILE max_memory_usage_profile
SETTINGS max_memory_usage = <value_in_bytes>
TO <username>;
```

#### Why must a highly available {{ mch-name }} cluster have three or five {{ ZK }} hosts? {#zookeeper-hosts-number}

{{ ZK }} uses the consensus algorithm: it keeps on running as long as most {{ ZK }} hosts are healthy.

For example, if a cluster has two {{ ZK }} hosts, then, should one of them stop, the remaining host will not form the majority, so the service will become unavailable. Which means a cluster with two {{ ZK }} hosts is not [highly available](../../managed-clickhouse/concepts/high-availability.md).

A cluster with three {{ ZK }} hosts, however, is highly available. When one of its hosts is under maintenance or down, the cluster remains operational. Therefore, three is the minimum recommended number of {{ ZK }} hosts per {{ mch-name }} cluster.

A cluster with four {{ ZK }} hosts has no advantages over a three-host cluster: it will also remain operational if only one of its hosts fails. With two hosts down, the consensus is not met, so the service becomes unavailable.

A cluster with five {{ ZK }} hosts is resilient enough to keep running without two of its hosts, three hosts out of five still forming the majority. This is why this cluster is easier to maintain than a three-host cluster. Even if one host out of five is [under maintenance](../../managed-clickhouse/concepts/maintenance.md) or restarting, the cluster remains highly available, i.e., it can lose one more host and still be operational.

Adding more than five {{ ZK }} hosts to a cluster is not supported.

Thus, we recommend creating three or five {{ ZK }} hosts per {{ mch-name }} cluster.

#### How do I add a host to a cluster with disabled coordination service? {#add-hosts-disabled-coordination}

If you try to add a host to a cluster with disabled [coordination service](../../managed-clickhouse/concepts/coordination-system.md), you will get this error:

```text
ERROR: rpc error: code = FailedPrecondition desc = shard cannot have more than 1 host in non-HA cluster configuration
```

To add a host to the cluster, first [enable the {{ CK }} or {{ ZK }} coordination service](../../managed-clickhouse/operations/update.md#enable-coordination) on individual hosts.

#### How do I add a multi-host shard to a cluster with disabled coordination service? {#add-shard-disabled-coordination}

If you try to add a multi-host shard to a sharded cluster with disabled [coordination service](../../managed-clickhouse/concepts/coordination-system.md), you will get this error:

```text
ERROR: rpc error: code = FailedPrecondition desc = To create a shard with two or more hosts, you must enable the coordination service first.
```

To add a multi-host shard to the cluster, first [enable the {{ CK }} or {{ ZK }} coordination service](../../managed-clickhouse/operations/update.md#enable-coordination) on individual hosts.
