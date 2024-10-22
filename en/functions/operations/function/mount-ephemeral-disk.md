---
title: How to mount an ephemeral disk to a function in {{ sf-full-name }}
description: Follow this guide to mount an ephemeral disk to a function in {{ sf-name }}.
---

# Mounting an ephemeral disk to a function

{% include [preview-and-request](../../../_includes/note-preview-by-request.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select a function.
  1. In the left-hand menu, select ![image](../../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**.
  1. Under **Ephemeral disk**, click **Add ephemeral disk** and fill in these fields:
      * **Mount point**: Name of the mount point. The directory with the mounted ephemeral disk will be accessible at `/function/storage/<mount_point>`.
      * **Disk size**: Memory size you want to allocate for the ephemeral disk you are mounting.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To mount an ephemeral disk to a function, run this command:

  ```bash
  yc serverless function version create \
    --function-name=<function_name> \
    --runtime <runtime_environment> \
    --entrypoint <entry_point> \
    --memory <RAM_amount> \
    --execution-timeout <execution_timeout> \
    --source-path <path_to_ZIP_archive> \
    --service-account-id <service_account_ID> \
    --mount type=ephemeral-disk,mount-point=<mount_point>,size=<disk_size>
  ```

  Where:

  * `--function-name`: Function name.
  * `--runtime`: Runtime environment.
  * `--entrypoint`: Entry point in the following format: `<file_name_without_extension>.<listener_name>`.
  * `--memory`: Amount of RAM.
  * `--execution-timeout`: Maximum function running time before the timeout is reached.
  * `--source-path`: ZIP archive with the function code and required dependencies.
  * `--service-account-id`: Service account ID.
  * `--mount`: Ephemeral disk mounting parameters:
    * `type=ephemeral-disk`: Type of the file system being mounted.
    * `mount-point`: Name of the mount point. The directory with the mounted disk will be accessible at `/function/storage/<mount_point>`.
    * `size`: Ephemeral disk size in GB, e.g., `size=5GB`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To mount an ephemeral disk to a function:

  1. Open the {{ TF }} configuration file and add the `mounts` section to the function description:

      ```hcl
      resource "yandex_function" "ephemeral_storage_function" {
        name               = "<function_name>"
        user_hash          = "<function_hash>"
        runtime            = "<runtime_environment>"
        entrypoint         = "<entry_point>"
        memory             = "<RAM_amount>"
        execution_timeout  = "<execution_timeout>"
        service_account_id = "<service_account_ID>"
        content {
          zip_filename = "<path_to_ZIP_archive>"
        }

        mounts {
          name = "<mount_point>"
          ephemeral_disk {
            size_gb = <disk_size>
          }
        }
      }
      ```

      Where:

      * `mounts`: Ephemeral disk mounting parameters:
        * `name`: Name of the mount point. The directory with the mounted disk will be accessible at `/function/storage/<mount_point>`.
        * `size_gb`: Ephemeral disk size in GB, e.g., `size=5GB`.

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the function update and its new configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc serverless function version get <function_version_ID>
  ```

- API {#api}

  To mount an ephemeral disk to a function, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [Mounting file systems to a function](../../concepts/mounting.md)
* [Mounting file systems to a container](../../../serverless-containers/concepts/mounting.md)
