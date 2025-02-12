# Updating a file storage

After creating a [file storage](../../concepts/filesystem.md), you can change its name, description, and size.

{% note info %}

To resize a file storage, you can only use the [CLI](../../../cli/) or API. You can only increase the storage size. Reducing it is not supported.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your file storage resides.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
  1. In the line with the file storage, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Update the file storage parameters, e.g., rename the storage by editing the **{{ ui-key.yacloud.common.name }}** field.

     {% note info %}

     To resize a file storage, you can only use the CLI or API.

     {% endnote %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a file storage:
     * To change the name, description, or size:

       ```bash
       yc compute filesystem update --help
       ```

     * To resize:

       ```bash
       yc compute filesystem resize --help
       ```

  1. Get a list of available file storages:

     ```bash
     yc compute filesystem list --format yaml
     ```

     Result:

     ```text
     - id: epd0u6h8lh41********
       folder_id: b1g86q4m5vej********
       created_at: "2022-04-26T16:59:19Z"
     ...
       size: "1073741824"
       block_size: "4096"
       status: READY
     ```

  1. Update the storage parameters by specifying the storage `--id` or `--name` value in your command. For example, update the following:
     * Name and description:

       ```bash
       yc compute filesystem update \
         --name storage-1 \
         --new-name storage-3 \
         --description vm-storage
       ```

       Result:

       ```text
       id: epd5g123c8hk********
       folder_id: b1g86q4m5vej********
       created_at: "2022-04-26T16:37:30Z"
       ...
       size: "1073741824"
       block_size: "4096"
       status: READY
       ```

     * Size:

       ```bash
       yc compute filesystem resize \
         --name storage-1 \
         --size 2GB
       ```

       Result:

       ```text
       id: epd5g123c8hk********
       folder_id: b1g86q4m5vej********
       created_at: "2022-04-26T16:37:30Z"
       ...
       size: "2147483648"
       block_size: "4096"
       status: READY
       ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the section specifying the file storage:

     {% cut "Example of specifying a file storage in {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_compute_filesystem" "default" {
       name  = "fs-name"
       type  = "network-ssd"
       zone  = "{{ region-id }}-a"
       size  = 150
     }
     ...
     ```

     {% endcut %}

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the file storage updates and settings using the [management console]({{ link-console-main }}) or this CLI command:

  ```bash
  yc compute filesystem get <file_storage_name>
  ```

- API {#api}

  Use the [update](../../api-ref/Filesystem/update.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Update](../../api-ref/grpc/Filesystem/update.md) gRPC API call.

{% endlist %}