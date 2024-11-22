

You can set up data transfer from {{ mmy-name }} to {{ mpg-name }} databases using {{ data-transfer-name }}. To do this:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mmy-name }} source cluster](../../../managed-mysql/operations/cluster-create.md#create-cluster) in any [availability zone](../../../overview/concepts/geo-scope.md) with publicly available hosts in any suitable configuration with the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `mmy_db`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mmy_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`.

    1. [Grant](../../../managed-mysql/operations/grant.md#grant-privilege) the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges to `mmy_user`.

        For more information about administrative privileges, see the [settings description](../../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

    1. In the same availability zone, [create a {{ mpg-name }} target cluster](../../../managed-postgresql/operations/cluster-create.md#create-cluster) in any suitable configuration with publicly available hosts and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `mpg_db`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mpg_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<target_password>`.

    1. Make sure that the cluster security groups are set up correctly and allow connecting to them:

        * [{{ mmy-name }}](../../../managed-mysql/operations/connect.md#configuring-security-groups).
        * [{{ mpg-name }}](../../../managed-postgresql/operations/connect.md#configuring-security-groups).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [mysql-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-postgresql/blob/main/mysql-postgresql.tf) configuration file to the same working directory.

        This file describes:

        * [Networks](../../../vpc/concepts/network.md#network) and [subnets](../../../vpc/concepts/network.md#subnet) for hosting the clusters.
        * [Security groups](../../../vpc/concepts/security-groups.md) for making cluster connections.
        * {{ mmy-name }} source cluster.
        * {{ mpg-name }} target cluster.
        * Source and target endpoints.
        * Transfer.

    1. Specify the following in the `mysql-postgresql.tf` file:

        * {{ MY }} and {{ PG }} versions
        * {{ MY }} and {{ PG }} user passwords

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

1. [Connect to the {{ mmy-name }} source cluster database](../../../managed-mysql/operations/connect.md).

1. Add test data to the database. As an example, we will use a simple table with information transmitted by car sensors.

    Create a table:

    ```sql
    CREATE TABLE measurements (
        device_id varchar(200) NOT NULL,
        datetime timestamp NOT NULL,
        latitude real NOT NULL,
        longitude real NOT NULL,
        altitude real NOT NULL,
        speed real NOT NULL,
        battery_voltage real,
        cabin_temperature real NOT NULL,
        fuel_level real,
        PRIMARY KEY (device_id)
    );
    ```

    Populate the table with data:

    ```sql
    INSERT INTO measurements VALUES
    ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
    ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Prepare and activate the transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/mysql.md) of the `{{ MY }}` type and specify the cluster connection parameters in it:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}**: `<{{ MY }}_source_cluster_name>` from the drop-down list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `mmy_db`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: `mmy_user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: `<user_password>`.

    1. [Create a target endpoint](../../../data-transfer/operations/endpoint/target/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }}_target_cluster_name>` from the drop-down list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `mpg_db`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `mpg_user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.

    1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.
    1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

- {{ TF }} {#tf}

    1. In the `mysql-postgresql.tf` file, set the `transfer_enabled` parameter to `1`.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    1. The transfer will be activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

{% endlist %}

## Test the transfer {#verify-transfer}

Check the transfer performance by testing the copy and replication processes.

### Test the copy process {#verify-copy}

1. [Connect to the {{ mpg-name }} target cluster database](../../../managed-postgresql/operations/connect.md).
1. Run the following query:

    ```sql
    SELECT * FROM mmy_db.measurements;
    ```

### Test the replication process {#verify-replication}

1. [Connect to the {{ mmy-name }} source cluster database](../../../managed-mysql/operations/connect.md).
1. Populate the `measurements` table with data:

    ```sql
    INSERT INTO measurements VALUES
    ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Make sure the new row has been added to the target database:

    1. [Connect to the {{ mpg-name }} target cluster database](../../../managed-postgresql/operations/connect.md).
    1. Run the following query:

        ```sql
        SELECT * FROM mmy_db.measurements;
        ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Transfer](../../../data-transfer/operations/transfer.md#delete)
    * [Endpoints](../../../data-transfer/operations/endpoint/index.md#delete)
    * [{{ mmy-name }} cluster](../../../managed-mysql/operations/cluster-delete.md)
    * [{{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md)

- {{ TF }} {#tf}

    If you created your resources using {{ TF }}:

    1. In the terminal window, go to the directory containing the infrastructure plan.
    1. Delete the `mysql-postgresql.tf` configuration file.
    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Confirm updating the resources.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        All the resources described in the `mysql-postgresql.tf` configuration file will be deleted.

{% endlist %}
