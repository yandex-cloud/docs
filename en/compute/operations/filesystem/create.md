---
title: "How to create a file storage in {{ compute-full-name }}"
description: "Follow this guide to create a file storage."
---

# Creating a file storage


To create a file [storage](../../concepts/filesystem.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a file storage.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
   1. Click **{{ ui-key.yacloud.compute.nfs.button_create-filesystem }}**.
   1. Name the file storage.

      {% include [name-format-2](../../../_includes/name-format-2.md) %}

   1. (Optional) Add a file storage description.
   1. Select the [availability zone](../../../overview/concepts/geo-scope.md): either `{{ region-id }}-a` or `{{ region-id }}-b`. You can only attach a file storage to [VMs](../../concepts/vm.md) from the same availability zone.
   1. Select the [file storage type](../../concepts/filesystem.md#types).

      {% note warning %}

      You cannot change the availability zone and type of file storage after you create it.

      {% endnote %}

   1. Specify the block and file storage disk size.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

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
          <key_of_label_1> = "<value_of_label_1>"
          <key_of_label_2> = "<value_of_label_2>"
        }
      }
      ```

      Where:
      * `name`: File storage name. This is a required parameter.
      * `type`: [File storage type](../../concepts/filesystem.md#types). The possible values are `network-hdd` or `network-ssd`. The default file storage type is `network-hdd`. This is an optional parameter.
      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md). The possible values are `{{ region-id }}-a` or `{{ region-id }}-b`. This is an optional parameter.
      * `size`: File storage size in GB. This is an optional parameter. The default value is 150 GB.
      * `labels`: Resource [label](../../../resource-manager/concepts/labels.md) in `<key> = "<value>"` format. This is an optional parameter.

      For more information about the parameters of the `yandex_compute_filesystem` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/compute_filesystem).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   This will create a file storage in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new file storage and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc compute filesystem get <file_storage_name>
   ```

- API {#api}

   Use the [create](../../api-ref/Filesystem/create.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Create](../../api-ref/grpc/filesystem_service.md#Create) gRPC API call.

{% endlist %}