# Managing ClickHouse users

You can add and remove users, as well as manage their individual settings.

There are two ways to manage cluster users:

- {{ yandex-cloud }} standard interfaces (CLI, API, or management console). Choose this method if you want to use all the features of the {{ yandex-cloud }} managed service.
- SQL queries to the cluster. Choose this method if you want to use an existing solution for creating and managing users, or if you need [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) support.

## Managing users using SQL {#sql-user-management}

To manage users using SQL, [create a cluster via the API](cluster-create.md) with the **sqlUserManagement** setting enabled. In this cluster:

- Users can only be managed using SQL.
- Management using {{ yandex-cloud }} standard interfaces (CLI, API, or management console) isn't possible.
- Users are managed under the `admin` account. The password for this account is set when creating a cluster.

To learn more about managing users using SQL, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/access-rights).

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the command:

  ```
  $ {{ yc-mdb-ch }} user list
       --cluster-name=<cluster name>
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. Get a list of users:

      ```sql
      SHOW USERS;
      ```

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console

  To create a user in a cluster:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter a database username and password (from 8 to 128 characters).
  1. Select one or more databases that the user should have access to:
     1. Select the database from the **Database** drop-down list.
     1. Click **Add** to the right of the drop-down list.
     1. Repeat the previous two steps until all the required databases are selected.
     1. To delete a database that was added by mistake, click ![image](../../_assets/cross.svg) to the right of the database name in the **Permissions** list.
  1. Configure [additional settings](#advanced-settings) for the user:
     1. Set [quotas](#quota-settings) in **Additional settings → Quota**:
        1. To add a quota, click ![image](../../_assets/plus.svg) or **+ Quotas**. You can add multiple quotas that will be valid at the same time.
        1. To delete a quota, click ![image](../../_assets/vertical-ellipsis.svg) to the right of the quota name and select **Delete**.
        1. To change a quota, set the required [setting values](#quota-settings) for it.
     1. Configure [{{ CH }}](#clickhouse-settings) in **Additional settings → Settings**.
  1. Click **Add**.

  See also: [Example of creating a read-only user](#example-create-readonly-user).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ {{ yc-mdb-ch }} user create <username>
       --cluster-name=<cluster name>
       --password=<user password>
       --permissions=<list of DBs the user can access>
       --quota=<list of a user's single quota settings>
       --settings=<list of {{ CH }} settings for the user>
  ```

  For more information about [quotas](#quota-settings) and [{{ CH }} settings](#clickhouse-settings), see [Additional settings](#advanced-settings).

  To set multiple quotas, list them using the required number of `--quota` parameters in the command:

  ```
  $ {{ yc-mdb-ch }} user create <username>
      ...
      --quota="<settings of quota 0>"
      --quota="<settings of quota 1>"
      ...
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

  See also: [Example of creating a read-only user](#example-create-readonly-user).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. Create a user:

      ```sql
      CREATE USER <username> IDENTIFIED WITH sha256_password BY '<user's password';
      ```

  To learn more about creating users, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/create/user/).

{% endlist %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

  To change the user's password:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.
  1. Set a new password and click **Edit**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password, run the command:

  ```
  $ {{ yc-mdb-ch }} user update <username>
       --cluster-name=<cluster name>
       --password=<new password>
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. Change the user's password:

      ```sql
      ALTER USER <username> IDENTIFIED BY '<new password>';
      ```

  To learn more about changing users, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/alter/user/).

{% endlist %}

## Changing user settings {#update-settings}

{% list tabs %}

- Management console

  To change the user settings:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Settings**.
  1. Set up user permissions to access certain databases:
     1. To grant access to the required databases:
        1. Select the database from the **Database** drop-down list.
        1. Click **Add** to the right of the drop-down list.
        1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke access to a specific database, remove it from the **Permissions** list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
  1. Set [quotas](#quota-settings) for the user in **Additional settings → Quotas**:
     1. To add a quota, click ![image](../../_assets/plus.svg) or **+ Quotas**. You can add multiple quotas that will be valid at the same time.
     1. To delete a quota, click ![image](../../_assets/vertical-ellipsis.svg) to the right of the quota name and select **Delete**.
     1. To change a quota, set the required [setting values](#quota-settings) for it.
  1. Change the [settings of {{ CH }}](#clickhouse-settings) for the user in **Additional settings → Settings**.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can change the user settings from the command line interface:

  1. To set up the user's permissions to access certain databases, run the command, listing the database names in the `--permissions` parameter:

     ```
     $ {{ yc-mdb-ch }} user update <username>
          --cluster-name=<cluster name>
          --permissions=<list of DBs the user can access>
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     This command grants the user the permission to access the databases listed.

     To revoke access to a specific database, remove its name from the list and pass the updated list to the command.

  1. To change the user's [quota settings](#quota-settings), run the command with a list of all quotas, using the `--quota` parameters (one parameter per quota):

     ```
     $ {{ yc-mdb-ch }} user update <username>
          --cluster-name=<cluster name>
          --quota=<settings of quota 0 (unchanged)>
          --quota=<settings of quota 1 (unchanged)>
          --quota=<settings of quota 2 (changed)>
          --quota=<settings of quota 3 (unchanged)>
          --quota=<settings of quota 4 (changed)>
          --quota=<settings of quota 5 (new quota)>       
         ...
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     This command overwrites all existing user quota settings with the new settings that you passed to the command.
Before running the command, make sure that you included the settings for new and changed quotas and the settings for existing quotas that haven't changed.

     To delete one or more user quotas, exclude their settings from the list and pass the updated list of `--quota` parameters to the command.

  1. To change the [settings of {{ CH }}](#clickhouse-settings) for the user, run the command by listing the updated settings using the `--settings` parameter:

     ```
     $ {{ yc-mdb-ch }} user update <username>
          --cluster-name=<cluster name>
          --settings=<list of {{ CH }} settings>    
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     The command only changes the settings that are explicitly specified in the `--settings` parameter. For example, the command with the parameter `--settings="readonly=1"` only changes the `readonly` setting and doesn't reset the values of the other settings. This is how changing {{ CH }} settings differs from changing quota settings.

     This command doesn't delete a configured setting, it just explicitly assigns it the default value (specified for [each setting](#clickhouse-settings)).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. To change a set of user privileges and roles, use the [GRANT](https://clickhouse.tech/docs/en/sql-reference/statements/grant/) and [REVOKE](https://clickhouse.tech/docs/en/sql-reference/statements/revoke/) queries. For example, grant the user read rights to all objects in a specific database:

      ```sql
      GRANT SELECT ON <database name>.* TO <username>;
      ```

  1. To change [quota settings](#quota-settings) for the user, use the [CREATE QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/create/quota/#create-quota-statement), [ALTER QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/alter/quota/#alter-quota-statement), and [DROP QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/drop/#drop-quota-statement) queries. For example, limit the total number of user requests for a 15-month period:

      ```sql
      CREATE QUOTA <quota name> FOR INTERVAL 15 MONTH MAX QUERIES 100 TO <username>;
      ```

  1. To change the user account, use the [ALTER USER](https://clickhouse.tech/docs/en/sql-reference/statements/alter/user/) query. For example, to change the [settings {{ CH }}](#clickhouse-settings), run the following command listing the settings you want to change:

      ```sql
      ALTER USER <username> SETTINGS <{{ CH }} settings>;
      ```

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  $ {{ yc-mdb-ch }} user delete <username>
       --cluster-name=<cluster name>
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. Delete the user:

      ```sql
      DROP USER ;
      ```

  To learn more about deleting objects, see the [documentation for{{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/drop/).

{% endlist %}

## Examples {#examples}

### Creating a read-only user {#example-create-readonly-user}

Let's say you need to add to the existing `mych` cluster a new user named `ro-user` with the password `Passw0rd`, provided that:

- The user has access to the `db1` database of the cluster.
- The access is read-only, so the user isn't allowed to change any settings.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the cluster named `mych` and select the **Users** tab.
  1. Click **Add**.
  1. Enter `ro-user` as the DB username and `Passw0rd` as the password.
  1. Select the `db1` database from the **Database** drop-down list and click **Add** to the right of the list.
  1. Choose **Additional settings → Settings → Readonly**.
  1. Set the **Readonly** field value to `1`.
  1. Click **Add**.

- CLI

  Run the command:

  ```
  $ {{ yc-mdb-ch }} user create "ro-user" \
       --cluster-name="mych" \
       --password="Passw0rd" \
       --permissions="db1" \
       --settings="readonly=1"
  ```

    After creating the user, check that it is actually in read-only mode:

    1. [Connect to the {{ CH }} cluster](connect.md) `mych` using the `ro-user` user that you created.

    1. Try changing a setting, for example, disable read-only mode:

       ```
       SET readonly=0
       ```

       As a result, the command should display a message stating that you can't change the setting in read-only mode:

       ```
       DB::Exception: Cannot modify 'readonly' setting in readonly mode.
       ```

- SQL

  1. [Connect](connect.md) to the `mych` cluster using the [admin account](#sql-user-management).

  1. Create a user:

      ```sql
      CREATE USER ro-user IDENTIFIED WITH sha256_password BY 'Passw0rd';
      ```

  1. Grant the user read rights to all objects in the `db1` database:

      ```sql
      GRANT SELECT ON db1.* TO ro-user;
      ```

{% endlist %}

## Additional settings {#advanced-settings}

### Quota settings {#quota-settings}

Quotas let you limit the user's consumption of {{ CH }} resources for a specified time interval.

If the user exceeds one of the quota limits within this interval, they can't execute new queries until the interval expires. {{ CH }} displays a message about exceeding the quota and indicates when the next interval starts. At the beginning of the new interval, query execution is permitted and the limit counters are reset.

{{ CH }} also uses quotas to account for resource consumption.
For each user, there is a default quota that takes into account the consumption of all resources per hour, but doesn't impose any restrictions.
Information about the resource consumption level is written to the {{ CH }} server log.

For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/quotas/).

{% list tabs %}

- Management console

  You can use the following settings:

  - **Interval duration**: Sets the interval for a quota in milliseconds.

    The minimum value is `1000` (one second).

  - **Errors**: Limits the total number of failed queries.

    The minimum value is `0` (no limitation is set).

  - **Execution time**: Limits the total query execution time in milliseconds.

    The minimum value is `0` (no limitation is set).

  - **Queries**: Limits the total number of queries.

    The minimum value is `0` (no limitation is set).

  - **Read rows**: Limits the total number of source rows read from tables for running the query (including rows read from remote servers).

    The minimum value is `0` (no limitation is set).

  - **Result rows**: Limits the total number of rows in query results.

    The minimum value is `0` (no limitation is set).

- CLI

  You can use the following settings:

  - **`interval`**: Sets the interval for a quota in milliseconds.

    You can use an entry with units: hours (`h`), minutes (`m`), seconds (`s`), and milliseconds (`ms`). Sample entry: `3h20m10s7000ms` (the resulting value is still represented in milliseconds: `12017000`). Note that the resulting interval value must be a multiple of 1000 milliseconds (a value like `1s500ms` is incorrect).

    The minimum value is `1000` (one second).

  - **`errors`**: Limits the total number of failed queries.

    The minimum value is `0` (no limitation is set).

  - **`execution-time`**: Limits the total query execution time in milliseconds.

    You can use an entry with units: hours (`h`), minutes (`m`), seconds (`s`), and milliseconds (`ms`). Sample entry: `3h20m10s7000ms` (the resulting value is still represented in milliseconds: `12017000`).

    Note that the resulting interval value must be a multiple of 1000 milliseconds (a value like `1s500ms` is incorrect).

    The minimum value is `0` (no limitation is set).

  - **`queries`**: Limits the total number of queries.

    The minimum value is `0` (no limitation is set).

  - **`read-rows`**: Limits the total number of source rows read from tables for running the query (including rows read from remote servers).

    The minimum value is `0` (no limitation is set).

  - **`result-rows`**: Limits the total number of rows in query results.

    The minimum value is `0` (no limitation is set).

- SQL

  The full syntax of the create new quota command:

  ```
  CREATE QUOTA [IF NOT EXISTS | OR REPLACE] name
      [KEYED BY {'none' | 'user name' | 'ip address' | 'client key' | 'client key or user name' | 'client key or ip address'}]
      [FOR [RANDOMIZED] INTERVAL number {SECOND | MINUTE | HOUR | DAY | WEEK | MONTH | QUARTER | YEAR}
          {MAX { {QUERIES | ERRORS | RESULT ROWS | RESULT BYTES | READ ROWS | READ BYTES | EXECUTION TIME} = number } [,...] |
           NO LIMITS | TRACKING ONLY} [,...]]
      [TO {role [,...] | ALL | ALL EXCEPT role [,...]}]
  ```

  - **`INTERVAL`**: Sets the interval for a quota. After setting the value, specify the unit of measurement.

    The minimum value is one second.

  - **`errors`**: Limits the total number of failed queries.

    The minimum value is `0` (no limitation is set).

  - **`EXECUTION TIME`**: Limits the total query execution time in seconds.

    The minimum value is `0` (no limitation is set).

  - **`queries`**: Limits the total number of queries.

    The minimum value is `0` (no limitation is set).

  - **`READ ROWS`**: Limits the total number of source rows read from tables for executing the query (including rows read from remote servers).

    The minimum value is `0` (no limitation is set).

  - **`RESULT ROWS`**: Limits the total number of rows in query results.

    The minimum value is `0` (no limitation is set).

  To learn more, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/access-rights/#quotas-management).

{% endlist %}

### ClickHouse settings {#clickhouse-settings}

These settings affect the behavior of {{ CH }} when handling user queries.

{% list tabs %}

- Management console

  You can use the following settings:

  - **Add HTTP CORS header**{#setting-add-http-cors-header}: Adds a CORS header in HTTP responses.

    By default, no CORS header is included in HTTP responses.

  - **Allow DDL**{#setting-allow-ddl}: Allows or bans DDL queries (for example, `CREATE`, `ALTER`, `RENAME`, and so on).

    By default, DDL queries are allowed.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl).

    See also: the [Readonly](#setting-readonly) setting.

  - **Compile**{#setting-compile}: Enables or disables query compilation. If you run a large number of structurally identical queries with compilation enabled, such queries can be executed faster by using compiled query parts.

    Use this setting in combination with the [Min count to compile](#setting-min-count-to-compile) setting.

    Compilation is disabled by default.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#compile).

  - **Compile expressions**{#setting-compile-expressions}: Enables or disables expression compilation. If you run a large number of queries that use identical expressions with compilation enabled, such queries can be executed faster by using compiled expressions.

    Use this setting in combination with the [Min count to compile expression](#setting-min-count-to-compile-expression) setting.

    Expression compilation is disabled by default.

  - **Connect timeout**{#setting-connect-timeout}: Sets the connection timeout in milliseconds.

    The value must be greater than zero (default: `10000`, 10 seconds).

  - **DISTINCT overflow mode**{#setting-distinct-overflow-mode}: Determines the {{ CH }} behavior when running the `SELECT DISTINCT` query [exceeds the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa). Either `throw` (abort the query execution and return an error) or `break` (return a partial result).

    By default, not selected (equivalent to `throw`).

  - **Distributed aggregation memory efficient**{#setting-distributed-aggregation-memory-efficient}: Enables or disables memory saving mode when doing distributed aggregation.

    Under distributed query processing, [external aggregation](#setting-max-bytes-before-external-group-by) is done on remote servers. Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

    By default, memory saving mode is disabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

  - **Distributed product mode**{#setting-distributed-product-mode}: Changes the behavior of distributed subqueries when a query contains the product of distributed tables:
    - `deny`: Bans the use of such subqueries.
    - `local`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal `IN/JOIN`.
    - `global`: Replaces the `IN/JOIN` query with the `GLOBAL IN/GLOBAL JOIN` one.
    - `allow`: Allows the use of such subqueries.

    By default, not selected (equivalent to `deny`).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#distributed-product-mode).

  - **Empty result for aggregation by empty set**{#setting-empty-result-for-aggregation-by-empty-set}: Determines the returned result format when doing data aggregation with no keys (without `GROUP BY`) for an empty set (for example, `SELECT count(*) FROM table WHERE 0`):
    - Disabled (default): {{ CH }} returns a single-line result consisting of `NULL` values for aggregation functions, in accordance with SQL standard.
    - Enabled: {{ CH }} returns an empty result.

  - **Enable HTTP compression**{#setting-enable-http-compression}: Enables or disables data compression in HTTP responses.

    By default, {{ CH }} stores data in a compressed format. When executing a query, its result is uncompressed. Use this setting to command {{ CH }} to compress the result when sending it via HTTP.

    Enable this setting and add the `Accept-Encoding: <compression method>` header in a request to force compression of a response from {{ CH }}.

    ClickHouse supports the following compression methods: `gzip`, `br`, and `deflate`.

    By default, data compression in HTTP responses is disabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/interfaces/http/).

  - **Fallback to stale replicas for distributed queries**{#setting-fallback-to-stale-replicas-for-distributed-queries}: Enables or disables query forcing to a stale replica in case the actual data is unavailable. {{ CH }} will choose the most up-to-date replica and force the query to use the data in this replica. This setting can be used when executing a `SELECT` query from a distributed table that points to replicated tables.

    By default, query forcing is enabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries).

    See also the [Max replica delay for distributed queries](#setting-max-replica-delay-for-distributed-queries) setting.

  - **Force index by date**{#setting-force-index-by-date}: Disables queries if you can't use an index by date. Works with tables of the MergeTree family.

    Disabled by default (queries are allowed).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-force_index_by_date).

  - **Force primary key**{#setting-force-primary-key}: Disables queries if you can't use an index by primary key. Works with tables of the MergeTree family.

    Disabled by default (queries are allowed).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-force_primary_key).

  - **GROUP BY overflow mode**{#setting-group-by-overflow-mode}: Determines the {{ CH }} behavior when the number of unique keys during aggregation [exceeds the limit ](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa):
    - `throw`: Abort query execution and return an error.
    - `break`: Return a partial result.
    - `any`: Perform a `GROUP BY` approximately. The quality of this approximate calculation depends heavily on the statistical properties of the data.

    By default, not selected (equivalent to `throw`).

  - **GROUP BY two level threshold**{#setting-group-by-two-level-threshold}: Sets the threshold of the number of keys. After that, two-level aggregation should be used.

    If `0`, no threshold is set (default: `10000`).

  - **GROUP BY two level threshold bytes**{#setting-group-by-two-level-threshold-bytes}: Sets the threshold of the number of bytes. After that, two-level aggregation should be used.

    If `0`, no threshold is set (default: `100000000`).

  - **HTTP connection timeout**{#setting-http-connection-timeout}: Sets the HTTP connection timeout in milliseconds.

    The value must be greater than 0 (default: `1000`, 1 second).

  - **HTTP headers progress interval**{#setting-http-headers progress interval}: Sets the minimum interval between progress notifications with the `X-ClickHouse-Progress` HTTP header, in milliseconds.

    The value must be greater than zero (default: `100`).

  - **HTTP receive timeout**{#setting-http-receive-timeout} : Sets the HTTP receive timeout, in milliseconds.

    The value must be greater than zero (default: `1800000`, 1800 seconds, 30 minutes).

  - **HTTP send timeout**{#setting-http-send-timeout}: Sets the HTTP send timeout, in milliseconds.

    The value must be greater than zero (default: `1800000`, 1800 seconds, 30 minutes).

  - **Input format defaults for omitted fields**{#setting-input-format-defaults-for-omitted-fields}: Enables or disables replacing omitted input values with default values of the respective columns when performing `INSERT` queries.

    By default, replacement is enabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields).

  - **Input format values interpret expressions**{#setting-input-format-values-interpret-expressions}: Enables or disables the SQL parser if the fast stream parser can't parse the data. Enable this setting if the data that you want to insert into a table contains SQL expressions.

    For example, when inserting a value that contains the `now()` expression into a table, the stream parser won't be able to interpret and parse this expression. With the SQL parser enabled, the expression will be interpreted and parsed correctly and the SQL function result will be inserted as the `now()` value (current date and time).

    This option is only used when inserting data of the [Values](https://clickhouse.tech/docs/en/interfaces/formats/#data-format-values) format.
By default, the SQL parser is enabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions).

  - **Insert quorum**{#setting-insert-quorum}: Enables or disables write quorum for a {{ CH }} cluster:
    - If the value is less than `2`, write quorum is disabled.
    - If the value is greater than or equal to `2`, write quorum is enabled.

    When used, write quorum guarantees that {{ CH }} wrote data to the quorum of Insert quorum replicas correctly within the [Insert quorum timeout](#setting-insert-quorum-timeout). All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous `INSERT` queries. Employ write quorum to make sure that the written data won't be lost if one or more replicas fail.

    You can use the [Select sequential consistency](#setting-select-sequential-consistency) setting to read data written with Insert quorum.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-insert_quorum).

  - **Insert quorum timeout**{#setting-insert-quorum-timeout}: Sets the [insert quorum](#setting-insert-quorum) timeout in milliseconds. If the timeout expired and no write took place, {{ CH }} aborts the `INSERT` query execution, returns an error, and the client must repeat the query to insert the data block into the same or another replica.

    The minimum value is `1000` (1 second). The default is `60000` (1 minute).

  - **Join use nulls**{#setting-join-use-nulls}: Sets the behavior type for `JOIN`. When tables are merged, empty cells may appear. If this option is enabled, the added field changes the type to `Nullable`, and the blank cell is filled with the `NULL` value. Otherwise, the blank cell is filled with the default value for this field type.

    By default, this option is disabled.

    To learn more, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#join_use_nulls).

  - **Joined subquery requires alias**{#setting-joined-subquery-requires-alias}: Requires aliases for subqueries when executing the `JOIN` command.

    If the setting is enabled, this request is not executed:

    ```sql
    SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2)
    ```

    The request with the specified alias is successfully executed:

    ```sql
    SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2) AS MyQuery
    ```

    By default, this option is disabled.

  - **Low cardinality allow in native format**{#setting-low-cardinality-allow-in-native-format}: Determines whether to use the LowCardinality type in native format:
    - Enabled: Yes, use it.
    - Disabled: Convert LowCardinality columns to regular columns when doing a `SELECT` query, and convert regular columns to LowCardinality when doing an `INSERT` query.

    LowCardinality columns (aka sparse columns) store data in a more effective way, compared to regular columns, by using hash tables. If data for insertion suits this storage format, {{ CH }} will place them into the LowCardinality column.

    If you use a third-party {{ CH }} client that can't work with LowCardinality columns, this client won't be able to correctly interpret the result of the query that asks for data stored in the LowCardinality column. Disable this setting to convert LowCardinality columns to regular columns when creating the result, so that such clients can process the result.

    The official {{ CH }} client works with LowCardinality columns out of the box.

    This option is enabled by default.

  - **Max AST depth**{#setting-max-ast-depth}: Limits the maximum depth of an abstract syntax tree.

    Executing a big and complex query may result in building a syntax tree of enormous depth. You can use this setting to ban over-sized or non-optimized queries for huge tables.

    For example, a `SELECT *` query will mostly result in a deeper and more complex syntax tree than a `SELECT ... WHERE ...` query containing constraints and conditions. A user can be forced to construct more optimized queries if this setting is used.

    The value must be greater than zero (default: `1000`). If a too small value is set, it may render ClickHouse unable to execute even simple queries.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#max-ast-depth).

  - **Max AST elements**{#setting-max-ast-elements}: Limits the maximum number of nodes of a query syntax tree.

    Executing a big and complex query may result in building a syntax tree of enormous size. You can use this setting to ban over-sized or non-optimized queries for huge tables.

    The value must be greater than zero (default: `50000`). If a too small value is set, it may render ClickHouse unable to execute even simple queries.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#max-ast-elements).

  - **Max block size**{#setting-max-block-size}: Data in {{ CH }} is processed by blocks (a block is a set of column parts). The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block. This setting is a recommendation for the size of a block (in the number of rows) that should be loaded from tables.

    The value must be greater than zero (default: `65536`).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#setting-max_block_size).

  - **Max bytes before external `GROUP BY`**{#setting-max-bytes-before-external-group-by}: Sets the threshold of RAM consumption (in bytes). After that, the temporary data, collected during the `GROUP BY` aggregation operation, should be flushed to disk to limit the RAM consumption.

    By default, aggregation is done by employing a hash table that resides in RAM. If a query requires aggregation of large amounts of data that can lead to memory exhaustion and abortion of the query (see the [Max memory usage](#setting-max-memory-usage) setting), use this setting to force {{ CH }} to flush the data to disk and make sure the aggregation is successful.

    The minimum and default value is `0` (`GROUP BY` in the external memory is disabled).

    When using aggregation in the external memory, we recommend setting the value of this setting twice as low as the [Max memory usage](#setting-max-memory-usage) setting value (by default, the maximum memory usage is limited to 10 GB).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

    See also the [Distributed aggregation memory efficient](#setting-distributed-aggregation-memory-efficient) setting.

  - **Max bytes before external sort**{#setting-max-bytes-before-external-sort}: This setting is similar to the [previous](#setting-max-bytes-before-external-group-by) setting, except that it is used for the sorting operation (`ORDER BY`).

  - **Max bytes in DISTINCT**{#setting-max-bytes-in-distinct}: Limits the maximum size of a hash table in bytes (uncompressed data) when using `DISTINCT`.

    The minimum and default value is `0`, no limitation is set.

  - **Max bytes to read**{#setting-max-bytes-to-read}: Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.

    The minimum and default value is `0`, no limitation is set.

  - **Max bytes to sort**{#setting-max-bytes-to-sort}: Limits the maximum number of bytes (uncompressed data) that can be read from a table before sorting. Helps reduce RAM consumption during sorting.

    The minimum and default value is `0`, no limitation is set.

  - **Max bytes to transfer**{#setting-max-bytes-to-transfer}: Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using `GLOBAL IN`.

    The minimum and default value is `0`, no limitation is set.

  - **Max columns to read**{#setting-max-columns-to-read}: Limits the maximum number of columns that can be read from a table in a single query. If the query must read more columns to complete, it will be aborted.

    The minimum and default value is `0`, no limitation is set.

  - **Max execution time**{#setting-max-execution-time}: Limits the maximum query execution time in milliseconds. Currently, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation functions.

    The minimum and default value is `0`, no limitation is set.

  - **Max expanded AST elements**{#setting-max-expanded-ast-elements}: Limits the maximum number of nodes of a query syntax tree after expanding aliases and asterisk values.

    Executing a big and complex query may result in building a syntax tree of enormous size. You can use this setting to ban over-sized or non-optimized queries for huge tables.

    The value must be greater than zero (default: `500000`). If a too small value is set, it may render ClickHouse unable to execute even simple queries.

  - **Max INSERT block size**{#setting-max-insert-block-size}: Allows creating blocks of the specified size (in bytes) when inserting data in a table. This setting is effective only if the server creates such blocks on its own.

    The value must be greater than zero (default: `1048576`).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_insert_block_size).

  - **Max memory usage**{#setting-max-memory-usage}: Limits the maximum memory usage (in bytes) for processing a query on a single server. This setting doesn't take the server's free RAM or total RAM into account. This limitation is enforced for a single query on a single server.

    The minimum value is `0` (no limitation is set). The value set in the default config file is `10737418240` (10 GB).

    If you also use the [Max bytes before external `GROUP BY`](#setting-max-bytes-before-external-group-by) or [Max bytes before external sort](#setting-max-bytes-before-external-sort) setting, we recommend that their values are half the Max memory usage value.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#settings_max_memory_usage).

  - **Max memory usage for user**{#setting-max-memory-usage-for-user}: Limits the maximum memory usage (in bytes) for processing user queries on a single server. This setting doesn't take the server's free RAM or total RAM into account. This limitation is enforced for all user queries that run simultaneously on a single server.

    The minimum and default value is `0`, no limitation is set.

  - **Max network bandwidth**{#setting-max-network-bandwidth}: The maximum speed of data exchange over the network in bytes per second for a query.

    The minimum and default value is `0`, no limitation is set.

  - **Max network bandwidth for user**{#setting-max-network-bandwidth-for-user}: The maximum speed of data exchange over the network in bytes per second. This setting, unlike the previous one, affects all concurrently running user queries.

    The minimum and default value is `0`, no limitation is set.

  - **Max query size**{#setting-max-query-size}: Limits the size of the largest part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

    The value must be greater than zero (default: `262144`).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_query_size).

  - **Max replica delay for distributed queries**{#setting-max-replica-delay-for-distributed-queries}: Sets the maximum replica delay in milliseconds. If a replica lags more than the set value, this replica is not used.

    The minimum value is `1000` (one second). The default value is `300000` (300 seconds, or 5 minutes).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries).

    See also the [Fallback to stale replicas for distributed queries](#setting-fallback-to-stale-replicas-for-distributed-queries) setting description.

  - **Max result bytes**{#setting-max-result-bytes}: Limits the maximum number of uncompressed bytes in a result. This limitation is also checked for subqueries and on remote servers when executing part of a distributed query.

    The minimum and default value is `0`, no limitation is set.

  - **Max result rows**{#setting-max-result-rows}: Limits the number of rows in query results. This limitation is also checked for subqueries and on remote servers when executing part of a distributed query.

    The minimum and default value is `0`, no limitation is set.

  - **Max rows in DISTINCT**{#setting-max-rows-in-distinct}: Limits the maximum number of rows when using `DISTINCT`.

    The minimum and default value is `0`, no limitation is set.

  - **Max rows to group by**{#setting-max-rows-to-group-by}: Limits the maximum number of unique keys received from the aggregation function. This setting helps reduce RAM consumption during aggregation.

    The minimum and default value is `0`, no limitation is set.

  - **Max rows to read**{#setting-max-rows-to-read}: Limits the maximum number of rows that can be read from a table when running a query.

    The minimum and default value is `0`, no limitation is set.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#max-rows-to-read).

  - **Max rows to sort**{#setting-max-rows-to-sort}: Limits the maximum number of rows to sort. Helps reduce RAM consumption during sorting.

    The minimum and default value is `0`, no limitation is set.

  - **Max rows to transfer**{#setting-max-rows-to-transfer}: Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using `GLOBAL IN`.

    The minimum and default value is `0`, no limitation is set.

  - **Max temporary columns**{#setting-max-temporary-columns}: Limits the maximum number of temporary columns to be kept in RAM simultaneously when running a query, including constant columns.

    The minimum and default value is `0`, no limitation is set.

  - **Max temporary non const columns**{#setting-max-temporary-non-const-columns}: Limits the maximum number of temporary columns to be kept in RAM simultaneously when running a query, excluding constant columns.

    The minimum and default value is `0`, no limitation is set.

  - **Max threads**{#setting-max-threads}: Limits the maximum number of query processing threads (excluding threads that read data from remote servers). This setting applies to threads that perform the same stages of the query processing pipeline in parallel.

    The minimum and default value is `0` (the number of threads is calculated automatically based on the number of physical CPU cores, excluding HyperThreading cores).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_threads).

  - **Merge tree max bytes to use cache**{#setting-merge-tree-max-bytes-to-use-cache}: Limits the maximum size in bytes for a query that can use the cache of uncompressed data. The cache isn't used for queries larger than the specified value.

    Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

    The value must be greater than zero (default: 192x10x1024x1024).

  - **Merge tree max rows to use cache**{#setting-merge-tree-max-rows-to-use-cache}: Limits the maximum size in rows for a query that can use the cache of uncompressed data. The cache isn't used for queries larger than the specified value.

    Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

    The value must be greater than zero (default: 128x8192).

  - **Merge tree min bytes for concurrent read**{#setting-merge-tree-min-bytes-for-concurrent-read}: Limits the minimum number of bytes to be read from a file to enable concurrent read. If the number of bytes to read exceeds this value, {{ CH }} will try to use a few threads to read data from a file concurrently.

    The value must be greater than zero (default: 24x10x1024x1024).

  - **Merge tree min rows for concurrent read**{#setting-merge-tree-min-rows-for-concurrent-read}: Limits the minimum number of rows to be read from a file to enable concurrent read. If the number of rows to read exceeds this value, {{ CH }} will try to use a few threads to read data from a file concurrently.

    The value must be greater than zero (default: 20x8192).

  - **Min bytes to use Direct I/O**{#setting-merge-tree-min-bytes-to-use-direct-io}: Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O). {{ CH }} uses this parameter when reading data from tables.

    By default, {{ CH }} doesn't read data directly from disk, but relies on the filesystem and its cache instead. This reading strategy is effective for small amounts of data. If the amount of the data to read is large, it is more effective to read it directly from the disk, bypassing the filesystem cache.

    If the total amount of data to read is greater than this setting value, {{ CH }} will fetch the data directly from the disk.

    The minimum and default value is `0`, direct I/O is disabled.

  - **Min count to compile**{#setting-min-count-to-compile}: Sets the minimum count of structurally identical queries to start [compilation](#setting-compile) from.

    The minimum value is `0`. The default is `3`.

    For the `0` value, compilation is synchronous: a query waits for the compilation process to complete before continuing execution. We recommend setting this value only for testing purposes.

    For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#min-count-to-compile).

  - **Min count to compile expression**{#setting-min-count-to-compile-expression}: Sets the minimum count of identical expressions to start [expression compilation](#setting-compile-expressions) with.

    The minimum value is `0`. The default is `3`.

    For the `0` value, compilation is synchronous: an expression waits for the compilation process to complete before continuing query execution. We recommend setting this value only for testing purposes.

    For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

  - **Min INSERT block size bytes**{#setting-min-insert-block-size-bytes}: Limits the minimum number of bytes in a block to be inserted in a table by an `INSERT` query. Blocks that are smaller than the specified value are merged into larger blocks.

    The minimum value is `0` (block merging is disabled). The default is `‭268435456‬‬` (256 MB).

  - **Min INSERT block size rows**{#setting-min-insert-block-size-rows}: Limits the minimum number of rows in a block to be inserted in a table by an `INSERT` query. Blocks that are smaller than the specified value are merged into larger blocks.

    The minimum value is `0` (block merging is disabled). The default is `1048576`.

  - **Output format JSON quote denormals**{#setting-output-format-json-quote-denormals}: Enables or disables special floating-point values (`+nan`, `-nan`, `+inf`, and `-inf`) in JSON output format.

    By default, special values are not output.

  - **Output format JSON quote_64bit integers**{#setting-output-format-json-quote-64bit-integers}: Defines the format of numbers in the JSON output. If this option is enabled, 64-bit integers (`UInt64` and `Int64`) are put in quotes when output in JSON to maintain compatibility with most JavaScript engines, otherwise quotes aren't used.

    By default, using quotes around 64-bit integers is disabled.

  - **Priority**{#setting-priority}: Sets the priority of a query:
    - `0`: No priority is used.
    - `1`: The highest priority.
    - Other: The higher the number, the lower a query's priority.

    This setting should be set up for each query individually.

    If {{ CH }} is handling high-priority queries and a low-priority query enters, the low-priority query is paused until the higher-priority queries are completed.

    The minimum and default value is `0`.

  - **Quota mode**{#setting-quota-mode}: Sets the mode to account for resources consumed when quotas are enabled:
    - `Default`: The default mode, no keys are used.
    - `Keyed`: The `quota_key` is passed in the user query parameter, and the quota is counted separately for each key value.
    - `Keyed_by_ip`: Similar to the previous one, except that the user's IP acts as the key (note that the user can easily change the IPv6 address).

    By default, not selected (equivalent to `default`).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/quotas/).

  - **Read overflow mode**{#setting-read-overflow-mode}: Determines the {{ CH }} behavior when the amount of data read [exceeds one of the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa). Either `throw` (abort execution and return an error) or `break` (return a partial result).

    By default, not selected (equivalent to `throw`).

  - **Readonly**{#setting-readonly}: Enables or disables queries to read data, write data, and edit parameters:
    - `0`: Any types of queries are allowed without limitations (default).
    - `1`: Only read data queries are allowed.
    - `2`: Read data and edit settings queries are allowed.

    This setting doesn't affect running DDL queries. To enable or disable DDL queries, use the [Allow DDL](#setting-allow-ddl) setting.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/permissions-for-queries/#settings_readonly).

    See also: [Example of creating a read-only user](#example-create-readonly-user).

  - **Receive timeout**{#setting-receive-timeout}: Sets the receive timeout, in milliseconds.

    The value must be greater than zero (default: `300000`, 300 seconds, or 5 minutes).

  - **Replication ALTER partitions sync**{#setting-replication-alter-partitions-sync}: Sets the wait mode for asynchronous actions in `ALTER ... ATTACH | DETACH | DROP` queries on replicated tables:
    - `0`: Do not wait.
    - `1`: Only wait for execution at its own (default).
    - `2`: Wait for every action to complete.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/alter/#sinkhronnost-zaprosov-alter).

  - **Result overflow mode**{#setting-result-overflow-mode}: Determines the {{ CH }} behavior when the amount of results exceeds one of the limits. Either `throw` (abort execution and return an error) or `break` (return a partial result).

    By default, not selected (equivalent to `throw`).

  - **SELECT sequential consistency**{#setting-select-sequential-consistency}: Enables or disables sequential consistency for `SELECT` queries.

    By default, sequential consistency is disabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-select_sequential_consistency).

  - **Send progress in HTTP headers**{#setting-send-progress-in-http-headers}: Enables or disables progress notifications using `X-ClickHouse-Progress` headers.

    By default, notifications are disabled.

  - **Send timeout**{#setting-send-timeout}: Sets the send timeout, in milliseconds.

    The value must be greater than zero (default: `300000`, 300 seconds, or 5 minutes).

  - **Skip unavailable shards**{#setting-skip-unavailable-shards}: Enables or disables silent skip of unavailable shards (a shard is considered unavailable if all of its replicas are unavailable).

    By default, silent skip is disabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-skip_unavailable_shards).

  - **Sort overflow mode**{#setting-sort-overflow-mode}: Determines the {{ CH }} behavior when the amount of rows received before sorting [exceeds one of the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa). Either `throw` (abort execution and return an error) or `break` (return a partial result).

    By default, not selected (equivalent to `throw`).

  - **Timeout overflow mode**{#setting-timeout-overflow-mode}: Determines the {{ CH }} behavior when query execution exceeds the `max_execution_time`. Either `throw` (abort execution and return an error) or `break` (return a partial result).

    By default, not selected (equivalent to `throw`).

  - **Transfer overflow mode**{#setting-transfer-overflow-mode}: Determines the {{ CH }} behavior when the amount of data to transfer to another server [exceeds one of the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa). Either `throw` (abort execution and return an error) or `break` (return a partial result).

    By default, not selected (equivalent to `throw`).

  - **Transform null in**{#setting-transform-null-in}: When the compare option is enabled, `NULL = NULL` returns `true` in the `IN` operator.

    By default, this option is disabled (the comparison returns `false` in the `IN` operator).

    To learn more, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#transform_null_in).

  - **Use uncompressed cache**{#setting-use-uncompressed-cache}: Determines whether to use the cache of uncompressed blocks. Using this cache (only for MergeTree tables) may significantly reduce latency and increase throughput when a large amount of small queries is to be processed. Enable this setting for users who initiate small queries frequently.

    By default, the uncompressed cache is disabled.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#setting-use_uncompressed_cache).

    See also the [Merge tree max bytes to use cache](#setting-merge-tree-max-bytes-to-use-cache) and [Merge tree max rows to use cache](#setting-merge-tree-max-rows-to-use-cache) settings.

- CLI

  For a full list of available {{ CH }} settings, see the command description:

  ```
  $ yc managed-clickhouse user create --help
  ```

  Basic settings:

  - **`allow_ddl`**{#setting-cli-allow-ddl}: Allows or bans DDL queries (such as `CREATE`, `ALTER`, and `RENAME`).

    The default is `false` (DDL queries are not allowed).

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl).

  - **`readonly`**{#setting-cli-readonly}: Enables or disables queries to read data, write data, and edit parameters:
    - `0`: Any types of queries are allowed without limitations (default).
    - `1`: Only read data queries are allowed.
    - `2`: Read data and edit settings queries are allowed.

    This setting doesn't affect running DDL queries. To enable or disable DDL queries, use the [Allow DDL](#setting-cli-allow-ddl) setting.

    For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/permissions-for-queries/#settings_readonly).

    See also: [Example of creating a read-only user](#example-create-readonly-user).

- SQL

  For a full list of available settings, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/).

{% endlist %}

