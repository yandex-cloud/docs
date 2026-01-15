

You can migrate a database from {{ PG }} to {{ CH }} using {{ data-transfer-full-name }}. Proceed as follows:

1. [Set up and activate the transfer](#prepare-transfer).
1. [Test the replication process](#example-check-replication).
1. [Query data in the target system](#working-with-data-ch).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mpg-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* {{ mch-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

In our example, we will create all required resources in {{ yandex-cloud }}. Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

  1. Create a source {{ mpg-name }} cluster using any suitable [configuration](../../managed-postgresql/concepts/instance-types.md) with publicly accessible hosts. Specify the following settings:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`.

  1. Create a {{ mch-name }} target cluster using any suitable [configuration](../../managed-clickhouse/concepts/instance-types.md) with publicly accessible hosts. Specify the following settings:
      * **Number of {{ CH }} hosts**: Minimum of 2 to enable replication within the cluster.
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `ch-user`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<target_password>`.

  
  1. If using security groups, make sure they are configured correctly and allow inbound connections to the clusters.

     * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
     * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups).


  1. [Grant](../../managed-postgresql/operations/grant.md#grant-privilege) the `mdb_replication` role to `pg-user` in the {{ mpg-name }} cluster.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [postgresql-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-clickhouse/blob/main/postgresql-to-clickhouse.tf) configuration file to your current working directory.

        This file describes:

        * [Networks](../../vpc/concepts/network.md#network).
        * [Subnets](../../vpc/concepts/network.md#subnet).
        * [Security groups](../../vpc/concepts/security-groups.md) for cluster connectivity.
        * {{ mpg-name }} source cluster.
        * {{ mch-name }} target cluster.
        * Source endpoint.
        * Target endpoint.
        * Transfer.

    1. In the `postgresql-to-clickhouse.tf` file, specify admin passwords for {{ PG }} and {{ CH }}.
    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up and activate the transfer {#prepare-transfer}

1. [Connect to the {{ mpg-name }} cluster](../../managed-postgresql/operations/connect.md).
1. In the `db1` database, create a table named `x_tab` and populate it with data:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC PRIMARY KEY,
         name CHAR(5)
     );
     CREATE INDEX ON x_tab (id);
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. Create a `{{ PG }}`-type [source endpoint](../../data-transfer/operations/endpoint/source/postgresql.md) and configure it using the following settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: Select `<source_{{ PG }}_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.

        1. Create a `ClickHouse`-type [target endpoint](../../data-transfer/operations/endpoint/target/clickhouse.md) and specify its cluster connection settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}**: Select `<target_{{ CH }}_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}**: `ch-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}**: `<user_password>`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.cleanup_policy.title }}**: `DROP`.

        1. Create a [**{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}**](../../data-transfer/concepts/index.md#transfer-type)-type [transfer](../../data-transfer/operations/transfer.md#create), configure it to use the previously created endpoints, then [activate](../../data-transfer/operations/transfer.md#activate) it.

    - {{ TF }} {#tf}

        1. In the `postgresql-to-clickhouse.tf` file, set the `transfer_enabled` variable to `1`.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [terraform-resources](../../_includes/mdb/terraform/explore-resources.md) %}

        The transfer will activate automatically upon creation.

    {% endlist %}

## Test the replication process {#example-check-replication}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. To verify that the data has been replicated to the target, connect to the target {{ mch-full-name }} cluster. Make sure the `x_tab` tables in `db1` and the source database have identical schemas, including [timestamp columns](#working-with-data-ch), `__data_transfer_commit_time` and `__data_transfer_delete_time`:

   ```sql
   SELECT * FROM db1.x_tab WHERE id = 41;
   ```

   ```text
   ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
   │ 41 │  User2 │   1633417594957267000          │ 0                             │
   └────┴────────┴────────────────────────────────┴───────────────────────────────┘
   ```

1. Connect to the source cluster.
1. In the `x_tab` table of the source {{ PG }} database, delete the row with ID = `41` and update the row with ID = `42`:

    ```sql
    DELETE FROM db1.public.x_tab WHERE id = 41;
    UPDATE db1.public.x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Make sure the changes have been applied to the `x_tab` table on the {{ CH }} target:

    ```sql
    SELECT * FROM db1.x_tab WHERE (id >= 41) AND (id <= 42);
    ```

    ```text
    ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
    │ 41 │  User2 │   1633417594957267000          │ 1675417594957267000           │
    │ 42 │  Key3  │   1675417594957267000          │ 0                             │
    │ 42 │  User3 │   1633417594957268000          │ 1675417594957267000           │
    └────┴────────┴────────────────────────────────┴───────────────────────────────┘
    ```

## Query data in {{ CH }} {#working-with-data-ch}

For table recovery, {{ CH }} targets with [replication](../../managed-clickhouse/concepts/replication.md) use the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/) engines. The following columns are automatically added to each table:

* `__data_transfer_commit_time`: Time the row was updated to this value, in `TIMESTAMP` format.
* `__data_transfer_delete_time`: Time the row was deleted from the source, in `TIMESTAMP` format. A value of `0` indicates that the row is still active.

    The `__data_transfer_commit_time` column is essential for the ReplicatedReplacedMergeTree engine. If a record is deleted or updated, a new row gets inserted with a value in this column. Querying by the primary key alone returns several records with different `__data_transfer_commit_time` values.

The source data can be added or deleted while the transfer is in **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}** status. For standard SQL command behavior, where the primary key returns a single record, add filtering by the `__data_transfer_delete_time` column when querying tables transferred to {{ CH }}. For example, to query the `x_tab` table, use the following syntax:

```sql
SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

To simplify the `SELECT` queries, create a view filtering rows by `__data_transfer_delete_time`. Use this view for all your queries. For example, to query the `x_tab` table, use the following syntax:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

{% note info %}

Using the `FINAL` keyword reduces query performance, so avoid it whenever possible, especially on large tables.

{% endnote %}

## Delete the resources you created {#clear-out}

To reduce the consumption of resources you do not need, delete them:

1. Make sure the transfer status is **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**, upon which you can [delete](../../data-transfer/operations/transfer.md#delete) the transfer.
1. Delete other resources using the same method used for their creation:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete both the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).
        1. [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).
        1. [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
