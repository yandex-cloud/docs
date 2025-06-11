---
title: How to create a file storage in {{ compute-full-name }}
description: Follow this guide to create a file storage.
---

# Creating a file storage


To create a [file storage](../../concepts/filesystem.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a file storage.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.file-storages_pNPw1 }}**.
  1. Click **{{ ui-key.yacloud.compute.nfs.button_create-filesystem }}**.
  1. Enter a name for the file storage.

     {% include [name-format-2](../../../_includes/name-format-2.md) %}

  1. Optionally, provide a description for file storage.
  1. Select an [availability zone](../../../overview/concepts/geo-scope.md). You can only attach a file storage to [VMs](../../concepts/vm.md) from the same availability zone.
  1. Select the [file storage type](../../concepts/filesystem.md#types).

     {% note warning %}

     Once a file storage is created, you cannot change its availability zone or type.

     {% endnote %}

  1. Specify the block and disk size for the file storage.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating a file storage:

      ```bash
      yc compute filesystem create --help
      ```

  1. Create a file storage in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute filesystem create \
        --name <file_storage_name> \
        --type <file_storage_type> \
        --zone <availability_zone> \
        --size <file_storage_size> \
        --labels <key>=<value>
      ```

      Where:
      * `--name`: File storage name. The naming requirements are as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

      * `--type`: [File storage type](../../concepts/filesystem.md#types). The possible values are `network-hdd` or `network-ssd`.
      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md).
      * `--size`: File storage size. This is an optional parameter. The default value is 150 GB.

        By default, the value is specified in bytes. To specify the size in megabytes or gigabytes, use the `M` and `G` suffixes, e.g., `2048M` or `2G`.

      * `--labels`: File storage [labels](../../../resource-manager/concepts/labels.md) in `<key>=<value>` format. This is an optional parameter.

        To specify multiple labels, list them separated by commas: `<key_1>=<value_1>,<key_2>=<value_2>,...,<key_n>=<value_n>`.

      Result:

      ```yml
      done (11s)
      id: epdcago8e5lr********
      folder_id: b1gt6g8ht345********
      created_at: "2024-05-02T05:56:39Z"
      name: my-sample-fs
      labels:
        key1: value1
        key2: value2
        key3: value3
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "1073741824"
      status: READY
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     provider "yandex" {
       zone = "{{ region-id }}-a"
     }

     resource "yandex_compute_filesystem" "default" {
       name   = "<file_storage_name>"
       type   = "<file_storage_type>"
       zone   = "<availability_zone>"
       size   = <file_storage_size>
       labels = {
         <label_1_key> = "<label_1_value>"
         <label_2_key> = "<label_2_value>"
       }
     }
     ```

     Where:
     * `name`: File storage name. This is a required parameter.
     * `type`: [File storage type](../../concepts/filesystem.md#types). The possible values are `network-hdd` or `network-ssd`. The default file storage type is `network-hdd`. This is an optional parameter.
     * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md). This is an optional parameter.
     * `size`: File storage size in GB. This is an optional parameter. The default value is 150 GB.
     * `labels`: Resource [label](../../../resource-manager/concepts/labels.md) in `<key> = "<value>"` format. This is an optional parameter.

      For more information about the `yandex_compute_filesystem` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_filesystem).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a file storage in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new file storage and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc compute filesystem get <file_storage_name>
  ```

- API {#api}

  Use the [create](../../api-ref/Filesystem/create.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Create](../../api-ref/grpc/Filesystem/create.md) gRPC API call.

{% endlist %}