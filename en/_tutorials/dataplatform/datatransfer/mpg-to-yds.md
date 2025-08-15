

You can track data changes in a {{ mpg-name }} _source cluster_ and send them to a {{ yds-name }} _target cluster_ using [change data capture](../../../data-transfer/concepts/cdc.md) (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Set up your transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#check-replication).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mpg-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).

* {{ ydb-name }} database fee. The charge depends on the usage mode:

	* For the serverless mode, you pay for data operations and the amount of stored data.
	* For the dedicated instance mode, you pay for the use of computing resources, dedicated DBs, and disk space.
	
    Learn more about the {{ ydb-name }} pricing plans [here](../../../ydb/pricing/index.md).

* {{ yds-name }} fee, which depends on the pricing mode:

	* Provisioned capacity pricing mode: You pay for the number of write units and resources allocated for data streaming.
	* On-demand pricing mode:
		* If the DB operates in serverless mode, the data stream is charged according to the [{{ ydb-short-name }} serverless mode pricing policy](../../../ydb/pricing/serverless.md).

		* If the DB operates in dedicated instance mode, the data stream is not charged separately (you only pay for the DB, see the [pricing policy](../../../ydb/pricing/dedicated.md)).

    Learn more about the {{ yds-name }} pricing plans [here](../../../data-streams/pricing.md).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mpg-name }} source cluster](../../../managed-postgresql/operations/cluster-create.md) in any applicable [configuration](../../../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`

    
    1. Set up [security groups](../../../managed-postgresql/operations/connect.md#configuring-security-groups) and make sure they allow cluster connections.


    1. [Grant](../../../managed-postgresql/operations/grant.md#grant-privilege) the `mdb_replication` role to `pg-user`.

    1. [Create a {{ ydb-name }} database](../../../ydb/operations/manage-databases.md#create-db) named `ydb-example` in any suitable configuration.

    1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) named `yds-sa` with the `yds.editor` role. The transfer will use it to access {{ yds-name }}.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [postgresql-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-postgresql-to-yds/blob/main/postgresql-yds.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) required for cluster connection.
        * {{ mpg-name }} source cluster.
        * {{ ydb-name }} database.
        * Service account to use for {{ yds-name }} access.
        * Source endpoint.
        * Transfer.

    1. In `postgresql-yds.tf`, specify the {{ PG }} user password.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up your transfer {#prepare-transfer}

1. [Create a data stream in {{ yds-name }}](../../../data-streams/operations/aws-cli/create.md) named `mpg-stream`.

1. [Connect to the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect.md), create a table named `measurements` in the `db1` database, and populate it with data:

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

1. Create a source endpoint and transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify these cluster connection settings in it:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }}_source_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `pg-user` password.

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.

    - {{ TF }} {#tf}

        1. In the `postgresql-yds.tf` file, specify these variables:

            * `yds_endpoint_id`: ID of the target endpoint.
            * `transfer_enabled`: Set to `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will show any errors found in your configuration files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}_**.

1. {% include [get-yds-data](../../../_includes/data-transfer/get-yds-data.md) %}

## Test the replication process {#check-replication}

1. Connect to the source cluster.
1. Add a new row to the `measurements` table:

    ```sql
    INSERT INTO measurements VALUES
        ('ad02l5ck6sdt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 19, 45);
    ```

1. Make sure you can now see the new row in your data stream.

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../../../_includes/mdb/note-before-delete-resources.md) %}

Some resources are not free of charge. To avoid unnecessary charges, delete the resources you no longer need:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the stream in {{ yds-name }}](../../../data-streams/operations/manage-streams.md#delete-data-stream).

Delete the other resources depending on how you created them:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
    * [{{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
    * [{{ ydb-name }} database](../../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
