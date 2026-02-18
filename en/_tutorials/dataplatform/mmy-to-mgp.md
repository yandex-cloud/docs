# Migrating data from {{ mmy-full-name }} to {{ mgp-full-name }} using {{ data-transfer-full-name }}

You can set up a data transfer from {{ mmy-name }} to {{ GP }} databases in {{ mgp-name }} using {{ data-transfer-name }}. Proceed as follows:

1. [Prepare your test data](#prepare-data).
1. [Create a database in the target cluster](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mmy-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* {{ mgp-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mgp-name }} pricing](../../managed-greenplum/pricing/index.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    {% include [public-access](../../_includes/mdb/note-public-access.md) %}

    1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md#create-cluster) in any [availability zone](../../overview/concepts/geo-scope.md) with publicly available hosts in any suitable configuration and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `mmy_db`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mmy_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`.

    1. [Grant](../../managed-mysql/operations/grant.md#grant-privilege) the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges to `mmy_user`.

        For more information about administrative privileges, see the [settings description](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

    1. In the same availability zone, [create a {{ GP }} target cluster](../../managed-greenplum/operations/cluster-create.md#create-cluster) in any suitable configuration with publicly available hosts and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mgp_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<target_password>`.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-datatransfer }}**: Enabled.

    1. Make sure the cluster security groups are configured correctly and allow inbound cluster connections:

        * [{{ mmy-name }}](../../managed-mysql/operations/connect/index.md#configure-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).

- Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [mmy-to-mgp.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-greenplum/blob/main/mmy-to-mgp.tf) configuration file to the same working directory.

        This file describes:

        * [Networks](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) that will host your clusters.
        * [Security groups](../../vpc/concepts/security-groups.md) for cluster access.
        * {{ mmy-name }} source cluster.
        * {{ GP }} target cluster in {{ mgp-name }}.
        * Source endpoint.
        * Transfer.

    1. In the `mmy-to-mgp.tf` file, specify the following:

        * {{ MY }} and {{ GP }} versions.
        * {{ MY }} and {{ GP }} user passwords.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare your test data {#prepare-data}

1. [Connect to the `mmy_db` database](../../managed-mysql/operations/connect/index.md) in the {{ mmy-name }} source cluster.

1. Create a simple table named `table1`:

    ```sql
    CREATE TABLE table1 (
    id int NOT NULL,
    name varchar (10),
    PRIMARY KEY (id)
    );
    ```

1. Populate the table with data:

    ```sql
    INSERT INTO table1 VALUES
    (1, 'Name1'),
    (2, 'Name2'),
    (3, 'Name3');
    ```

## Create a database in the target cluster {#prepare-data}

1. [Connect](../../managed-greenplum/operations/connect.md) to the `postgres` system database in the {{ GP }} target cluster as `mgp_user`.

1. Create a database named `mgp_db`:

    ```sql
    CREATE DATABASE mgp_db;
    ```

## Set up and activate the transfer {#prepare-transfer}

1. [Create a `{{ GP }}` target endpoint](../../data-transfer/operations/endpoint/target/greenplum.md) with these cluster connection settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: `<{{ GP }}_target_cluster_name>` from the drop-down list.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `mgp_db`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: `mgp_user`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: `<user_password>`.

1. Create a source endpoint and set up the transfer:

    {% list tabs group=instructions %}

    * Manually {#manual}

        1. [Create a `{{ MY }}` source endpoint](../../data-transfer/operations/endpoint/source/mysql.md) with these cluster connection settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}**: `<{{ MY }}_source_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `mmy_db`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: `mmy_user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: `<user_password>`.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**-type that will use the endpoints you created.

        1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - Using {{ TF }} {#tf}

        1. In the `mmy-to-mgp.tf` file, specify the following settings:

            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: Set to `1` to create a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        1. The transfer will be activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Test your transfer {#verify-transfer}

Make sure the transfer works correctly by testing copying and replication.

### Test copying {#verify-copy}

1. [Connect](../../managed-greenplum/operations/connect.md) to the `mgp_db` database in the {{ GP }} target cluster.

1. Run this query:

    ```sql
    SELECT * FROM mmy_db.table1;
    ```

### Test replication {#verify-replication}

1. [Connect to the `mmy_db` database](../../managed-mysql/operations/connect/index.md) in the {{ mmy-name }} source cluster.

1. Populate the `table1` table with data:

    ```sql
    INSERT INTO table1 VALUES
    (4, 'Name4');
    ```

1. Check that the added row appears in the target database:

    1. [Connect](../../managed-greenplum/operations/connect.md) to the `mgp_db` database in the {{ GP }} target cluster.
    1. Run this query:

        ```sql
        SELECT * FROM mmy_db.table1;
        ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources, delete those you do not need:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
    1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
    1. [Delete the {{ GP }} cluster](../../managed-greenplum/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
