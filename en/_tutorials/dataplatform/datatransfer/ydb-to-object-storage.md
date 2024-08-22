# Loading data from {{ ydb-full-name }} to {{ objstorage-full-name }} using {{ data-transfer-full-name }}


You can migrate data from {{ ydb-name }} to {{ objstorage-name }} using {{ data-transfer-name }}. To do this:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a {{ ydb-name }} database](../../../ydb/operations/manage-databases.md) in any suitable configuration.

   1. [Create a {{ objstorage-name }} bucket](../../../storage/operations/buckets/create.md).

   1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) with the `storage.editor` and `ydb.editor` roles. The transfer will use it to access the database and bucket.

- Using {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [ydb-to-object-storage.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-ydb-to-object-storage/blob/main/ydb-to-object-storage.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../../vpc/concepts/network.md#network)..
      * [Subnet](../../../vpc/concepts/network.md#subnet)..
      * [Security group](../../../vpc/concepts/security-groups.md).
      * Service account with the `storage.editor` and `ydb.editor` roles.
      * {{ objstorage-name }} target bucket.
      * Endpoints.
      * Transfer.

   1. In the `ydb-to-object-storage.tf` file, specify:
      * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
      * `bucket_name`: Bucket name consistent with the [naming conventions](../../../storage/concepts/bucket.md#naming).

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

1. In the {{ ydb-name }} database, [create](../../../ydb/operations/crud.md/#web-sql) the `seasons` table:

   ```sql
   CREATE TABLE seasons
   (
       series_id Uint64,
       season_id Uint64,
       title Utf8,
       first_aired Uint64,
       last_aired Uint64,
       PRIMARY KEY (series_id, season_id)
   );

   COMMIT;
   ```
1. Populate the table with data:

   ```sql
   REPLACE INTO seasons (series_id, season_id, title, first_aired, last_aired)
   VALUES
       (1, 1, "Season 1", CAST(Date("2006-02-03") AS Uint64), CAST(Date("2006-03-03") AS Uint64)),
       (1, 2, "Season 2", CAST(Date("2007-08-24") AS Uint64), CAST(Date("2007-09-28") AS Uint64)),
       (1, 3, "Season 3", CAST(Date("2008-11-21") AS Uint64), CAST(Date("2008-12-26") AS Uint64)),
       (1, 4, "Season 4", CAST(Date("2010-06-25") AS Uint64), CAST(Date("2010-07-30") AS Uint64)),
       (2, 1, "Season 1", CAST(Date("2014-04-06") AS Uint64), CAST(Date("2014-06-01") AS Uint64)),
       (2, 2, "Season 2", CAST(Date("2015-04-12") AS Uint64), CAST(Date("2015-06-14") AS Uint64)),
       (2, 3, "Season 3", CAST(Date("2016-04-24") AS Uint64), CAST(Date("2016-06-26") AS Uint64)),
       (2, 4, "Season 4", CAST(Date("2017-04-23") AS Uint64), CAST(Date("2017-06-25") AS Uint64)),
       (2, 5, "Season 5", CAST(Date("2018-03-25") AS Uint64), CAST(Date("2018-05-13") AS Uint64));

   COMMIT;
   ```

## Prepare and activate the transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a target endpoint](../../../data-transfer/operations/endpoint/target/object-storage.md) of the `{{ objstorage-name }}` type with the following settings:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: `<name_of_previously_created_bucket>`
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: `<previously_created_service_account_name>`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}**: `UNCOMPRESSED`
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}**: `from_YDB`.

   1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/ydb.md) of the `{{ ydb-short-name }}` type and specify the DB connection parameters in it:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-short-name }} database from the list.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select the service account you previously created.

   1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** type that will use the created endpoints.

   1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

- {{ TF }} {#tf}

   1. In the `ydb-to-object-storage.tf` file, specify the following variables:

      * `target_endpoint_id`: ID of the target endpoint.
      * `source_endpoint_id`: ID of the source endpoint.
      * `transfer_enabled`: Set to `1` to enable transfer creation.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

   1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

{% endlist %}

## Test the transfer {#verify-transfer}

Make sure the data has been migrated from {{ ydb-name }} to the {{ objstorage-name }} bucket:

1. In the [management console]({{ link-console-main }}), select the folder where the bucket is located.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Select the bucket from the list.
1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_files }}** tab.
1. Check that the {{ objstorage-name }} bucket contains the `from_YDB` folder with the `<seasons.csv>` object with the test data.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ objstorage-name }} bucket](../../../storage/operations/buckets/delete.md).
   1. [Delete the {{ ydb-name }} database](../../../ydb/operations/manage-databases.md/#delete-db).
   1. If you created a service account, [delete it](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `ydb-to-object-storage.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `ydb-to-object-storage.tf` configuration file will be deleted.

{% endlist %}