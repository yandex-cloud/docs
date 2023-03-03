You can migrate a database from {{ PG }} to {{ CH }} using {{ data-transfer-full-name }}. To do this:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#example-check-replication).
1. [Select the data from the target](#working-with-data-ch).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

We'll create all the required resources for the example in {{ yandex-cloud }}. Prepare the infrastructure:

{% list tabs %}

* Manually

   1. Create a source {{ mpg-name }} cluster in any applicable [configuration](../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
      * Database name: `db1`.
      * Username: `pg-user`.
      * Password: `<password for the source>`.

   1. Create a {{ mch-name }} target cluster in any applicable [configuration](../managed-clickhouse/concepts/instance-types.md) with publicly available hosts and the following settings:
      * Number of {{ CH }} hosts: At least 2 (to enable replication in the cluster).
      * Database name: `db1`.
      * Username: `ch-user`.
      * Password: `<password for the target>`.

   
   1. Make sure that the cluster's security groups have been set up correctly and allow connecting to them:
      * [{{ mch-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).
      * [{{ mpg-name }}](../managed-postgresql/operations/connect.md#configuring-security-groups).


   1. [Grant the `mdb_replication` role](../managed-postgresql/operations/grant#grant-privilege) to the `pg-user` in the {{ mpg-name }} cluster.

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [postgresql-to-clickhouse.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/postgresql-to-clickhouse.tf) configuration file to the same working directory.

      This file describes:

      * [Networks](../vpc/concepts/network.md#network).
      * [Subnets](../vpc/concepts/network.md#subnet).
      * [Security groups](../vpc/concepts/security-groups.md) for making cluster connections.
      * {{ mpg-name }} source cluster.
      * {{ mch-name }} target cluster.
      * Source endpoint.
      * Target endpoint.
      * Transfer.

   1. In the `postgresql-to-clickhouse.tf` configuration file, specify the {{ PG }} and {{ CH }} administrator passwords.
   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Connect to the cluster {{ mpg-name }}](../managed-postgresql/operations/connect.md)
1. In the `db1` database, create a table named `x_tab`, and populate it with data:

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

   {% list tabs %}

   * Manually

      1. [Create a source endpoint](../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

         * **Connection type**: `Managed Service for PostgreSQL cluster`.
         * **Cluster**: `<{{ PG }} source cluster name>` from the drop-down list.
         * **Database**: `db1`.
         * **Password**: `pg-user`.
         * **Password**: `<user password>`.

      1. [Create a target endpoint](../data-transfer/operations/endpoint/target/clickhouse.md) of the `{{ CH }}` type and specify the cluster connection parameters in it.

         * **Connection type**: `Managed Service for ClickHouse cluster`.
         * **Cluster**: `<{{ CH }} target cluster name>` from the drop-down list.
         * **Database**: `db1`.
         * **User**: `ch-user`.
         * **Password**: `<user password>`.
         * **Cleanup policy**: `DROP`.

      1. [Create a transfer](../data-transfer/operations/transfer.md#create) of the [{{ dt-type-copy-repl }}](../data-transfer/concepts/index.md#transfer-type) type that will use the created endpoints.

   * Using {{ TF }}

      1. Set the `transfer_enabled` variable to `1` in the `postgresql-to-clickhouse.tf` file.

      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

   {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../data-transfer/operations/transfer.md#activate) and wait for its status to change to {{ dt-status-repl }}.
1. To check that the transfer has moved the replicated data to the target, connect to the target {{ mch-full-name }} cluster and make sure that the `x_tab` table in `db1` includes the same columns as the `x_tab` table in the source database, as well as the [timestamp columns](#working-with-data-ch): `__data_transfer_commit_time` and `__data_transfer_delete_time`:

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
1. Delete the row with the `41` ID and edit the row with the `42` ID in the `x_tab` table of the {{ PG }} source database:

   ```sql
   DELETE FROM db1.public.x_tab WHERE id = 41;
   UPDATE db1.public.x_tab SET name = 'Key3' WHERE id = 42;
   ```

1. Make sure that you see the changes in the `x_tab` table on the {{ CH }} target:

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

## Select the data from {{ CH }} {#working-with-data-ch}.

For table recovery, the {{ CH }} target with [replication](../managed-clickhouse/concepts/replication.md) enabled uses the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and the [ReplacingMergeTree]({{ ch.docs }}engines/table-engines/mergetree-family/replacingmergetree/). The following columns are added automatically to each table:

* `__data_transfer_commit_time`: The time allowed for the row to change to this value, in `TIMESTAMP` format.
* `__data_transfer_delete_time`: The time allowed for deleting the row, in `TIMESTAMP` format, if the row has been deleted from the source. If the row hasn't been deleted, `0` is set.

   The `__data_transfer_commit_time` column is needed for the ReplicatedReplacedMergeTree engine. If a record is deleted or updated, a new row with the value in this column is inserted. The query by a single primary key returns multiple records with different values from the `__data_transfer_commit_time` column.

If the transfer status is {{ dt-status-repl }}, the source data can be added or deleted. To ensure the standard behavior of SQL commands when a primary key points to a single record, add a construction that filters data by the `__data_transfer_delete_time` column to your queries to tables moved to {{ CH }}. For example, for the `x_tab` table:

```sql
SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

To make it easier to run a `SELECT`, create a view with filtering by the `__data_transfer_delete_time` column and access it. For example, for the `x_tab` table:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

{% note info %}

The `FINAL` keyword noticeably decreases the query efficiency. Avoid it when working with large tables whenever possible.

{% endnote %}

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

* Make sure that the transfer's status is {{ dt-status-finished }} and [delete](../data-transfer/operations/transfer.md#delete) it.
* Delete the endpoints and clusters:

   {% list tabs %}

   * Manually

      * [The source endpoint and the target endpoint](../data-transfer/operations/endpoint/index.md#delete).
      * [{{ mpg-name }}](../managed-postgresql/operations/cluster-delete.md).
      * [{{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).

   * Using {{ TF }}

      If you created your resources using {{ TF }}:

      1. In the terminal window, change to the directory containing the infrastructure plan.
      1. Delete the `postgresql-to-clickhouse.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the update of resources.

         {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `postgresql-to-clickhouse.tf` configuration file will be deleted.

   {% endlist %}
