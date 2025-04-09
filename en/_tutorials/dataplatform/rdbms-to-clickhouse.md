

You can migrate a database from {{ PG }} to {{ CH }} using {{ data-transfer-full-name }}. Proceed as follows:

1. [Set up your transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#example-check-replication).
1. [Select the data from the target](#working-with-data-ch).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mpg-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* {{ mch-name }} cluster fee: Using computing resources allocated to hosts (including ZooKeeper hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Transfer fee: Using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

For clarity, we will create all required resources in {{ yandex-cloud }}. Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

  1. Create a source {{ mpg-name }} cluster in any applicable [configuration](../../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`.

  1. Create a {{ mch-name }} target cluster in any applicable [configuration](../../managed-clickhouse/concepts/instance-types.md) with publicly available hosts and the following settings:
      * **Number of {{ CH }} hosts**: At least two, which is required to enable replication in the cluster.
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `ch-user`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<target_password>`.

  
  1. If you are using security groups in clusters, make sure they are set up correctly and allow connecting to the clusters:

     * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
     * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups).


  1. [Grant](../../managed-postgresql/operations/grant#grant-privilege) the `mdb_replication` role to `pg-user` in the {{ mpg-name }} cluster.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [postgresql-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-clickhouse/blob/main/postgresql-to-clickhouse.tf) configuration file to the same working directory.

        This file describes:

        * [Networks](../../vpc/concepts/network.md#network).
        * [Subnets](../../vpc/concepts/network.md#subnet).
        * [Security groups](../../vpc/concepts/security-groups.md) for making cluster connections.
        * {{ mpg-name }} source cluster.
        * {{ mch-name }} target cluster.
        * Source endpoint.
        * Target endpoint.
        * Transfer.

    1. In the `postgresql-to-clickhouse.tf` file, specify the passwords of the {{ PG }} and {{ CH }} admin user.
    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up your transfer {#prepare-transfer}

1. [Connect to the {{ mpg-name }} cluster](../../managed-postgresql/operations/connect.md).
1. Create a table named `x_tab` in the `db1` database and populate it with data:

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

        1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<source_{{ PG }}_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.

        1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/clickhouse.md) of the `ClickHouse` type and specify the cluster connection settings in it:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}**: `<target_{{ CH }}_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}**: `ch-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}**: `<user_password>`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.cleanup_policy.title }}**: `DROP`.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the [**{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}**](../../data-transfer/concepts/index.md#transfer-type) type that will use the created endpoints.

    - {{ TF }} {#tf}

        1. In the `postgresql-to-clickhouse.tf` file, set the `transfer_enabled` parameter to `1`.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait until its status switches to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. To check that the transfer has moved the replicated data to the target, connect to the target {{ mch-full-name }} cluster and make sure that the `x_tab` table in `db1` has the same columns as the `x_tab` table in the source database, as well as the [timestamp columns](#working-with-data-ch), `__data_transfer_commit_time` and `__data_transfer_delete_time`:

   ```sql
   SELECT * FROM db1.x_tab WHERE id = 41;
   ```

   ```text
   ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
   │ 41 │  User2 │   1633417594957267000          │ 0                             │
   └────┴────────┴────────────────────────────────┴───────────────────────────────┘
   ```

## Test the replication process {#example-check-replication}

1. Connect to the source cluster.
1. In the `x_tab` table of the source {{ PG }} database, delete the row with the `41` ID and update the one with the `42` ID:

    ```sql
    DELETE FROM db1.public.x_tab WHERE id = 41;
    UPDATE db1.public.x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Check the changes in the `x_tab` table on the {{ CH }} target:

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

## Select the data from {{ CH }} {#working-with-data-ch}

For table recovery, the {{ CH }} target with [replication](../../managed-clickhouse/concepts/replication.md) enabled uses the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/) engines. The following columns are added automatically to each table:

* `__data_transfer_commit_time`: Time when the was row updated to this value, in `TIMESTAMP` format.
* `__data_transfer_delete_time`: Row deletion time, in `TIMESTAMP` format, if the row was deleted in the source. If the row was not deleted, the value is set to `0`.

    The `__data_transfer_commit_time` column is required for the ReplicatedReplacedMergeTree engine to work. If a record is deleted or updated, a new row is inserted with a value in this column. A query by a single primary key returns multiple records with different `__data_transfer_commit_time` values.

With the **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}** transfer status, the source data can be added or deleted. To ensure standard behavior of SQL commands when a primary key points to a single record, provide a clause to filter data by `__data_transfer_delete_time` when querying tables transferred to {{ CH }}. Here is an example of a query to the `x_tab` table:

```sql
SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

To simplify the `SELECT` queries, create a view with filtering by `__data_transfer_delete_time` and use it for querying. Here is an example of a query to the `x_tab` table:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

{% note info %}

Using the `FINAL` keyword in queries makes them much less efficient. Avoid it when working with large tables whenever possible.

{% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* Make sure the transfer has the **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** status and [delete](../../data-transfer/operations/transfer.md#delete) it.
* Delete the endpoints and clusters:

    {% list tabs group=instructions %}

    - Manually {#manual}

        * [Both the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).
        * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        * [{{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
