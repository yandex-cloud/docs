

You can track data changes in a {{ mmy-name }} _source cluster_ and send them to a {{ yds-name }} _target cluster_ using [Change Data Capture](../../../data-transfer/concepts/cdc.md) (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Set up your transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#check-replication).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mmy-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mmy-name }} pricing](../../../managed-mysql/pricing.md)).
* Per-transfer fee: Using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Fee for the {{ ydb-name }} database. The charge depends on the usage mode:

	* For the serverless mode, you pay for data operations and the amount of stored data.
	* For dedicated instance mode, you pay for the use of computing resources, dedicated DBs, and disk space.
	
    Learn more about the [{{ ydb-name }} pricing](../../../ydb/pricing/index.md) plans.

* Fee for {{ yds-name }}. The fee depends on the pricing mode:

	* Based on allocated resources: You pay for the number of units of written data and resources allocated for data streaming.
	* By actual use:
		* If the DB operates in serverless mode, the data stream is charged according to the [{{ ydb-short-name }} serverless mode pricing policy](../../../ydb/pricing/serverless.md).

		* If the DB operates in dedicated instance mode, the data stream is not charged separately (you only pay for the DB, see the [pricing policy](../../../ydb/pricing/dedicated)).

    Learn more about the [{{ yds-name }} pricing](../../../data-streams/pricing.md) plans.


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mmy-name }} source cluster](../../../managed-mysql/operations/cluster-create.md) in any applicable [configuration](../../../managed-mysql/concepts/instance-types.md) with publicly available hosts and the following settings:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mmy-user`

    1. [Grant the user](../../../managed-mysql/concepts/settings-list#setting-administrative-privileges) the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges.

    
    1. Set up [security groups](../../../managed-mysql/operations/connect.md#configure-security-groups) and make sure they allow cluster connections.


    1. [Create a {{ ydb-name }} database](../../../ydb/operations/manage-databases.md#create-db) named `ydb-example` in any suitable configuration.

    1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) named `yds-sa` with the `yds.editor` role. The transfer will use it to access {{ yds-name }}.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [mysql-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-mysql-to-yds/blob/main/mysql-yds.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) required to connect to a cluster.
        * {{ mmy-name }} source cluster.
        * Database: {{ ydb-name }}.
        * Service account to use to access {{ yds-name }}.
        * Source endpoint.
        * Transfer.

    1. In the `mysql-yds.tf` file, specify the {{ MY }} user password.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up your transfer {#prepare-transfer}

1. [Create a {{ yds-name }} data stream](../../../data-streams/operations/aws-cli/create.md) named `mpg-stream`.

1. [Connect to the {{ mmy-name }} cluster](../../../managed-mysql/operations/connect.md), create a table named `measurements` in the `db1` database and populate it with data:

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
    INSERT INTO measurements VALUES
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/target/data-streams.md) of the `{{ yds-name }}` type with the following settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: `ydb-example`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: `mpg-stream`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: `yds-sa`

1. Create a source endpoint and transfer.

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/mysql.md) of the `{{ MY }}` type and specify these cluster connection settings in it:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}**: `<source_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: `mmy-user`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: `mmy-user` user password.

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.

    - {{ TF }} {#tf}

        1. In the `mysql-yds.tf` file, specify these variables:

            * `yds_endpoint_id`: ID of the target endpoint.
            * `transfer_enabled`: `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to _{{ dt-status-repl }}_.

{% include [get-yds-data](../../../_includes/data-transfer/get-yds-data.md) %}

## Test the replication process {#check-replication}

1. Connect to the source cluster.
1. Add a new row to the `measurements` table:

    ```sql
    INSERT INTO measurements VALUES
        ('ad02l5ck6sdt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 19, 45);
    ```

1. Make sure the new row is shown in the {{ yds-name }} stream.

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../../../_includes/mdb/note-before-delete-resources.md) %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the {{ yds-name }} stream](../../../data-streams/operations/manage-streams.md#delete-data-stream).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
    * [{{ mmy-name }}](../../../managed-mysql/operations/cluster-delete.md).
    * [{{ ydb-name }} database](../../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
