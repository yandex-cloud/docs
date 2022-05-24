# Cluster parameter settings

#### How do I create a user with read-only access to a cluster from {{ datalens-name }}? {#datalens-readonly}

Follow the [instructions](../operations/cluster-users.md#example-create-readonly-user) to create a user with read-only access permissions. If the cluster settings have the **Access from DataLens** [option enabled](../operations/update.md#change-additional-settings), the service can [connect](../operations/datalens-connect.md#create-connector) to the cluster via this user.

#### How do I grant a user the right to create and delete tables or databases? {#create-delete-role}

In the cluster settings, enable [{#T}](../operations/cluster-users.md#sql-user-management) and grant a user the appropriate rights using the `GRANT` [statement](https://clickhouse.com/docs/en/sql-reference/statements/grant/).

#### How do I find out the value of the internal_replication setting? {#internal-replication}

Information about the `internal_replication` setting is not available in {{ yandex-cloud }} interfaces or {{ CH }} system tables. The default setting value is `true`.
