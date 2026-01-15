

You can track data changes in a {{ mpg-name }} _source cluster_ and send them to a {{ yds-name }} _target cluster_ using [change data capture](../../../data-transfer/concepts/cdc.md) (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Set up your transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test replication](#check-replication).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mpg-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../../ydb/pricing/index.md)). The cost depends on deployment mode:

    * In serverless mode, you pay for data operations and storage volume, including stored backups.
    * In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.

* {{ yds-name }} (see [{{ yds-name }} pricing](../../../data-streams/pricing.md)). The cost depends on the pricing model:

    * [Based on allocated resources](../../../data-streams/pricing.md#rules): You pay a fixed hourly rate for the established throughput limit and message retention period, and additionally for the number of units of actually written data.
    * [On-demand](../../../data-streams/pricing.md#on-demand): You pay for the performed read/write operations, the amount of read or written data, and the actual storage used for messages that are still within their retention period.


## Getting started {#before-you-begin}

Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mpg-name }} source cluster](../../../managed-postgresql/operations/cluster-create.md) using any suitable [configuration](../../../managed-postgresql/concepts/instance-types.md) with publicly accessible hosts. Specify the following settings:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`

    
    1. Configure [security groups](../../../managed-postgresql/operations/connect.md#configuring-security-groups), ensuring they allow cluster connections.


    1. [Grant](../../../managed-postgresql/operations/grant.md#grant-privilege) the `mdb_replication` role to `pg-user`.

    1. [Create a {{ ydb-name }} database](../../../ydb/operations/manage-databases.md#create-db) `ydb-example` with your preferred configuration.

    1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) `yds-sa` with the `yds.editor` role. The transfer will use it to access {{ yds-name }}.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [postgresql-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-postgresql-to-yds/blob/main/postgresql-yds.tf) configuration file to your current working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) required for cluster access.
        * {{ mpg-name }} source cluster.
        * {{ ydb-name }} database.
        * Service account that will be used to access {{ yds-name }}.
        * Source endpoint.
        * Transfer.

    1. In the `postgresql-yds.tf` file, specify the {{ PG }} user password.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up your transfer {#prepare-transfer}

1. [Create a data stream `mpg-stream` in {{ yds-name }}](../../../data-streams/operations/aws-cli/create.md).

1. [Connect to the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect.md). In the `db1` database, create a table named `measurements` and populate it with data:

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

1. [Create a `{{ yds-name }}` target endpoint](../../../data-transfer/operations/endpoint/target/data-streams.md) with the following settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: `ydb-example`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: `mpg-stream`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: `yds-sa`

1. Create a source endpoint and set up the transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a `{{ PG }}`-type source endpoint](../../../data-transfer/operations/endpoint/source/postgresql.md) and configure it using the following settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }}_source_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `pg-user` password.

        1. [Create](../../../data-transfer/operations/transfer.md#create) a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**-type transfer configured to use the new endpoints.

    - {{ TF }} {#tf}

        1. In the `postgresql-yds.tf` file, specify the following variables:

            * `yds_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}_**.

1. {% include [get-yds-data](../../../_includes/data-transfer/get-yds-data.md) %}

## Test replication {#check-replication}

1. Connect to the source cluster.
1. Add a new row to the `measurements` table:

    ```sql
    INSERT INTO measurements VALUES
        ('ad02l5ck6sdt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 19, 45);
    ```

1. Verify that the new row has appeared in the data stream.

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../../../_includes/mdb/note-before-delete-resources.md) %}

To reduce the consumption of resources you do not need, delete them:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the {{ yds-name }} stream](../../../data-streams/operations/manage-streams.md#delete-data-stream).
1. Delete other resources using the same method used for their creation:

   {% list tabs group=instructions %}

   - Manually {#manual}

       1. [Delete the source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
       1. [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).
       1. [Delete the {{ ydb-name }} database](../../../ydb/operations/manage-databases.md#delete-db).

   - {{ TF }} {#tf}

       {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
