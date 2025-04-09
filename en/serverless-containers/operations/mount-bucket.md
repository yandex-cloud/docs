---
title: Mounting buckets to a {{ serverless-containers-full-name }} container
description: Follow this guide to mount a bucket to a {{ serverless-containers-name }} container.
---

# Mounting a bucket to a container

You can mount {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md) to a container. Mounting a bucket automatically creates a new container [revision](../concepts/container.md#revision).

To mount buckets to a container:

{% list tabs group=instructions %}

- Management console {#console}
    
  1. In the [management console]({{ link-console-main }}), go to the folder with your container.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container.
  1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
  1. In the **{{ ui-key.yacloud.serverless-containers.section_parameters }}** section, select or create a new [service account](../../iam/concepts/users/service-accounts) with one of these roles:
      * [`storage.viewer`](../../storage/security/index.md#storage-viewer) to only read data from the mounted [bucket](../../storage/concepts/bucket.md).
      * [`storage.uploader`](../../storage/security/index.md#storage-uploader) to read and write data from/to the mounted bucket.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}**:

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
      1. Specify the following in the field:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-path }}**: Absolute mount path. Use this path to access the directory the bucket will be mounted to.

              Do not use this path for anything other than an empty directory; otherwise, the container initialization may result in an error, and the mounted buckets will become unavailable.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}**: Bucket you want to mount. [Create](../../storage/operations/buckets/create.md) a new bucket if needed.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}**: Bucket [directory](../../storage/concepts/object.md#folder) that will be mounted to the container. Leave this field empty to mount the entire bucket.
      1. Enable **{{ ui-key.yacloud.serverless-functions.item.editor.label_readonly }}** to disable writing to the bucket. With this option on, data from the mounted bucket will be read-only.

      To mount an additional bucket to the container, click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}** again and configure the parameters as needed.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  yc serverless container revision deploy \
    --container-name <container_name> \
    --image <Docker_image_URL> \
    --memory <RAM_size> \
    --execution-timeout <execution_timeout> \
    --service-account-id <service_account_ID> \
    --command '<command_1>','<command_2>' \
    --args '<key_1=value_1>','<key_2=value_2>' \
    --mount type=object-storage,mount-point=<mount_path>,bucket=<bucket_name>,prefix=<directory_name>,mode=<mount_mode>
  ```

  Where:

  * `--container-name`: Container name.
  * `--image`: URL of the Docker image you are creating a container revision from in the following format: `cr.yandex/<registry_ID>/<Docker_image_name>:<tag>`.
  * `--memory`: Required RAM.
  * `--execution-timeout`: Maximum container execution time before timeout.
  * `--service-account-id`: Service account [ID](../../iam/operations/sa/get-id.md). The service account needs the `storage.viewer` [role](../../storage/security/index.md#storage-viewer) to read from the bucket or the `storage.uploader` [role](../../storage/security/index.md#storage-uploader) to both read and write.
  * `--command`: Commands the container will run when started. Separate them by commas. It matches the `ENTRYPOINT` instruction in the Dockerfile.
  * `--args`: Arguments matching the `CMD` instruction in the Dockerfile. Specify them in `key = value` format separated by commas. If you do not specify this parameter, the default `CMD` value from the Docker image will be used.
  * `--mount`: {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) mounting parameters:
      * `type`: Mounted storage type. For a bucket, the value is always `object-storage`.
      * `mount-point`: Absolute mount path. Use this path to access the directory the bucket will be mounted to.
      * `bucket`: [Bucket](../../storage/concepts/bucket.md#naming) name.
      * `prefix`: Bucket [folder](../../storage/concepts/object.md#folder) that will be mounted to the container. Skip this field or leave it empty to mount the entire bucket.
      * `mode`: Bucket mount mode, `ro` (read-only) or `rw` (read and write).

      To mount several buckets to the container at the same time, set the `--mount` parameter as many times as you need.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `mounts` section to the container description:

      ```hcl
      resource "yandex_serverless_container" "test-container" {
        ...

        mounts {
          mount_point_path = "<mount_point>"
          mode             = "<mount_mode>"
          object_storage {
            bucket = "<bucket_name>"
            prefix = "<directory_name>"
          }
        }
      }
      ```

      Where:

      * `mounts`: {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) mounting parameters:
          * `mount_point_path`: Absolute mount path. Use this path to access the directory the [bucket](../../storage/concepts/bucket.md) will be mounted to.
          * `mode`: Bucket mount mode, `ro` (read-only) or `rw` (read and write).
          * `object_storage`: Bucket parameters:
              * `bucket`: [Bucket](../../storage/concepts/bucket.md#naming) name.
              * `prefix`: Bucket [folder](../../storage/concepts/object.md#folder) that will be mounted to the container. Leave this field empty to mount the entire bucket.

          To mount several buckets to the container at the same time, set the `mounts` section as many times as you need.

      For more information about the `yandex_serverless_container` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_container).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the container revision update and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

  ```bash
  yc serverless container revision get <container_revision_ID>
  ```

- API {#api}

  Use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/mounting.md)
* [{#T}](../../functions/concepts/mounting.md)
