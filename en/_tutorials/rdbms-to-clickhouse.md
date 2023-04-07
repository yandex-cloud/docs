You can migrate a database from {{ PG }} to {{ CH }} using {{ data-transfer-full-name }}. To do this:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#example-check-replication).
1. [Select the data from the target](#working-with-data-ch).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

For clarity, we will create all required resources in {{ yandex-cloud }}. Prepare the infrastructure:

{% list tabs %}

* Manually

   1. Create a source {{ mpg-name }} cluster in any applicable [configuration](../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
      * Database name: `db1`.
      * Username: `pg-user`.
      * Password: `<password for the source>`.

   1. Create a {{ mch-name }} target cluster in any applicable [configuration](../managed-clickhouse/concepts/instance-types.md) with publicly available hosts and the following settings:
      * Number of {{ CH }} hosts: At least two, which is required to enable replication in the cluster.
      * Database name: `db1`.
      * Username: `ch-user`.
      * Password: `<password for the target>`.

   
   1. If you are using security groups in your clusters, make sure they have been set up correctly and allow connection to clusters:

      * [{{ mch-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).
      * [{{ mpg-name }}](../managed-postgresql/operations/connect.md#configuring-security-groups).

      {% include [preview-pp.md](../_includes/preview-pp.md) %}


   1. [Grant the `mdb_replication` role](../managed-postgresql/operations/grant#grant-privilege) to the `pg-user` in the {{ mpg-name }} cluster.

* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
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
   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

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

      1. [Create a transfer](../data-transfer/operations/transfer.md#create) with a [{{ dt-type-copy-repl }}](../data-transfer/concepts/index.md#transfer-type) type that will use the created endpoints.

   * Using {{ TF }}

      1. Set the `transfer_enabled` variable to `1` in the `postgresql-to-clickhouse.tf` file.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

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
1. In the `x_tab` table of the {{ PG }} source database, delete the row where ID is `41` and update the one where ID is `42`:

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

For table recovery, the {{ CH }} target with [replication](../managed-clickhouse/concepts/replication.md) enabled uses the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and the [ReplacingMergeTree]({{ ch.docs }}engines/table-engines/mergetree-family/replacingmergetree/) engines. The following columns are added automatically to each table:

* `__data_transfer_commit_time`: Time allowed for the row to change to this value, in `TIMESTAMP` format.
* `__data_transfer_delete_time`: Time allowed for deleting the row, in `TIMESTAMP` format, if the row has been deleted from the source. If it has not, the value is set at `0`.

   The `__data_transfer_commit_time` column is required for the ReplicatedReplacedMergeTree engine. If a record is deleted or updated, a new row is inserted with a value in this column. When running a query by a single primary key, it will return multiple records with different values from the `__data_transfer_commit_time` column.

With the {{ dt-status-repl }} transfer status, the source data may be both added and deleted. To ensure the standard behavior of SQL commands when a primary key points to a single record, add a construction that filters data by the `__data_transfer_delete_time` column to your queries to the tables moved to {{ CH }}. For example, for the `x_tab` table, the query will be the following:

```sql
SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

To make it easier to run a `SELECT` query, create a view with filtering by the `__data_transfer_delete_time` column and access it. For example, for the `x_tab` table, the query will be the following:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

{% note info %}

The `FINAL` keyword noticeably decreases the query efficiency. Avoid it when working with large tables whenever possible.

{% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* Make sure the transfer has the  {{ dt-status-finished }} status and [delete](../data-transfer/operations/transfer.md#delete) it.
* Delete the endpoints and clusters:

   {% list tabs %}

   * Manually

      * [The source endpoint and the target endpoint](../data-transfer/operations/endpoint/index.md#delete).
      * [{{ mpg-name }}](../managed-postgresql/operations/cluster-delete.md).
      * [{{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).

   * Using {{ TF }}

      If you created your resources using {{ TF }}:

      1. In the terminal window, switch to the directory containing the infrastructure plan.
      1. Delete the `postgresql-to-clickhouse.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the resources have been updated.

         {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `postgresql-to-clickhouse.tf` configuration file will be deleted.

   {% endlist %}
