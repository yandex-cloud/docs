# Updating file storage

After creating file storage, you can change its name, description, and size.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your file store is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **File storage**.
   1. In the row with the desired file storage, select ![image](../../../_assets/options-grey.svg) and the **Edit** option.
   1. Change the file storage parameters, for example, rename it by editing the **Name** field.
   1. Click **Save**.

- API

   Use the [FilesystemService/Update](../../api-ref/grpc/filesystem_service.md#Update) gRPC API method or the [update](../../api-ref/Filesystem/update.md) method of the REST API Filesystem resource.

{% endlist %}