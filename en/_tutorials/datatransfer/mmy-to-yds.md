You can set up asynchronous replication of data from {{ mmy-full-name }} to {{ yds-full-name }} using {{ data-transfer-full-name }}. To do this:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#check-replication).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

- Manually

   1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) in any suitable [configuration](../../managed-mysql/concepts/instance-types.md) with publicly available hosts and the following settings:
      * Database name: `db1`.
      * Username: `mmy-user`.
      * Password: `<user password>`.

   1. [Grant the user](../../managed-mysql/concepts/settings-list#setting-administrative-privileges) the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges.

   
   1. Set up [security groups](../../managed-mysql/operations/connect.md#configure-security-groups) and make sure they allow cluster connections.

      {% include [preview-pp.md](../../_includes/preview-pp.md) %}


   1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md#create-db) named `ydb-example` in any suitable configuration.

   1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `yds-sa` with the `yds.editor` role. The transfer will use it to access {{ yds-name }}.

- Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [mysql-yds.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/mysql-yds.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network)
      * [Subnet](../../vpc/concepts/network.md#subnet)
      * [Security group](../../vpc/concepts/security-groups.md) required to connect to a cluster
      * {{ mmy-name }} source cluster
      * {{ ydb-name }} database
      * Service account to use to access {{ yds-name }}
      * Source endpoint
      * Transfer

   1. In the `mysql-yds.tf` file, specify the {{ MY }} user password.

   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Create a {{ yds-name }} data stream](../../data-streams/operations/aws-cli/create.md) named `mpg-stream`.

1. [Connect to the {{ mmy-name }} cluster](../../managed-mysql/operations/connect.md), create a table named `measurements` in the `db1` database, and populate it with data:

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
       ('iv9a94th6rztooxh5ur2', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
       ('rhibbh3y08qmz3sdbrbu', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
   ```

1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/data-streams.md) of the `{{ yds-name }}` type with the following settings:

   * Database: `ydb-example`.
   * Stream: `mpg-stream`.
   * Service account: `yds-sa`.

1. Create a source endpoint and a transfer.

   {% list tabs %}

   - Manually

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/mysql.md) of the `{{ MY }}` type and specify the cluster connection parameters in it:

         * **Connection type**: `Managed Service for MySQL cluster`.
         * **Cluster**: `<{{ MY }} source cluster name>` from the drop-down list.
         * **Database**: `db1`.
         * **User**: `mmy-user`.
         * **Password**: `<user password>`.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a _{{ dt-type-copy-repl }}_ type that will use the created endpoints.

   - Using {{ TF }}

      1. In the `mysql-yds.tf` file, specify the following variables:

         * `yds_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set `1` to enable transfer creation.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to _{{ dt-status-repl }}_.

{% include [get-yds-data](../../_includes/data-transfer/get-yds-data.md) %}

## Test the replication process {#check-replication}

1. Connect to the source cluster.
1. Add a new row to the `measurements` table:

   ```sql
   INSERT INTO measurements VALUES
       ('ad02l5ck6sdtrh7ks4hj', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 19, 45);
   ```

1. Make sure the new row is shown in the {{ yds-name }} stream.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [Deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate) and wait for its status to change to _{{ dt-status-stopped }}_.
* [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
* [Delete the {{ yds-name }} stream](../../data-streams/operations/manage-streams.md#delete-data-stream).
* Delete the transfer, the source endpoint, the {{ mmy-name }} cluster, and the {{ ydb-name }} database:

   {% list tabs %}

   * Manually

      * [Transfer](../../data-transfer/operations/transfer.md#delete).
      * [Source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
      * [{{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
      * [{{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).

   * Using {{ TF }}

      1. In the terminal window, switch to the directory containing the infrastructure plan.
      1. Delete the `mysql-yds.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the resources have been updated:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `mysql-yds.tf` configuration file will be deleted.

   {% endlist %}
