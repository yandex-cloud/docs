# Deleting file storage

1. [Detach file storage](detach-from-vm.md) from all the VMs it's attached to.
1. Delete file storage in {{ compute-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where your file store is located.
      1. Select **{{ compute-name }}**.
      1. On the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **File storage**.
      1. In the row of the desired file storage, click ![image](../../../_assets/options-grey.svg) and select **Delete**.
      1. In the window that opens, click **Delete**.

   - API

      Use the [delete](../../api-ref/Filesystem/delete.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Delete](../../api-ref/grpc/filesystem_service.md#Delete) gRPC API call.

   {% endlist %}