---
title: "How to create file storage in {{ compute-full-name }}"
description: "Follow this guide to create file storage."
---

# Creating file storage

To create file [storage](../../concepts/filesystem.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a file storage.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
   1. Click **{{ ui-key.yacloud.compute.nfs.button_create-filesystem }}**.
   1. Name the storage.

      {% include [name-format-2](../../../_includes/name-format-2.md) %}

   1. (Optional) Add a storage description.
   1. Select an [availability zone](../../../overview/concepts/geo-scope.md): either `{{ region-id }}-a` or `{{ region-id }}-b`. You can only attach storage to VMs from the same availability zone.
   1. Select the [storage type](../../concepts/filesystem.md#types).

      {% note warning %}

      You cannot change the availability zone and type of storage after you create it.

      {% endnote %}

   1. Specify the block and storage disk size.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      
      ```
      provider "yandex" {
        zone = "{{ region-id }}-a"
      }

      resource "yandex_compute_filesystem" "default" {
        name   = "<storage_name>"
        type   = "<storage_type>"
        zone   = "<availability_zone>"
        size   = <storage_size>
        labels = {
          <key_of_label_1> = "<value_of_label_1>"
          <key_of_label_2> = "<value_of_label_2>"
       }
      }
      ```



      Where:

      * `name`: Storage name. This is a required parameter.
      * `type`: [Storage type](../../concepts/filesystem.md#types). Possible values: `network-hdd` or `network-ssd`. The default storage type is `network-hdd`. This is an optional parameter.
      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md). Possible values: `{{ region-id }}-a` or `{{ region-id }}-b`. This is an optional parameter.
      * `size`: Storage size in GB. This is an optional parameter. The default value is 150 GB.
      * `labels`: Resource [label](../../../resource-manager/concepts/labels.md) in `<key> = "<value>"` format. This is an optional parameter.

      For more information about the parameters of the `yandex_compute_filesystem` resource in Terraform, see the [provider documentation]({{ tf-provider-link }}/compute_filesystem).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a storage in the specified folder. You can check the new storage and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc compute filesystem get <storage_name>
   ```

- API {#api}

   Use the [create](../../api-ref/Filesystem/create.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Create](../../api-ref/grpc/filesystem_service.md#Create) gRPC API call.

{% endlist %}