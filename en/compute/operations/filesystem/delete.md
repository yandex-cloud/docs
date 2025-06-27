---
title: Deleting a file storage
description: Follow this guide to delete a file storage.
---

# Deleting a file storage

1. [Detach the file storage](detach-from-vm.md) from all the [VMs](../../concepts/vm.md) it is attached to.
1. Delete the [file storage](../../concepts/filesystem.md) in {{ compute-name }}:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your file storage resides.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.file-storages_pNPw1 }}**.
     1. In the line with the file storage, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
     1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

   - CLI {#cli}

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     1. See the description of the [CLI](../../../cli/) command for deleting a file storage:

        ```bash
        yc compute filesystem delete --help
        ```

     1. Get a list of file storages in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

        {% include [compute-filesystem-list](../../_includes_service/compute-filesystem-list.md) %}

     1. Run this command, specifying the name or ID of the file storage you want to delete:

        ```bash
        yc compute filesystem delete <file_storage_name_or_ID>
        ```

     1. Make sure the file storage has been deleted:

        ```bash
        yc compute filesystem list
        ```

   - {{ TF }} {#tf}

     {% include [terraform-install](../../../_includes/terraform-install.md) %}

     1. Open the {{ TF }} configuration file and delete the section specifying the storage:

        {% cut "Example of specifying a file storage in {{ TF }} configuration" %}

        ```hcl
        ...
        resource "yandex_compute_filesystem" "default" {
          name = "fs-name"
          type = "network-ssd"
          zone = "{{ region-id }}-a"
          size = 150
        }
        ...
        ```

        {% endcut %}

     1. Apply the changes:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the storage deletion using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc compute filesystem list
     ```

   - API {#api}

     Use the [delete](../../api-ref/Filesystem/delete.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Delete](../../api-ref/grpc/Filesystem/delete.md) gRPC API call.

   {% endlist %}