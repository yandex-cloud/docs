# Creating file storage

To create [file storage](../../concepts/filesystem.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your file storage.
  1. Select **{{ compute-name }}**.
  1. Go to the **File storages** tab.
  1. Click **Create file storage**.
  1. Name the storage.

     {% include [name-format-2](../../../_includes/name-format-2.md) %}

  1. (optional) Add a description.
  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) for your storage. You can only attach it to VMs from the same availability zone.
  1. Select the [storage type](../../concepts/filesystem.md#types).

     {% note warning %}

     You can't change the availability zone and type of storage after you create it.

     {% endnote %}

  1. Specify the block and storage disk size.
  1. Click **Create**.

- API

  Use the [FilesystemService/Create](../../api-ref/grpc/filesystem_service.md#Create) method of the gRPC API or the [create](../../api-ref/Filesystem/create.md) method of the Filesystem resource in the REST API.

{% endlist %}

