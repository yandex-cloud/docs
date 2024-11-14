---
title: How to mount buckets to a function in {{ sf-full-name }}
description: Follow this guide to mount a bucket to a function in {{ sf-name }}.
---

# Mounting a bucket to a function

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select a function.
  1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** section, select or create a new [service account](../../../iam/concepts/users/service-accounts) with one of these roles:
     * `storage.viewer` to only read data from the mounted bucket.
     * `storage.uploader` to read and write data from/to the mounted bucket.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}**, click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}** and specify:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-name }}**: Name of the mount point. Use this path to access the directory in which the bucket is mounted: `/function/storage/<mount_point>`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}**: Name of the bucket you want to mount. Alternatively, you can create a new bucket.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}**: [Folder](../../../storage/concepts/object.md#folder) within the bucket. Leave this field empty to mount the entire bucket.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_readonly }}**: Disables writing to the bucket. If this option is enabled, data from the mounted bucket is available as read-only.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To mount a bucket to a function, run this command:

  ```bash
  yc serverless function version create \
    --function-name=<function_name> \
    --runtime <runtime_environment> \
    --entrypoint <entry_point> \
    --memory <RAM_size> \
    --execution-timeout <execution_timeout> \
    --source-path <path_to_ZIP_archive> \
    --service-account-id <service_account_ID>
    --storage-mounts mount-point=<mount_point>,bucket=<bucket_name>,prefix=<folder_name>,read-only=false
  ```

  Where:

  * `--function-name`: Function name.
  * `--runtime`: Runtime environment.
  * `--entrypoint`: Entry point in the following format: `<file_name_without_extension>.<listener_name>`.
  * `--memory`: Amount of RAM.
  * `--execution-timeout`: Maximum function running time before the timeout is reached.
  * `--source-path`: ZIP archive with the function code and required dependencies.
  * `--service-account-id`: Service account ID. The account must have the `storage.viewer` role to read data from the bucket or the `storage.uploader` role to write data.
  * `--storage-mounts`: {{ objstorage-name }} [bucket](../../../storage/concepts/bucket.md) mounting parameters:
    * `mount-point`: Name of the mount point. Use this path to access the directory in which the bucket is mounted: `/function/storage/<mount_point>`.
    * `bucket`: Bucket.
    * `prefix`: [Folder](../../../storage/concepts/object.md#folder) within the bucket. Leave this field empty to mount the entire bucket.
    * `read-only`: Disables writing to the bucket. If this option is enabled, data from the mounted bucket is available as read-only. The possible values are `true` and `false`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To mount a bucket to a function:

  1. Open the {{ TF }} configuration file and add the `storage_mounts` section to the function description:

      ```hcl
      resource "yandex_function" "bucketfunction" {
        name               = "<bucket_name>"
        user_hash          = "<function_hash>"
        runtime            = "<runtime_environment>"
        entrypoint         = "<entry_point>"
        memory             = "<RAM_size>"
        execution_timeout  = "<execution_timeout>"
        service_account_id = "<service_account_ID>"
        content {
          zip_filename = "<path_to_ZIP_archive>"
        }

        storage_mounts {
          mount_point_name = "<mount_point>"
          bucket           = "<bucket_name>"
          prefix           = "<folder_name>"
          read_only        = <read_only_flag>
        }
      }
      ```

      Where:

      * `storage_mounts`: [Bucket](../../../storage/concepts/bucket.md) mounting parameters:
        * `mount_point_name`: Name of the mount point. Use this path to access the directory in which the bucket is mounted: `/function/storage/<mount_point>`.
        * `bucket`: Bucket.
        * `prefix`: [Folder](../../../storage/concepts/object.md#folder) within the bucket. Leave this field empty to mount the entire bucket.
        * `read_only`: Disables writing to the bucket. If this option is enabled, data from the mounted bucket is available as read-only. The possible values are `true` and `false`.

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the function update and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc serverless function version get <function_version_ID>
  ```

- API {#api}

  To mount a bucket to a function, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [Mounting file systems to a function](../../concepts/mounting.md)
* [Mounting file systems to a container](../../../serverless-containers/concepts/mounting.md)
