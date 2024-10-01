---
title: "How to get information about a file storage in {{ compute-full-name }}"
---

# Getting information about a file storage

You can get the file storage size, availability zone, and other file storage information.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [file storage](../../concepts/filesystem.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
  1. Select the required file storage.
  1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the file storage.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about a [file storage](../../concepts/filesystem.md):

      ```bash
      yc compute filesystem get --help
      ```

  1. Get information about a file storage by specifying its ID or name:

      ```bash
      yc compute filesystem get <file_storage_ID>
      ```

      Result:

      ```text
      id: epdt429j3unu********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:15:53Z"
      name: test-filesystem
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "1073741824"
      block_size: "4096"
      status: READY
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [file storage](../../concepts/filesystem.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_filesystem" "my_fs" {
        filesystem_id = "<file_storage_ID>"
      }

      output "filesystem" {
        value = data.yandex_compute_filesystem.my_fs.size
      }
      ```

      Where:

      * `data "yandex_compute_filesystem"`: Description of the file storage as a data source:
         * `resource_id`: File storage ID.
      * `output "filesystem"`: Output variable that contains information about the file storage size:
         * `value`: Returned value.

     You can replace `size` with any other parameter to get the information you need. For more information about the `yandex_compute_filesystem` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/datasource_compute_filesystem).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      filesystem = "5"
      ```

- API {#api}

  To get detailed information about a [file storage](../../concepts/filesystem.md), use the [get](../../api-ref/Filesystem/get.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Get](../../api-ref/grpc/filesystem_service.md#Get) gRPC API call.

{% endlist %}