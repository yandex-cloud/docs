# Deleting file storage

1. [Detach file storage](detach-from-vm.md) from all the VMs it's attached to.
1. Delete file storage in {{ compute-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where your file store is located.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
      1. In the line of the appropriate file storage, click ![image](../../../_assets/options-grey.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

   - API

      Use the [delete](../../api-ref/Filesystem/delete.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Delete](../../api-ref/grpc/filesystem_service.md#Delete) gRPC API call.

   {% endlist %}