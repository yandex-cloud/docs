{% list tabs %}

- {{ mpg-name }}

   1. Make sure that the {{ PG }} major version on the target is not lower than that on the source.

   1. Disable the following settings on the target:

      * Integrity checks for foreign keys
      * Triggers
      * Other constraints

      {% note warning %}

      Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

      If you use the _{{ dt-type-copy-repl }}_ transfer type, you can enable the settings again after the [copy stage](../../../../data-transfer/concepts/transfer-lifecycle.md#copy-and-replication) is completed.

      {% endnote %}

   1. In the target database, [enable the same extensions](../../../../managed-postgresql/operations/extensions/cluster-extensions.md) that are enabled in the source database.

   1. Make sure the target has the `DROP transfer tables` cleanup policy selected.

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
   1. If the target has the [Save transaction boundaries](../../../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) option enabled, grant the created user all privileges to create the `__data_transfer_lsn` housekeeping table in the [current schema](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (usually it is `public`) on the target:

      ```sql
      GRANT ALL PRIVILEGES ON SCHEMA <schema_name> TO <username>;
      ```

- {{ PG }}

   1. {% include notitle [White IP list](../../configure-white-ip.md) %}

   1. Make sure that the {{ PG }} major version on the target is not lower than that on the source.

   1. Disable the following settings on the target:

      * Integrity checks for foreign keys
      * Triggers
      * Other constraints

      {% note warning %}

      Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

      If you use the _{{ dt-type-copy-repl }}_ transfer type, you can enable the settings again after the [copy stage](../../../../data-transfer/concepts/transfer-lifecycle.md#copy-and-replication) is completed.

      {% endnote %}

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

   1. If the target has the [Save transaction boundaries](../../../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) option enabled, grant the created user all privileges to create the `__data_transfer_lsn` housekeeping table in the [current schema](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (usually it is `public`) on the target:

      ```sql
      GRANT ALL PRIVILEGES ON SCHEMA <schema_name> TO <username>;
      ```

{% endlist %}

{% include [matview limits](../../pg-gp-matview.md) %}

If the definition of the `VIEW` to be transferred contains an invocation of the `VOLATILE` [function]({{ pg.docs.org }}/current/xfunc-volatility.html), the transfer reads data from this `VIEW` with the `READ UNCOMMITTED` isolation level. No consistency between the `VIEW` data and the data of other objects being transferred is guaranteed. Reading data from a `MATERIALIZED VIEW` in the `VIEW` definition are equivalent to invoking the `VOLATILE` function.