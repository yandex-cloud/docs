# Loading data from {{ ydb-full-name }} to {{ mch-full-name }} using {{ data-transfer-full-name }}


With {{ data-transfer-name }}, you can upload data from a {{ ydb-name }} database to a {{ mch-name }} cluster.

To upload data:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../../ydb/operations/manage-databases.md) named `ydb1` in any suitable configuration.
    1. [Create a {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) in any suitable configuration with publicly available hosts and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`.

    1. If using security groups in your cluster, make sure they are configured correctly and allow connecting to the [{{ mch-name }}](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) cluster.

    1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) named `ydb-account` with the `ydb.editor` role. The transfer will use it to access the database.

- Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [ydb-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-ydb-to-clickhouse/blob/main/ydb-to-clickhouse.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) and rules required to connect to the {{ mch-name }} cluster from the internet.
        * {{ ydb-name }} database.
        * {{ mch-name }} target cluster.
        * Source endpoint.
        * Target endpoint.
        * Transfer.

    1. In the `ydb-to-clickhouse.tf` file, specify the following parameters:

        * `mch_version`: {{ CH }} version.
        * `mch_password`: User password of the {{ CH }} database owner.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

1. [Connect to the {{ ydb-name }} database](../../../ydb/operations/connection.md).
1. [Create a row-oriented table](../../../ydb/operations/schema.md#create-table) named `table1` with the following columns:

    | {{ ui-key.yacloud.ydb.browse.info.column_name }} | {{ ui-key.yacloud.ydb.browse.info.column_type }} | {{ ui-key.yacloud.ydb.table.form.column_primary-key }} |
    |:-------|:--------|:-------|
    | `Id`   | `Int64` | Yes     |
    | `Name` | `Utf8`  |        |

    You can create a table [using the following SQL query](../../../ydb/operations/crud.md#web-sql):

    ```sql
    CREATE TABLE table1 (
        Id Int64,
        Name Utf8,
        PRIMARY KEY (Id)
    )
    ```

1. [Populate the table with data](../../../ydb/operations/crud.md#change-data) using the following SQL query:

    ```sql
    INSERT INTO table1 (Id, Name)
    VALUES
        (1, "Anna"),
        (2, "Robert"),
        (3, "Umar"),
        (4, "Algul"),
        (5, "Viktor");
    ```

## Prepare and activate the transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/ydb.md#endpoint-settings) of the `{{ ydb-short-name }}` type and specify the DB connection parameters in it:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} database from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select the `ydb-account` service account.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**: Specify `table1`.

    1. [Create a target endpoint](../../../data-transfer/operations/endpoint/target/clickhouse.md#endpoint-settings) of the `{{ CH }}` type and specify the cluster connection parameters in it:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}**: `<{{ CH }}_target_cluster_name>` from the drop-down list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}**: `user1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}**: `<user_password>`.

    1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.

    1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

- Using {{ TF }} {#tf}

    1. In the `ydb-to-clickhouse.tf` file, set the `transfer_enabled` parameter to `1`.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Once created, your transfer will be activated automatically.

{% endlist %}

## Test the transfer {#verify-transfer}

Check the transfer performance by testing the copy and replication processes.

### Test the copy process {#verify-copy}

1. [Connect to the `db1` database](../../../managed-clickhouse/operations/connect/clients.md) in the target {{ mch-name }} cluster.

1. Run the following query:

    ```sql
    SELECT * FROM db1.table1;
    ```

    {% cut "Response example" %}

    ```sql
    # | Id  | Name     | __data_transfer_commit_time | __data_transfer_delete_time
    --+-----+----------+-----------------------------+----------------------------
    1 | "1" | "Anna"   | "1722023098109014844"       | "0"
    2 | "2" | "Robert" | "1722023098109014844"       | "0"
    3 | "3" | "Umar"   | "1722023098109014844"       | "0"
    4 | "4" | "Algul"  | "1722023098109014844"       | "0"
    5 | "5" | "Viktor" | "1722023098109014844"       | "0"
    ```

    {% endcut %}

### Test the replication process {#verify-replication}

1. [Connect to the {{ ydb-name }} database](../../../ydb/operations/connection.md).

1. [Add data to the table](../../../ydb/operations/crud.md#change-data) named `table1`:

    ```sql
    INSERT INTO table1 (Id, Name)
    VALUES
        (6, "Maria"),
        (7, "Alex");
    ```

1. Make sure the new data has been added to the target database:

   1. [Connect to the `db1` database](../../../managed-clickhouse/operations/connect/clients.md) in the target {{ mch-name }} cluster.

    1. Run the following query:

        ```sql
        SELECT * FROM db1.table1;
        ```

        {% cut "Response example" %}

        ```sql
        # | Id  | Name     | __data_transfer_commit_time | __data_transfer_delete_time
        --+-----+----------+-----------------------------+----------------------------
        1 | "1" | "Anna"   | "1722023098109014844"       | "0"
        2 | "2" | "Robert" | "1722023098109014844"       | "0"
        3 | "3" | "Umar"   | "1722023098109014844"       | "0"
        4 | "4" | "Algul"  | "1722023098109014844"       | "0"
        5 | "5" | "Viktor" | "1722023098109014844"       | "0"
        6 | "6" | "Maria"  | "1722023655224000000"       | "0"
        7 | "7" | "Alex"   | "1722023655225000000"       | "0"
        ```

        {% endcut %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
    * [Delete endpoints](../../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
    * [Delete the {{ ydb-name }} database](../../../ydb/operations/manage-databases.md#delete-db).
    * [Delete the {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-delete.md).
    * [Delete the service account](../../../iam/operations/sa/delete.md).

- Using {{ TF }} {#tf}

    1. In the terminal window, go to the directory containing the infrastructure plan.
    1. Delete the `ydb-to-clickhouse.tf` configuration file.
    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Confirm updating the resources.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        All the resources described in the `ydb-to-clickhouse.tf` configuration file will be deleted.

{% endlist %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}