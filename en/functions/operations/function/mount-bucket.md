---
title: How to mount buckets to a function in {{ sf-full-name }}
description: Follow this guide to mount a bucket to a function in {{ sf-name }}.
---

# Mounting a bucket to a function

You can mount {{ objstorage-full-name }} [buckets](../../../storage/concepts/bucket.md) to a function. Mounting a bucket automatically creates a new function [version](../../concepts/function.md#version).

To mount buckets to a function:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the function.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select a function.
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** section, select or create a new [service account](../../../iam/concepts/users/service-accounts) with one of these roles:
     * [`storage.viewer`](../../../storage/security/index.md#storage-viewer) to only read data from the mounted [bucket](../../../storage/concepts/bucket.md).
     * [`storage.uploader`](../../../storage/security/index.md#storage-uploader) to read and write data from/to the mounted bucket.
  1. Expand **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}**:
  
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
      1. Specify the following in the field:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-name }}**: Name of the mount point. Use this path to access the directory the bucket will be mounted to: `/function/storage/<mount_point>`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}**: Bucket you want to mount. If necessary, [create](../../../storage/operations/buckets/create.md) a new bucket.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}**: Bucket [directory](../../../storage/concepts/object.md#folder) that will be mounted to the container. Leave this field empty to mount the entire bucket.
      1. Enable **{{ ui-key.yacloud.serverless-functions.item.editor.label_readonly }}** to disable writing to the bucket. With this option on, data from the mounted bucket will be read-only.

      To mount an additional bucket to the function, click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}** again and configure the parameters as needed.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  yc serverless function version create \
    --function-name=<function_name> \
    --runtime <runtime_environment> \
    --entrypoint <entry_point> \
    --memory <RAM_size> \
    --execution-timeout <execution_timeout> \
    --source-path <path_to_ZIP_archive> \
    --service-account-id <service_account_ID> \
    --mount type=object-storage,mount-point=<mount_point>,bucket=<bucket_name>,prefix=<directory_name>,mode=<mount_mode>
  ```

  Where:

  * `--function-name`: Function name.
  * `--runtime`: Function [runtime environment](../../concepts/runtime/index.md#runtimes).
  * `--entrypoint`: Entry point in the following format: `<file_name_without_extension>.<listener_name>`, e.g., `index.handler`.
  * `--memory`: Amount of RAM.
  * `--execution-timeout`: Maximum running time of the function until timeout.
  * `--source-path`: Path to the ZIP archive containing the function code and relevant dependencies.
  * `--service-account-id`: Service account [ID](../../../iam/operations/sa/get-id.md). The service account needs the `storage.viewer` [role](../../../storage/security/index.md#storage-viewer) to read from the bucket or the `storage.uploader` [role](../../../storage/security/index.md#storage-uploader) to both read and write.
  * `--mount`: {{ objstorage-name }} [bucket](../../../storage/concepts/bucket.md) mounting parameters:
      * `type`: Mounted storage type. For a bucket, the value is always `object-storage`.
      * `mount-point`: Mount point. Use this path to access the directory the bucket will be mounted to: `/function/storage/<mount_point>`.
      * `bucket`: [Bucket](../../../storage/concepts/bucket.md#naming) name.
      * `prefix`: Bucket [directory](../../../storage/concepts/object.md#folder) that will be mounted to the function. Skip this field or leave it empty to mount the entire bucket.
      * `mode`: Bucket mount mode, `ro` (read-only) or `rw` (read and write).

      To mount several buckets to a function at the same time, set the `--mount` parameter as many times as you need.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `mounts` section to the function description:

      ```hcl
      resource "yandex_function" "bucketfunction" {
        ...

        mounts {
          name = "<mount_point>"
          mode = "<mount_mode>"
          object_storage {
            bucket = "<bucket_name>"
            prefix = "<directory_name>"
          }
        }

      }
      ```

      Where:

      * `mounts`: {{ objstorage-name }} [bucket](../../../storage/concepts/bucket.md) mounting parameters:
          * `name`: Mount point. Use this path to access the directory the [bucket](../../../storage/concepts/bucket.md) will be mounted to: `/function/storage/<mount_point>`.
          * `mode`: Bucket mount mode, `ro` (read-only) or `rw` (read and write).
          * `object_storage`: Bucket parameters:
              * `bucket`: [Bucket](../../../storage/concepts/bucket.md#naming) name.
              * `prefix`: Bucket [folder](../../../storage/concepts/object.md#folder) that will be mounted to the container. Leave this field empty to mount the entire bucket.

          To mount several buckets to a function at the same time, set the `mounts` section as many times as you need.

      For more information about the `yandex_function` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/function).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the function version update and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc serverless function version get <function_version_ID>
  ```

- API {#api}

  Use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../../concepts/mounting.md)
* [{#T}](../../../serverless-containers/concepts/mounting.md)
