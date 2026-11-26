{% list tabs %}

- {{ mch-name }}

    1. [Create a target database](../../../../managed-clickhouse/operations/databases.md#add-db).

       To migrate multiple databases, create a separate transfer for each.

    1. [Create a user](../../../../managed-clickhouse/operations/cluster-users.md#adduser) with access to the target database.

       Once the transfer starts, it will connect to the target as this user.

    1. If the cluster uses [SQL user management](../../../../managed-clickhouse/concepts/user-access-rights.md#sql-user-management), grant the new user the following permissions:

        ```sql
        GRANT CLUSTER ON *.* TO <username>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <DB_name>.* TO <username>
        GRANT SELECT(macro, substitution) ON system.macros TO <username>
        ``` 

       If SQL user management is disabled, you can [assign permissions](../../../../managed-clickhouse/operations/cluster-users.md) via the management console and CLI.

    1. [Create a security group](../../../../vpc/operations/security-group-create.md) and [configure it](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    1. Assign the new security group to the {{ mch-name }} cluster.

- {{ CH }}

    1. {% include notitle [White IP list](../../configure-white-ip.md) %}

    1. Create a target database with the same name as the source database. If you need to transfer multiple databases, create a separate transfer for each one of them.

    1. Create a user with access to the target database.

       Once the transfer starts, it will connect to the target as this user.

    1. Grant the new user the following permissions:

        ```sql
        GRANT CLUSTER ON *.* TO <username>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <DB_name>.* TO <username>
        GRANT SELECT(macro, substitution) ON system.macros TO <username>
        ```

{% endlist %}
