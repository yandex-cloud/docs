{% list tabs %}

- {{ mpg-name }}

    1. Make sure that the {{ PG }} major version on the target is not lower than that on the source.

    1. For transfers from {{ PG }}, [enable the same extensions](../../../../managed-postgresql/operations/extensions/cluster-extensions.md) in the target database as in the source database.

        If extensions in the source database are installed in a custom schema and are used in the DDLs of the objects you are moving, create DDLs in the target manually. In these DDLs, a function call must not include the schema name. Set the target endpoint cleanup policy to `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` to prevent the transfer from deleting these objects.

    1. Select the `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` cleanup policy for transfer tables.

        If you have created DDLs in the target manually, use the `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` policy. The `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` policy will not delete these DDLs.

    1. [Create a user](../../../../managed-postgresql/operations/cluster-users.md#adduser) with access to the target database.

    1. Grant the user all privileges for the database, schemas, and tables to be transferred:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <database_name> TO <username>;
        ```

       If the database is not empty, the user must be its owner:

        ```sql
        ALTER DATABASE <database_name> OWNER TO <username>;
        ```

       Once started, the transfer will connect to the target on behalf of this user.
    1. If the target has the [Save transaction boundaries](../../../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) option enabled, grant the new user all the privileges needed to create the `__data_transfer_lsn` auxiliary table in the [current schema](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (usually `public`) in the target:

       ```sql
       GRANT ALL PRIVILEGES ON SCHEMA <schema_name> TO <username>;
       ```

    1. Configure the [number of user connections](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit) to the database.

- {{ PG }}

    1. {% include notitle [White IP list](../../configure-white-ip.md) %}

    1. Make sure that the {{ PG }} major version on the target is not lower than that on the source.

    1. In the target database, enable the same extensions that are enabled in the source database.

    1. Make sure the target has the `DROP transfer tables` cleanup policy selected.

    1. Create a user:

        ```sql
        CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
        ```

    1. Grant the user all privileges for the database, schemas, and tables to be transferred:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <database_name> TO <username>;
        ```

       If the database is not empty, the user must be its owner:

        ```sql
        ALTER DATABASE <database_name> OWNER TO <username>;
        ```

       Once started, the transfer will connect to the target on behalf of this user.

    1. If the target has the [Save transaction boundaries](../../../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) option enabled, grant the new user all the privileges needed to create the `__data_transfer_lsn` auxiliary table in the [current schema](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (usually `public`) in the target:

        ```sql
        GRANT ALL PRIVILEGES ON SCHEMA <schema_name> TO <username>;
        ```

    1. Configure the [number of user connections](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit) to the database.

{% endlist %}

{% include [matview limits](../../pg-gp-matview.md) %}

If the definition of the `VIEW` to be transferred contains an invocation of the `VOLATILE` [function]({{ pg.docs.org }}/current/xfunc-volatility.html), the transfer reads data from this `VIEW` with the `READ UNCOMMITTED` isolation level. No consistency between the `VIEW` data and the data of other objects being transferred is guaranteed. Reading data from a `MATERIALIZED VIEW` in the `VIEW` definition are equivalent to invoking the `VOLATILE` function.