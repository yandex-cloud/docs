# Migrating databases from {{ MY }} to {{ CH }} using {{ data-transfer-full-name }}

With {{ data-transfer-name }}, you can migrate your database from a {{ MY }} source cluster to {{ CH }}.

To transfer data, perform these steps:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).
1. [Select the data from {{ CH }}](#working-with-data-ch).

If you no longer need these resources, you can [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a {{ mmy-name }} source cluster](../managed-mysql/operations/cluster-create.md) with any suitable configuration. To connect to the cluster from the user's local machine rather than doing so from the {{ yandex-cloud }} network, enable public access to the cluster when creating it.

   1. [Create a {{ mch-name }} target cluster](../managed-clickhouse/operations/cluster-create.md) in any suitable configuration with the following settings:

      * Number of {{ CH }} hosts: At least two, which is required to enable replication in the cluster.
      * Database name: Same as in the source cluster.
      * To connect to the cluster from the user's local machine rather than doing so from the {{ yandex-cloud }} network, enable public access to the cluster when creating it.

   1. Configure security groups for your clusters so you can connect to them from the internet:

      * [{{ mmy-name }}](../managed-mysql/operations/connect.md#configuring-security-groups).
      * [{{ mch-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).

* Using {{ TF }}

   1. If you do not have {{ TF }} yet, {% if audience != "internal" %}[install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install and configure it{% endif %}.
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and {% if audience != "internal" %}[specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}specify the parameter values{% endif %}.
   1. Download the [data-transfer-mmy-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mmy-mch.tf) configuration file to the same working directory.

      This file describes:

      * {% if audience != "internal" %}[Network](../vpc/concepts/network.md#network){% else %}Network{% endif %}.
      * {% if audience != "internal" %}[Subnet](../vpc/concepts/network.md#subnet){% else %}Subnet{% endif %}.
      * {% if audience != "internal" %}[Security groups](../vpc/concepts/security-groups.md){% else %}Security groups{% endif %} and the rule required to connect to a {{ mmy-name }} cluster.
      * {{ mmy-name }} source cluster.
      * {{ mch-name }} target cluster.
      * Source endpoint.
      * Target endpoint.
      * Transfer.

   1. In the `data-transfer-mmy-mch.tf` file, specify:

      * The {{ mmy-name }} source cluster parameters that will also be used as the [source endpoint parameters](../data-transfer/operations/endpoint/target/mysql.md#managed-service):

         * `source_mysql_version`: {{ MY }} version.
         * `source_db_name`: {{ MY }} database name to be used as the {{ mch-name }} database name.
         * `source_user` and `source_password`: Database owner username and password.

      * The {{ mch-name }} target cluster parameters that will also be used as the [target endpoint parameters](../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

         * `target_user` and `target_password`: Database owner username and password.

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

## Prepare the source cluster {#prepare-source}

1. If you created the infrastructure manually, [prepare the source cluster](../data-transfer/operations/prepare.md#source-my).

1. [Connect to the {{ mmy-name }} source cluster](../managed-mysql/operations/connect.md).

1. Add test data to the database.

   1. Create a table named `x_tab`:

   ```sql
   CREATE TABLE x_tab
   (
       id INT,
       name TEXT,
       PRIMARY KEY (id)
   );
   ```

   1. Populate the table with data:

   ```sql
   INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
   ```

## Prepare and activate the transfer {#prepare-transfer}

{% list tabs %}

* Manually

   1. [Create a source endpoint](../data-transfer/operations/endpoint/index.md#create):

      * **Database type**: `{{ MY }}`.
      * **Endpoint parameters** → **Connection settings**: `{{ mmy-name }} cluster`.

         Select a source cluster from the list and specify the cluster connection settings.

   1. [Create a target endpoint](../data-transfer/operations/endpoint/index.md#create):

      * **Database type**: `{{ CH }}`.
      * **Endpoint parameters** → **Connection settings**: `{{ mch-name }} cluster`.

         Select a target cluster from the list and specify the cluster connection settings.

   1. [Create a transfer](../data-transfer/operations/transfer.md#create) with a _{{ dt-type-copy-repl }}_ type that will use the created endpoints.
   1. [Activate](../data-transfer/operations/transfer.md#activate) your transfer.

* Using {{ TF }}

   1. In the `data-transfer-mmy-mch.tf` file, set the `transfer_enabled` variable to `1`.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      Once created, your transfer will be activated automatically.

{% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.

1. Make sure the data from the source {{ mmy-name }} cluster has been moved to the {{ mch-name }} database:

   1. [Connect to the cluster](../managed-clickhouse/operations/connect.md) using `clickhouse-client`.

   1. Run the following query:

      ```sql
      SELECT * FROM <{{ CH }} database name>.x_tab
      ```

      The result you are going to get should look like this:

      ```text
      ┌─id─┬─name──┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
      │ 40 │ User1 │         1661952756538347180 │                           0 │
      │ 41 │ User2 │         1661952756538347180 │                           0 │
      │ 42 │ User3 │         1661952756538347180 │                           0 │
      │ 43 │ User4 │         1661952756538347180 │                           0 │
      │ 44 │ User5 │         1661952756538347180 │                           0 │
      └────┴───────┴─────────────────────────────┴─────────────────────────────┘
      ```

      The table also contains [columns with timestamps](#working-with-data-ch), such as `__data_transfer_commit_time` and `__data_transfer_delete_time`.

1. In the `x_tab` table of the {{ MY }} source database, delete the `41` `ID` row and edit the `42` `ID` one:

   1. [Connect to the {{ mmy-name }} source cluster](../managed-mysql/operations/connect.md).

   1. Run the following queries:

      ```sql
      DELETE FROM x_tab WHERE id = 41;
      UPDATE x_tab SET name = 'Key3' WHERE id = 42;
      ```

1. Make sure that you see the changes in the `x_tab` table on the {{ CH }} target:

   ```sql
   SELECT * FROM <{{ CH }} database name>.x_tab WHERE id in (41,42);
   ```

   The result you are going to get is the following:

   ```text
   ┌─id─┬─name──┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
   │ 41 │ User2 │         1661952756538347180 │                           0 │
   │ 42 │ User3 │         1661952756538347180 │                           0 │
   └────┴───────┴─────────────────────────────┴─────────────────────────────┘
   ┌─id─┬─name─┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
   │ 41 │ ᴺᵁᴸᴸ │         1661953256000000000 │         1661953256000000000 │
   └────┴──────┴─────────────────────────────┴─────────────────────────────┘
   ┌─id─┬─name─┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
   │ 42 │ Key3 │         1661953280000000000 │                           0 │
   └────┴──────┴─────────────────────────────┴─────────────────────────────┘
   ```

## Select the data from {{ CH }} {#working-with-data-ch}

For table recovery, the {{ CH }} target with [replication](../managed-clickhouse/concepts/replication.md) enabled uses the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and the [ReplacingMergeTree]({{ ch.docs }}engines/table-engines/mergetree-family/replacingmergetree/) engines. The following columns are added automatically to each table:

* `__data_transfer_commit_time`: The time allowed for the row to change to this value, in the `TIMESTAMP` format.
* `__data_transfer_delete_time`: The time allowed for deleting the row, in the `TIMESTAMP` format, in case the row has been deleted from the source. If the row has not been deleted, the default value is `0`.

   The `__data_transfer_commit_time` column is required for the `ReplicatedReplacedMergeTree` engine. If a record is deleted or updated, a new row with a value is inserted to this column. When running a query by a single primary key, it will return multiple records with different values from the `__data_transfer_commit_time` column.

With the {{ dt-status-repl }} transfer status, you can both add and delete source data. To ensure the normal behavior of SQL commands when a primary key points to a single record, add a construction that filters data by the `__data_transfer_delete_time` column to your queries to the tables moved to {{ CH }}. For example, for the `x_tab` table, run the following query:

```sql
SELECT * FROM <{{ CH }} database name>.x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

To make it easier to run a `SELECT` query, create a view with filtering by the `__data_transfer_delete_time` column and access it. For example, for the `x_tab` table, the query will be the following:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM <{{ CH }} database name>.x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../_includes/mdb/note-before-delete-resources.md) %}

If you no longer need these resources, delete them:

{% list tabs %}

* Manually

   1. [Delete the transfer](../data-transfer/operations/transfer.md#delete-transfer).
   1. [Delete endpoints](../data-transfer/operations/endpoint/index.md#delete) for both source and target.
   1. [Delete the {{ mmy-name }} cluster](../managed-mysql/operations/cluster-delete.md).
   1. [Delete the {{ mch-name }} cluster](../managed-clickhouse/operations/cluster-delete.md).

* Using {{ TF }}

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mmy-mch.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-mmy-mch.tf` configuration file will be deleted.

{% endlist %}
