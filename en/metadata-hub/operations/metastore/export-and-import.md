# Exporting and importing Hive metadata in the {{ metastore-name }} cluster

## Getting started {#before-you-begin}

1. [Create a service account](../../../iam/operations/sa/create.md) named `my-account` with the `storage.uploader` role.
1. [Create a static access key](../../../iam/operations/sa/create-access-key.md) for the `my-account` service account. Save the ID and secret key: you will need them for work with [{{ objstorage-full-name }}](../../../storage/index.yaml).
1. [Configure the network and create a {{ metastore-name }} cluster](cluster-create.md). When creating, specify the static access key parameters.

   {% note warning %}

   Data export and import are only available in {{ metastore-name }} clusters with a static access key.

   {% endnote %}

1. [Create a bucket](../../../storage/operations/buckets/create.md) named `my-bucket` in {{ objstorage-name }}. It will store the metadata file for import and export.
1. [Grant](../../../storage/operations/buckets/edit-acl.md) a `READ and WRITE` permission to the `my-account` service account for the bucket named `my-bucket`.

## Export data {#export}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. In the left-hand panel, select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the cluster you need and select ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.metastore.action_export }}**.
   1. In the window that opens, specify:

      * The bucket named `my-bucket` the cluster data will be exported to.
      * The `.sql` file the cluster data will be written to. If a file with that name already exists, it will be overwritten.

   1. Click **{{ ui-key.yacloud.metastore.dialog.import-export.action_export }}**.

{% endlist %}

## Import data {#import}

Before importing, [upload](../../../storage/operations/objects/upload.md#simple) the `.sql` file with metadata into `my-bucket`. For information on how to prepare a file and how the import process works, see [{#T}](../../tutorials/metastore-import.md).

To import data to a cluster:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. In the left-hand panel, select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the cluster you need and select ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud.metastore.action_import }}**.
   1. In the window that opens, select the bucket named `my-bucket` and the file the cluster data will be imported from.
   1. Click **{{ ui-key.yacloud.metastore.dialog.import-export.action_import }}**.

{% endlist %}
