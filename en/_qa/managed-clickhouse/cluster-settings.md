# {{ CH }} cluster configuration

{% if product == "yandex-cloud" %}

#### How do I create a user to access a cluster from {{ datalens-name }} with read-only permissions? {#datalens-readonly}

Follow the [instructions](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user) to create a user with read-only permissions. If the cluster settings have the **Access from {{ datalens-name }}** [option enabled](../../managed-clickhouse/operations/update.md#change-additional-settings), the service can [connect](../../managed-clickhouse/operations/datalens-connect.md#create-connector) to the cluster through this user.

{% endif %}


#### How do I grant a user permissions to create and delete tables or databases? {#create-delete-role}

Go to the cluster settings, enable the [{#T}](../../managed-clickhouse/operations/cluster-users.md#sql-user-management) option, and grant a user the appropriate permissions [using a statement]({{ ch.docs }}/sql-reference/statements/grant/) named `GRANT`.

#### How do I find out the internal_replication setting value? {#internal-replication}

The `internal_replication` setting information is not available in the {{ yandex-cloud }} interfaces or the {{ CH }} system tables. The default setting value is `true`.
