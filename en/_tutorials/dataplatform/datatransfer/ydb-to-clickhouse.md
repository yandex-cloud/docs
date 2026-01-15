# Loading data from {{ ydb-full-name }} to {{ mch-full-name }} using {{ data-transfer-full-name }}


{{ data-transfer-name }} enables you to transfer data from a {{ ydb-name }} database to a {{ mch-name }} cluster.

To transfer data:

1. [Prepare the test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../../ydb/pricing/index.md)). Its pricing is based on deployment mode:

    * In serverless mode, you pay for data operations and storage volume, including stored backups.
    * In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.

* {{ mch-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../../ydb/operations/manage-databases.md) named `ydb1` with your preferred configuration.
    1. [Create a {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) of any suitable configuration with publicly accessible hosts and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`.

    1. If using security groups, make sure they are configured correctly and allow connections to your [{{ mch-name }}](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) cluster.

    
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
        * [Security group](../../../vpc/concepts/security-groups.md) and rules for internet access to the {{ mch-name }} cluster.
        * {{ ydb-name }} database.
        * Target {{ mch-name }} cluster.
        * Source endpoint.
        * Target endpoint.
        * Transfer.

    1. In the `ydb-to-clickhouse.tf` file, specify the following settings:

        * `mch_version`: {{ CH }} version.
        * `mch_password`: {{ CH }} database owner’s password.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

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

    You can create this table [using the following SQL query](../../../ydb/operations/crud.md#web-sql):

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

## Set up and activate the transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a `{{ ydb-short-name }}`-type source endpoint](../../../data-transfer/operations/endpoint/source/ydb.md#endpoint-settings) with the following database connection settings:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} database from the list.

            
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select the `ydb-account` service account.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**: `table1`.

    1. [Create a `{{ CH }}`-type target endpoint](../../../data-transfer/operations/endpoint/target/clickhouse.md#endpoint-settings) with the following cluster connection settings:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}**: `<{{ CH }}_target_cluster_name>` from the drop-down list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}**: `user1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}**: `<user_password>`.

    1. [Create](../../../data-transfer/operations/transfer.md#create) a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**-type transfer configured to use the new endpoints.

    1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

- Using {{ TF }} {#tf}

    1. In the `ydb-to-clickhouse.tf` file, set `transfer_enabled` to `1`.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        The transfer will activate automatically upon creation.

{% endlist %}

## Test your transfer {#verify-transfer}

Make sure the transfer works correctly by testing copying and replication.

### Test copying {#verify-copy}

1. [Connect](../../../managed-clickhouse/operations/connect/clients.md) to the `db1` database in the {{ mch-name }} target cluster.

1. Run this query:

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

### Test replication {#verify-replication}

1. [Connect to the {{ ydb-name }} database](../../../ydb/operations/connection.md).

1. [Add data to the table](../../../ydb/operations/crud.md#change-data) named `table1`:

    ```sql
    INSERT INTO table1 (Id, Name)
    VALUES
        (6, "Maria"),
        (7, "Alex");
    ```

1. Check that the data has been replicated to the target database:

    1. [Connect](../../../managed-clickhouse/operations/connect/clients.md) to the `db1` database in the {{ mch-name }} target cluster.

    1. Run this query:

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

Before deleting the resources, [deactivate the transfer](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources you do not need, delete them:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
    1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ ydb-name }} database](../../../ydb/operations/manage-databases.md#delete-db).
    1. [Delete the {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-delete.md).

    
    1. [Delete the service account](../../../iam/operations/sa/delete.md).


- Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
