# {{ ydb-short-name }} change data capture and delivery to {{ DS }}

A {{ yds-name }} stream can get data from {{ ydb-name }} databases in real time using the [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC) technology.

{% include [CDC-YDB](../../_includes/data-transfer/note-ydb-cdc.md) %}

To set up CDC using {{ data-transfer-name }}:

1. [Prepare the {{ ydb-name }} source database](#prepare-source-ydb).
1. [Create a stream for the {{ yds-name }} target](#create-target-yds).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a {{ ydb-name }} source database](../../ydb/operations/manage-databases.md) in any suitable configuration.

   1. If you selected {{ dd }} DB mode for the source, [create](../../vpc/operations/security-group-create.md) and [configure](../../ydb/operations/connection.md#configuring-security-groups) a security group in the network hosting the DB.

   1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration for the {{ yds-name }} target stream.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [data-transfer-ydb-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-yds/blob/main/data-transfer-ydb-yds.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and the rule required to connect to the {{ ydb-name }} database.
      * {{ ydb-name }} source database.
      * {{ ydb-name }} database for the target stream.
      * Transfer.

   1. In the `data-transfer-ydb-yds.tf` file, specify the variables:

      * `source_db_name`: {{ ydb-name }} source database name.
      * `target_db_name`: {{ ydb-name }} database name for the target stream.
      * `transfer_enabled`: Set `0` to ensure that no transfer is created before you [create endpoints](#prepare-transfer).

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the {{ ydb-name }} source database {#prepare-source-ydb}

1. Get ready for running SQL queries in the {{ ydb-name }} source database:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with the DB you need.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
      1. Select the database from the list and go to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
      1. Click **{{ ui-key.yacloud.ydb.browse.button_sql-query }}**.

   - {{ ydb-short-name }} CLI {#cli}

      1. [Set up a connection to the {{ ydb-name }} database](../../ydb/operations/connection.md).
      1. Make sure you can run queries using the {{ ydb-short-name }} CLI with the selected authentication mode. For example, for an [OAuth token](../../iam/concepts/authorization/oauth-token.md), run the following query:

         ```bash
         ydb \
           --endpoint <endpoint> \
           --database <name> \
           --yc-token-file <path> \
           yql -s "SELECT 1;"
         ```

         Result:

         ```text
         ┌─────────┐
         | column0 |
         ├─────────┤
         | 1       |
         └─────────┘
         ```

   {% endlist %}

1. [Create a table](../../ydb/operations/schema.md#create-table) for test data:

   ```sql
   CREATE TABLE test
   (
       id Uint64,
       text Utf8,
       PRIMARY KEY (id)
   );
   ```

## Create a stream for the {{ yds-name }} target {#create-target-yds}

[Create a stream for the {{ yds-name }} target](../../data-streams/operations/aws-cli/create.md).

## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`YDB` source](../../data-transfer/operations/endpoint/source/ydb.md):

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} database from the list.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select or create a service account with the `ydb.editor` role.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.array_item_label }} 1**: `test`.

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`{{ yds-full-name }}` target](../../data-transfer/operations/endpoint/target/data-streams.md):

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTarget.connection.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select the {{ ydb-name }} database for the target stream from the list.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the {{ yds-name }} data stream.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select or create a service account with the `yds.editor` role.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}`.

1. Create a transfer:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   - {{ TF }} {#tf}

      1. In the `data-transfer-ydb-yds.tf` file, specify the variables:

         * `source_endpoint_id`: ID of the source endpoint.
         * `target_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set `1` to enable transfer creation.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, your transfer will be activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. [Insert the test data](../../ydb/operations/crud.md) into the `test` table in the {{ ydb-name }} source database:

   ```sql
   INSERT INTO test
   (
       id,
       text
   )
   VALUES
   (
       1,
       'text 1'
   ),
   (
       2,
       'text 2'
   ),
   (
       3,
       'text 3'
   );
   ```

{% include [get-yds-data](../../_includes/data-transfer/get-yds-data.md) %}

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../../_includes/mdb/note-before-delete-resources.md) %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
1. If you created the service accounts along with the endpoints, [delete them](../../iam/operations/sa/delete.md).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ ydb-name }} source database](../../ydb/operations/manage-databases.md#delete-db).
   1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db) used for the target stream.

- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-ydb-yds.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-ydb-yds.tf` configuration file will be deleted.

{% endlist %}
