

You can set up a data transfer from a {{ mmy-name }} database to a {{ mpg-name }} database using {{ data-transfer-name }}. Proceed as follows:

1. [Prepare your test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mpg-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* {{ mmy-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

    1. [Create a {{ mmy-name }} source cluster](../../../managed-mysql/operations/cluster-create.md#create-cluster) in any [availability zone](../../../overview/concepts/geo-scope.md) with publicly available hosts in any suitable configuration and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `mmy_db`
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mmy_user`
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`

    1. [Grant](../../../managed-mysql/operations/grant.md#grant-privilege) the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges to `mmy_user`.

        For more information about administrative privileges, see the [settings description](../../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

    1. In the same availability zone, [create a {{ mpg-name }} target cluster](../../../managed-postgresql/operations/cluster-create.md#create-cluster) in any suitable configuration with publicly available hosts and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `mpg_db`
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mpg_user`
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<target_password>`

    1. Make sure the cluster security groups are configured correctly and allow inbound cluster connections:

        * [{{ mmy-name }}](../../../managed-mysql/operations/connect/index.md#configuring-security-groups)
        * [{{ mpg-name }}](../../../managed-postgresql/operations/connect.md#configuring-security-groups)

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [mysql-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-postgresql/blob/main/mysql-postgresql.tf) configuration file to your current working directory.

        This file describes:

        * [Networks](../../../vpc/concepts/network.md#network) and [subnets](../../../vpc/concepts/network.md#subnet) that will host your clusters.
        * [Security groups](../../../vpc/concepts/security-groups.md) for cluster access.
        * {{ mmy-name }} source cluster.
        * {{ mpg-name }} target cluster.
        * Source and target endpoints.
        * Transfer.

    1. In the `mysql-postgresql.tf` file, specify the following:

        * {{ MY }} and {{ PG }} versions.
        * {{ MY }} and {{ PG }} user passwords.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare your test data {#prepare-data}

1. [Connect to the database in the {{ mmy-name }} source cluster](../../../managed-mysql/operations/connect/index.md).

1. Populate the database with test data. In this example, we will use a simple table with car sensor information.

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

## Set up and activate the transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a `{{ MY }}` source endpoint](../../../data-transfer/operations/endpoint/source/mysql.md) with these cluster connection settings:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}**: `<{{ MY }}_source_cluster_name>` from the drop-down list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `mmy_db`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: `mmy_user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: `<user_password>`.

    1. [Create a `{{ PG }}` target endpoint](../../../data-transfer/operations/endpoint/target/postgresql.md) with these cluster connection settings:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }}_target_cluster_name>` from the drop-down list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `mpg_db`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `mpg_user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.

    1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**-type that will use the endpoints you created.
    1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

- {{ TF }} {#tf}

    1. In the `mysql-postgresql.tf` file, set `transfer_enabled` to `1`.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    1. The transfer will be activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

{% endlist %}

## Test your transfer {#verify-transfer}

Make sure the transfer works correctly by testing copying and replication.

### Test copying {#verify-copy}

1. [Connect to the {{ mpg-name }} target cluster database](../../../managed-postgresql/operations/connect.md).
1. Run this query:

    ```sql
    SELECT * FROM mmy_db.measurements;
    ```

### Test replication {#verify-replication}

1. [Connect to the database in the {{ mmy-name }} source cluster](../../../managed-mysql/operations/connect/index.md).
1. Populate the `measurements` table with data:

    ```sql
    INSERT INTO measurements VALUES
    ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Make sure the target database contains the row you added:

    1. [Connect to the {{ mpg-name }} target cluster database](../../../managed-postgresql/operations/connect.md).
    1. Run this query:

        ```sql
        SELECT * FROM mmy_db.measurements;
        ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources, delete those you do not need:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
    1. [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ mmy-name }} cluster](../../../managed-mysql/operations/cluster-delete.md).
    1. [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
