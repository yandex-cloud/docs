

You can track data changes in a {{ mpg-name }} _source cluster_ and send them to a {{ yds-name }} _target cluster_ using [Change Data Capture](../../../data-transfer/concepts/cdc.md) (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#check-replication).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a {{ mpg-name }} source cluster](../../../managed-postgresql/operations/cluster-create.md) in any suitable [configuration](../../../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`


   1. Set up [security groups](../../../managed-postgresql/operations/connect.md#configuring-security-groups) and make sure they allow cluster connections.


   1. [Grant](../../../managed-postgresql/operations/grant.md#grant-privilege) the `mdb_replication` role to the `pg-user`.

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
      * [Security group](../../../vpc/concepts/security-groups.md) required to connect to a cluster.
      * {{ mpg-name }} source cluster.
      * {{ ydb-name }} database.
      * Service account to use to access {{ yds-name }}.
      * Source endpoint.
      * Transfer.

   1. In the `postgresql-yds.tf` file, specify the {{ PG }} user password.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Create a {{ yds-name }} data stream](../../../data-streams/operations/aws-cli/create.md) named `mpg-stream`.

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

1. Create a source endpoint and a transfer.

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<name_of_{{ PG }}_source_cluster>` from the drop-down list
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: `db1`
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: `pg-user`
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: `pg-user` password

      1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.

   - {{ TF }} {#tf}

      1. In the `postgresql-yds.tf` file, specify the following variables:

         * `yds_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set to `1` to enable transfer creation.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

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
   * [{{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
   * [{{ ydb-name }} database](../../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `postgresql-yds.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `postgresql-yds.tf` configuration file will be deleted.

{% endlist %}
