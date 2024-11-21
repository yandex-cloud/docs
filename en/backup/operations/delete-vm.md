---
title: How to delete a VM from {{ backup-full-name }}
description: Follow this guide to delete a VM from {{ backup-name }}.
---

# Deleting a VM from {{ backup-name }}

When you delete a VM from {{ backup-name }}, it remains in {{ compute-full-name }} and keeps running. You need to [delete](../../compute/operations/vm-control/vm-delete.md) a VM from {{ compute-name }} separately.

{% note info %}

If you delete a VM from {{ compute-name }} using the management console it is also deleted from {{ backup-name }}. If you use the YC CLI, {{ TF }}, or an API request, the VM remains available in {{ backup-name }}.

{% endnote %}

If you want to reconnect a VM to {{ backup-name }} after you delete it, use these guides:

* [Connecting a Linux VM](connect-vm-linux.md)
* [Connecting a Windows VM](connect-vm-windows.md)

To delete a VM from {{ backup-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to delete the VM from.
  1. In the list of services, select **{{ backup-name }}**.
  1. Next to the VM you want to delete, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Delete**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to delete a VM from {{ backup-name }}:

      ```bash
      yc backup vm delete --help
      ```

  1. Get the ID of the VM to delete:

      {% include [get-vm-id](../../_includes/backup/operations/get-vm-id.md) %}

  1. Delete the VM by specifying its ID:

      ```bash
      yc backup vm delete <VM_ID>
      ```

- API {#api}

  Use the [delete](../backup/api-ref/Resource/delete.md) REST API method for the [Resource](../backup/api-ref/Resource/index.md) resource or the [ResourceService/Delete](../backup/api-ref/grpc/Resource/delete.md) gRPC API call.

{% endlist %}
