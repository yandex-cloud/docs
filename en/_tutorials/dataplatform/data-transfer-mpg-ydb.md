# Delivering data from {{ mpg-full-name }} to {{ ydb-full-name }}

A {{ ydb-name }} cluster can get data from {{ PG }} databases in real time. This data is automatically added to {{ ydb-short-name }} tables with names of source schemas and tables.

To run data delivery:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need these resources, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the data transfer infrastructure:

{% list tabs %}

* Manually

   1. [Create a source {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) in any applicable configuration with publicly available hosts.
   1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.
   1. [In the source cluster, create a user](../../managed-postgresql/operations/cluster-users.md#adduser) and [assign to them](../../managed-postgresql/operations/grant.md) the `mdb_replication` role.

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [data-transfer-mpg-ydb.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mpg-ydb.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mpg-name }} cluster.
      * {{ mpg-name }} source cluster.
      * {{ PG }} database.
      * {{ mpg-name }} user.
      * {{ ydb-name }} database.
      * Source endpoint.
      * Transfer.

   1. In the `data-transfer-mpg-ydb.tf` file, specify the values of parameters:

      * `source_pg_version`: {{ PG }} version in the source cluster.
      * `source_db_name`: DB name in the source cluster.
      * `source_user_name`: Username for establishing a connection to the source cluster.
      * `source_user_password`: User password.
      * `target_db_name`: {{ ydb-name }} database name.
      * `transfer_enabled`: Set `0` to ensure that no transfer and source endpoint is created before you [manually create a target endpoint](#prepare-transfer).

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the source cluster {#prepare-source}

1. [Connect to the database](../../managed-postgresql/operations/connect.md) of the source cluster on behalf of the new user.
1. Add test data to the database. In this example, a simple table with information from car sensors is used.

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
       ('iv9a94th6rztooxh5ur2', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
       ('rhibbh3y08qmz3sdbrbu', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
       ('iv9a94th678tooxh5ur2', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
   ```

1. [Prepare the source cluster for transfer](../../data-transfer/operations/prepare.md#source-pg).

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **Database type**: `YDB`.
   * **Endpoint parameters**:

      * **Connection settings**:
         * **Database**: Select a {{ ydb-name }} database from the list.
         * **Service account ID**: Select or create a service account with the `ydb.editor` role.

1. Create a source endpoint and transfer:

   {% list tabs %}

   * Manually

      1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [previously created](#before-you-begin) {{ PG }} source with the [following settings](../../data-transfer/operations/endpoint/source/postgresql.md):

         * **DB type**: `PostgreSQL`.
         * **Endpoint parameters**:
            * **Connection settings**: `MDB cluster`.
            * **MDB cluster**: {{ mpg-name }} cluster that you created.
            * **Database name**: Name of the database created in the {{ mpg-name }} cluster.
            * **Username**: Name of the user created in the {{ mpg-name }} cluster.
            * **Password**: Password of the user.
            * **List of included tables**: `<DB name>.sensors`.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the {{ dt-type-copy-repl }} type that will use the created endpoints.
      1. [Enable](../../data-transfer/operations/transfer.md#activate) the transfer.

   * Using {{ TF }}

      1. In the `data-transfer-mpg-ydb.tf` file, specify the values of parameters:

         * `target_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: For creating a source endpoint and a transfer, the value is `1`.

      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, a transfer is activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Make sure that the data from the source {{ mpg-name }} cluster has been moved to the {{ ydb-name }} database:

   {% list tabs %}

   * Management console

      1. In the [management console]({{ link-console-main }}), select the folder with the desired DB.
      1. In the list of services, select **{{ ydb-name }}**.
      1. Select the database from the list.
      1. Go to the **Navigation** tab.
      1. Check that the {{ ydb-name }} database contains the `public_sensors` table with the test data.

   * {{ ydb-short-name }} CLI

      1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
      1. Check that the database contains the `public_sensors` table with the test data:

         ```bash
         ydb table query execute \
           --query "SELECT * \
           FROM public_sensors"
         ```

   {% endlist %}

1. [Connect to the {{ mpg-name }} source cluster](../../managed-postgresql/operations/connect.md) and add data to the `measurements` table:

   ```sql
   INSERT INTO public.sensors VALUES
       ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
   ```

1. Check that the {{ ydb-name }} database shows information about the row added:

   {% list tabs %}

   * Management console

      1. In the [management console]({{ link-console-main }}), select the folder with the desired DB.
      1. In the list of services, select **{{ ydb-name }}**.
      1. Select the database from the list.
      1. Go to the **Navigation** tab.
      1. Check that new data has been added to the `public_sensors` table.

   * {{ ydb-short-name }} CLI

      1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
      1. Check that new data has been added to the `public_sensors` table:

         ```bash
         ydb table query execute \
           --query "SELECT * \
           FROM public_sensors"
         ```

   {% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs %}

* Manually

   1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) and [delete](../../data-transfer/operations/transfer.md#delete) the transfer.
   1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for the source and target.
   1. If you created the service account along with the target endpoint, [delete it](../../iam/operations/sa/delete.md).
   1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
   1. [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

* Using {{ TF }}

   1. In the terminal, go to the working directory that includes the `data-transfer-mpg-ydb.tf` configuration file.
   1. Delete resources using this command:

      ```bash
      terraform destroy
      ```

   1. Type `yes` and press **Enter**.

      All the resources described in the `data-transfer-mpg-ydb.tf` configuration file will be deleted.

{% endlist %}
