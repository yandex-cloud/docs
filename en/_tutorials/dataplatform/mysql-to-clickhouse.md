# Asynchronous replication of data from {{ mmy-name }} to {{ mch-name }} using {{ data-transfer-full-name }}


{{ data-transfer-name }} enables you to migrate your database from a {{ MY }} source cluster to {{ CH }}.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).
1. [Query data in {{ CH }}](#working-with-data-ch).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mmy-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* {{ mch-name }} cluster, which includes the use of computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer, which includes the use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) of any suitable configuration. Enable public access to the cluster during creation so you can connect to it from your local machine. Connections from within the {{ yandex-cloud }} network are enabled by default.

    1. [Create a target {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with the following settings:

        * Number of {{ CH }} hosts: Minimum of 2 to enable replication within the cluster.
        * Database name: Must be identical to the database name in the source cluster.
        * To be able to connect to the cluster not only from within the {{ yandex-cloud }} network but also from your local machine, enable public access when creating it.

    
    1. If using security groups, configure them to allow internet access to your clusters:

        * [{{ mmy-name }}](../../managed-mysql/operations/connect/index.md#configuring-security-groups).
        * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-transfer-mmy-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-clickhouse/blob/main/data-transfer-mmy-mch.tf) configuration file to your current working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnets](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and the rule required for connecting to the {{ mmy-name }} cluster.
        * {{ mmy-name }} source cluster.
        * {{ mch-name }} target cluster.
        * Source endpoint.
        * Target endpoint.
        * Transfer.

    1. In the `data-transfer-mmy-mch.tf` file, specify the following:

        * {{ mmy-name }} source cluster parameters to use for the [source endpoint](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

            * `source_mysql_version`: {{ MY }} version.
            * `source_db_name`: {{ MY }} database name.
            * `source_user` and `source_password`: Database owner username and password.

        * {{ mch-name }} target cluster parameters to use for the [target endpoint](../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

            * `target_db_name`: {{ CH }} database name.
            * `target_user` and `target_password`: Database owner username and password.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the source cluster {#prepare-source}

1. If you created the infrastructure manually, [set up your source cluster](../../data-transfer/operations/prepare.md#source-my).

1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect/index.md).

1. Populate the database with test data.

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

## Set up and activate the transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MY }}`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`

            Select your source cluster from the list and specify its connection settings.

    1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`

            Select your target cluster from the list and specify its connection settings.

    1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**-type that will use the endpoints you created.
    1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

- {{ TF }} {#tf}

    1. In the `data-transfer-mmy-mch.tf` file, set the `transfer_enabled` variable to `1`.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        The transfer will be activated automatically upon creation.

{% endlist %}

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the data from the {{ mmy-name }} source cluster has been transferred to the {{ mch-name }} database:

    1. [Connect to the cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) using `clickhouse-client`.

    1. Run this query:

        ```sql
        SELECT * FROM <{{ CH }}_database_name>.x_tab
        ```

        Result:

        ```text
        ┌─id─┬─name──┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
        │ 40 │ User1 │         1661952756538347180 │                           0 │
        │ 41 │ User2 │         1661952756538347180 │                           0 │
        │ 42 │ User3 │         1661952756538347180 │                           0 │
        │ 43 │ User4 │         1661952756538347180 │                           0 │
        │ 44 │ User5 │         1661952756538347180 │                           0 │
        └────┴───────┴─────────────────────────────┴─────────────────────────────┘
        ```

        The table also contains the following [timestamp columns](#working-with-data-ch): `__data_transfer_commit_time` and `__data_transfer_delete_time`.

1. In the source {{ MY }} table `x_tab`, delete the row with `id` = `41` and update the row with `id` = `42`:

    1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect/index.md).

    1. Run the following queries:

        ```sql
        DELETE FROM x_tab WHERE id = 41;
        UPDATE x_tab SET name = 'Key3' WHERE id = 42;
        ```

1. Make sure the changes have been applied to the `x_tab` table on the {{ CH }} target:

    ```sql
    SELECT * FROM <{{ CH }}_database_name>.x_tab WHERE id in (41,42);
    ```

    Result:

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

## Query data in {{ CH }} {#working-with-data-ch}

For table recovery, {{ CH }} targets with [replication](../../managed-clickhouse/concepts/replication.md) use the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/) engines. The following columns are automatically added to each table:

* `__data_transfer_commit_time`: Time the row was updated to this value, in `TIMESTAMP` format.
* `__data_transfer_delete_time`: Time the row was deleted from the source, in `TIMESTAMP` format. A value of `0` indicates that the row is still active.

    The `__data_transfer_commit_time` column is essential for the ReplicatedReplacedMergeTree engine. If a record is deleted or updated, a new row gets inserted with a value in this column. Querying by the primary key alone returns several records with different `__data_transfer_commit_time` values.

The source data can be added or deleted while the transfer is in **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}** status. For standard SQL command behavior, where the primary key returns a single record, add filtering by the `__data_transfer_delete_time` column when querying tables transferred to {{ CH }}. For example, to query the `x_tab` table, use the following syntax:

```sql
SELECT * FROM <{{ CH }}_database_name>.x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

To simplify the `SELECT` queries, create a view filtering rows by `__data_transfer_delete_time`. Use this view for all your queries. For example, to query the `x_tab` table, use the following syntax:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM <{{ CH }}_database_name>.x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../../_includes/mdb/note-before-delete-resources.md) %}

To reduce the consumption of resources, delete those you do not need:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete-transfer).
    1. [Delete the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
    1. [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
