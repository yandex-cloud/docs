# Deleting file storage

1. [Detach file storage](detach-from-vm.md) from all the VMs it's attached to.

1. Delete file storage in {{ compute-name }}:

   {% list tabs %}

   - Management console
     1. In the management console, select the folder where your file store is located.
     1. Select **{{ compute-name }}**.
     1. Go to the **File storages** tab.
     1. In the appropriate file storage line, click ![image](../../../_assets/dots.svg) and select **Delete**.
     1. In the window that opens, confirm the deletion.

   - API

     Use the [FilesystemService/Delete](../../api-ref/grpc/filesystem_service.md#Delete) method of the gRPC API or the [delete](../../api-ref/Filesystem/delete.md) method of the Filesystem resource in the REST API.

   {% endlist %}

