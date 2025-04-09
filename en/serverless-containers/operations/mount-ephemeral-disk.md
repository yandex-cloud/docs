---
title: How to mount an ephemeral disk to {{ serverless-containers-full-name }}
description: Follow this guide to mount an ephemeral disk to {{ serverless-containers-name }}.
---

# Mounting an ephemeral disk to a container

{% include [preview](../../_includes/note-preview-by-request.md) %}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. In the left-hand menu, select ![image](../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.title_ephemeral-storage }}**:

        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-ephemeral-storage }}**.
        1. Specify the following in the field:

            * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-path }}**: Absolute mount path. Use this path to access the directory the disk will be mounted to.
            
                Do not use this path for anything other than an empty directory; otherwise, the container initialization may result in an error, and the mounted ephemeral disk will become unavailable. To mount the ephemeral disk correctly, provide the full absolute path to the mount point.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.label_ephemeral-storage-size }}**: Amount of memory you want to allocate for the ephemeral disk you are mounting.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To mount an ephemeral disk to a container, run this command:

  ```bash
  yc serverless container revision deploy \
    --container-name=<container_name> \
    --environment <runtime_environment> \
    --image <container_image_path> \
    --memory <RAM_size> \
    --execution-timeout <execution_timeout> \
    --service-account-id <service_account_ID> \
    --mount type=ephemeral-disk,mount-point=<mount_point>,size=<disk_size>
  ```

  Where:

  * `--container-name`: Container name.
  * `--environment`: Runtime environment.
  * `--image`: Container image path.
  * `--memory`: Amount of RAM.
  * `--execution-timeout`: Maximum container execution time before timeout.
  * `--service-account-id`: Service account ID.
  * `--mount`: Ephemeral disk mounting parameters:
    * `type=ephemeral-disk`: Type of the file system being mounted.
    * `mount-point`: Absolute mount path. Use this path to access the directory the disk will be mounted to. Do not use this path for anything other than an empty directory; otherwise, the container initialization may result in an error, and the mounted ephemeral disk will become unavailable. To mount the ephemeral disk correctly, provide the full absolute path to the mount point.
    * `size`: Ephemeral disk size in GB, e.g., `size=5GB`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To mount an ephemeral disk to a container:

  1. Open the {{ TF }} configuration file and add the `mounts` section to the container description:

      ```hcl
      resource "yandex_serverless_container" "ephemeral_storage_container" {
        name               = "<container_name>"
        memory             = "<RAM_size>"
        execution_timeout  = "<execution_timeout>"
        service_account_id = "<service_account_ID>"
        content {
          zip_filename = "<path_to_ZIP_archive>"
        }

        image {
          url = <container_image_path>
        }

        mounts {
          mount_point_path = <mount_point>
          ephemeral_disk {
            size_gb = <disk_size>
          }
        }
      }
      ```

      Where:

      * `mounts`: Ephemeral disk mounting parameters:
        * `mount_point_path`: Absolute mount path. Use this path to access the directory the disk will be mounted to. Do not use this path for anything other than an empty directory; otherwise, the container initialization may result in an error, and the mounted ephemeral disk will become unavailable. To mount the ephemeral disk correctly, provide the full absolute path to the mount point.
        * `size_gb`: Ephemeral disk size in GB, e.g., `size=5GB`.

      For more information about the `yandex_serverless_container` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_container).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the container's update and settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

  ```bash
  yc serverless container revision get <container_revision_ID>
  ```

- API {#api}

  To mount an ephemeral disk, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/mounting.md)
* [{#T}](../../functions/concepts/mounting.md)
