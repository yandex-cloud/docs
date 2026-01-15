# Delivering data from {{ mpg-full-name }} to {{ ydb-full-name }}


{{ ydb-name }} clusters support real-time data ingestion from {{ PG }} databases. The system will automatically insert this data into {{ ydb-short-name }} tables named after the original schemas and tables.

To start data delivery:

1. [Set up the source cluster](#prepare-source).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mpg-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../ydb/pricing/index.md)). The cost depends on deployment mode:

	* In serverless mode, you pay for data operations and storage volume, including stored backups.
  	* In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.


## Getting started {#before-you-begin}

Set up your data delivery infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mpg-name }} source cluster](../../managed-postgresql/operations/cluster-create.md) using any suitable configuration with publicly accessible hosts.
    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) with your preferred configuration.
    1. [In the source cluster, create a user](../../managed-postgresql/operations/cluster-users.md#adduser) and [assign them](../../managed-postgresql/operations/grant.md) the `mdb_replication` role.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-transfer-mpg-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-ydb/blob/main/data-transfer-mpg-ydb.tf) configuration file to your current working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and the rule required for connecting to the {{ mpg-name }} cluster.
        * {{ mpg-name }} source cluster.
        * {{ PG }} database.
        * {{ mpg-name }} user.
        * {{ ydb-name }} database.
        * Source endpoint.
        * Transfer.

    1. In the `data-transfer-mpg-ydb.tf` file, specify the following settings:

        * `source_pg_version`: {{ PG }} version in the source cluster.
        * `source_db_name`: Database name in the source cluster.
        * `source_user_name`: Username for connecting to the source cluster.
        * `source_user_password`: User password.
        * `target_db_name`: {{ ydb-name }} database name.
        * `transfer_enabled`: Set to `0` to prevent the automatic creation of a source endpoint and transfer before you [manually create a target endpoint](#prepare-transfer).

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

1. [Connect to the source cluster’s database](../../managed-postgresql/operations/connect.md) with your new user account.
1. Populate the database with test data. In this example, we will use a simple table with car sensor information.

    Create a table:

    ```sql
    CREATE TABLE public.sensors (
        "device_id" text PRIMARY KEY NOT NULL,
        "datetime" timestamp NOT NULL,
        "latitude" real NOT NULL,
        "longitude" real NOT NULL,
        "altitude" real NOT NULL,
        "speed" real NOT NULL,
        "battery_voltage" real,
        "cabin_temperature" real NOT NULL,
        "fuel_level" real
    );
    ```

    Populate the table with data:

    ```sql
    INSERT INTO public.sensors VALUES
        ('iv9a94th6rzt********', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th678t********', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

1. [Prepare the source cluster for transfer](../../data-transfer/operations/prepare.md#source-pg).

## Set up and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `YDB`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.connection.title }}**:
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select your {{ ydb-name }} database from the list.

            

           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select an existing service account or create a new one with the `ydb.editor` role.


1. Create a source endpoint and transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [previously created](#before-you-begin) {{ PG }} source with the [following settings](../../data-transfer/operations/endpoint/source/postgresql.md):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}**:
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: {{ mpg-name }} cluster you created earlier.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Name of the database you created in the {{ mpg-name }} cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: Name of the user you created in the {{ mpg-name }} cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: User password.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}**: `<DB_name>.sensors`.

        1. [Create](../../data-transfer/operations/transfer.md#create) a **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}**-type transfer configured to use the new endpoints.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `data-transfer-mpg-ydb.tf` file, specify the following settings:

            * `target_endpoint_id`: ID of the target endpoint.
            * `transfer_enabled`: `1` to create a source endpoint and a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            The transfer will activate automatically upon creation.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. Make sure that the data from the source {{ mpg-name }} cluster has been transferred to the {{ ydb-name }} database:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder containing your database.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Select your database from the list.
        1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
        1. Verify that the {{ ydb-name }} database contains the `public_sensors` table with test data.

    * {{ ydb-short-name }} CLI

        1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
        1. Verify that the database contains the `public_sensors` table with test data:

            ```bash
            ydb table query execute \
              --query "SELECT * \
              FROM public_sensors"
            ```

    {% endlist %}

1. [Connect to the {{ mpg-name }} source cluster](../../managed-postgresql/operations/connect.md) and populate the `sensors` table with data:

    ```sql
    INSERT INTO public.sensors VALUES
        ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Verify that the added row’s details have appeared in the {{ ydb-name }} database:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder containing your database.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Select your database from the list.
        1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
        1. Verify that the new data has been added to the `public_sensors` table.

    - {{ ydb-short-name }} CLI {#cli}

        1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
        1. Verify that the new data has been added to the `public_sensors` table.

            ```bash
            ydb table query execute \
              --query "SELECT * \
              FROM public_sensors"
            ```

    {% endlist %}

## Delete the resources you created {#clear-out}

To reduce the consumption of resources you do not need, delete them:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) and [delete](../../data-transfer/operations/transfer.md#delete) the transfer.
    1. [Delete source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).

    
    1. If you created a service account when setting up the target endpoint, [delete it](../../iam/operations/sa/delete.md).


    1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
    1. [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
