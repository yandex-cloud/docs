# Updating file storage

After creating file storage, you can change its name, description, and size.

{% note info %}

You can only change the storage size by using the CLI or API.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your file store is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
   1. In the row of the desired file storage, click ![image](../../../_assets/options-grey.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. Change the file storage parameters, for example, rename it by editing the **{{ ui-key.yacloud.common.name }}** field.

      {% note info %}

      You can only change the storage size by using the CLI or API.

      {% endnote %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI update storage command:

      * To change the name, description, or size:

         ```bash
         yc compute filesystem update --help
         ```

      * To change the size:

         ```bash
         yc compute filesystem resize --help
         ```

   1. Get a list of available storage:

      ```bash
      yc compute filesystem list --format yaml
      ```

      Result:

      ```bash
      - id: epd0u6h8lh41kq5tua6h
        folder_id: b1g86q4m5vej8lkljme5
        created_at: "2022-04-26T16:59:19Z"
        name: storage-1
        type_id: network-hdd
        zone_id: {{ region-id }}-b
        size: "1073741824"
        block_size: "4096"
        status: READY
      - id: epd5g123c8hk1thkkccm
        folder_id: b1g86q4m5vej8lkljme5
        created_at: "2022-04-26T16:37:30Z"
        name: storage-2
        description: test
        type_id: network-hdd
        zone_id: {{ region-id }}-b
        size: "1073741824"
        block_size: "4096"
        status: READY
      ```

   1. Update the storage parameters by including the `--id` or`--name` of the appropriate storage in your command. For example, update:

      * The name and description:

         ```bash
         yc compute filesystem update \
           --name storage-1 \
           --new-name storage-3 \
           --description vm-storage
         ```

         Result:

         ```bash
         id: epd5g123c8hk1thkkccm
         folder_id: b1g86q4m5vej8lkljme5
         created_at: "2022-04-26T16:37:30Z"
         name: storage-3
         description: vm-storage
         type_id: network-hdd
         zone_id: {{ region-id }}-b
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

         ```bash
         id: epd5g123c8hk1thkkccm
         folder_id: b1g86q4m5vej8lkljme5
         created_at: "2022-04-26T16:37:30Z"
         name: storage-1
         type_id: network-hdd
         zone_id: {{ region-id }}-b
         size: "2147483648"
         block_size: "4096"
         status: READY
         ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and edit the fragment with the storage description:

      {% cut "Sample storage description in the {{ TF }} configuration" %}

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

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   You can verify that the storage has been updated and its configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc compute filesystem get <storage_name>
   ```

- API

   Use the [update](../../api-ref/Filesystem/update.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Update](../../api-ref/grpc/filesystem_service.md#Update) gRPC API call.

{% endlist %}