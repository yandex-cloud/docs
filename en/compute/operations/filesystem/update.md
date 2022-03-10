# Updating file storage

After creating file storage, you can change its name, description, and size.

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where your file storage is located.
  1. Select **{{ compute-name }}**.
  1. Go to the **File storages** tab.
  1. In the appropriate file storage line, click ![image](../../../_assets/options-grey.svg) and select **Edit**.
  1. Change the file storage parameters, for example, rename it by editing the **Name** field.
  1. Click **Save**.

- API

  Use the [FilesystemService/Update](../../api-ref/grpc/filesystem_service.md#Update) method of the gRPC API or the [update](../../api-ref/Filesystem/update.md) method of the Filesystem resource in the REST API.

{% endlist %}

