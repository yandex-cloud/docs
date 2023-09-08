# {{ CH }} cluster configuration


#### How do I create a user to access a cluster from {{ datalens-name }} with read-only permissions? {#datalens-readonly}

Follow the [guide](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user) to create a user with read-only permissions. If the cluster settings have the **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}** [option enabled](../../managed-clickhouse/operations/update.md#change-additional-settings), the service can [connect](../../managed-clickhouse/operations/datalens-connect.md#create-connector) to the cluster through this user.



#### How do I grant a user permissions to create and delete tables or databases? {#create-delete-role}

Go to the cluster settings, enable the [{#T}](../../managed-clickhouse/operations/cluster-users.md#sql-user-management) option, and grant a user the appropriate permissions [using a statement]({{ ch.docs }}/sql-reference/statements/grant/) named `GRANT`.

#### How do I find out the internal_replication setting value? {#internal-replication}

The `internal_replication` setting information is not available in the {{ yandex-cloud }} interfaces or the {{ CH }} system tables. The default setting value is `true`.

#### How do I increase the maximum amount of RAM to run a query? {#max-memory-usage}

If the amount of RAM is not sufficient for running a query, the following error occurs:

```text
DB::Exception: Memory limit (total) exceeded:
would use 14.10 GiB (attempt to allocate chunk of 4219924 bytes), maximum: 14.10 GiB.
(MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

To [increase](../../managed-clickhouse/operations/cluster-users.md#update-settings) the maximum amount of RAM, use the [Max memory usage](../../managed-clickhouse/concepts/settings-list.md#setting-max-memory-usage) parameter.

If the [User management via SQL](../../managed-clickhouse/operations/cluster-users.md#sql-user-management) option is enabled for the cluster, you can set the `Max memory usage` parameter:

* For the current user session by running this query:

   ```sql
   SET max_memory_usage = <value in bytes>;
   ```

* For all users by default by creating a [settings profile]({{ ch.docs }}/operations/access-rights/#settings-profiles-management).
