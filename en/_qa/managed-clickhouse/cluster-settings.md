#### How do I create a user to access a cluster from {{ datalens-name }} with read-only permissions? {#datalens-readonly}

Follow [this guide](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user) to create a user with read-only permissions. With **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}** [option enabled](../../managed-clickhouse/operations/update.md#change-additional-settings) in the cluster settings, {{ mch-name }} can [connect](../../managed-clickhouse/operations/datalens-connect.md#create-connector) to the cluster using the created user.

#### How do I grant a user permissions to create and delete tables or databases? {#create-delete-role}

Go to the cluster settings, enable [{#T}](../../managed-clickhouse/operations/cluster-users.md#sql-user-management), and grant the user the appropriate permissions [using the `GRANT` statement]({{ ch.docs }}/sql-reference/statements/grant/).

#### How do I find out the internal_replication setting value? {#internal-replication}

The `internal_replication` setting information is not available in {{ yandex-cloud }} interfaces or {{ CH }} system tables. The default setting value is `true`.

#### How do I increase the maximum amount of RAM to run a query? {#max-memory-usage}

If you do not have enough RAM to run a query, you will see the following error:

```text
DB::Exception: Memory limit (total) exceeded:
would use 14.10 GiB (attempt to allocate chunk of 4219924 bytes), maximum: 14.10 GiB.
(MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

To [increase](../../managed-clickhouse/operations/cluster-users.md#update-settings) the maximum amount of RAM, use the [Max memory usage](../../managed-clickhouse/concepts/settings-list.md#setting-max-memory-usage) parameter.

If [user management via SQL](../../managed-clickhouse/operations/cluster-users.md#sql-user-management) is enabled for the cluster, you can set the `Max memory usage` parameter:

* For the current user session by running this query:

    ```sql
    SET max_memory_usage = <value_in_bytes>;
    ```

* For all default users by creating a [settings profile]({{ ch.docs }}/operations/access-rights/#settings-profiles-management).

#### Why must a {{ mch-name }} cluster have three or five {{ ZK }} hosts? {#zookeeper-hosts-number}

{{ ZK }} uses the consensus algorithm: it keeps on running as long as most {{ ZK }} hosts are healthy.

For example, if a cluster has two {{ ZK }} hosts, then, should one of them stop, the remaining host will not form the majority, so the service will become unavailable. This means that a cluster with two {{ ZK }} hosts is not fault-tolerant.

A cluster with three {{ ZK }} hosts, on the other hand, is fault-tolerant. When one of its hosts is down or under maintenance, the cluster remains operational. Therefore, three is the minimum recommended number of {{ ZK }} hosts per {{ mch-name }} cluster.

A cluster with four {{ ZK }} hosts has no advantages over a three-host cluster: it will also remain operational if only one of its hosts fails. With two hosts down, the consensus is not met, so the service becomes unavailable.

A cluster with five {{ ZK }} hosts is resilient enough to keep running without two of its hosts, three hosts out of five still forming the majority. This is why this cluster is easier to maintain than a three-host cluster. Even if one host out of five is [under maintenance](../../managed-clickhouse/concepts/maintenance.md) or restarting, the cluster remains fault-tolerant, i.e., it can lose one more host and still be operational.

Usually, adding more than five {{ ZK }} hosts to a cluster is not feasible. The more {{ ZK }} hosts, the longer their interaction times, and therefore the slower the service.

Thus, we recommend creating three or five {{ ZK }} hosts per {{ mch-name }} cluster. 
