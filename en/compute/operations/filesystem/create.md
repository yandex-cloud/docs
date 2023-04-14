# Creating file storage

To create file [storage](../../concepts/filesystem.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a file storage.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **File storage**.
   1. Click **Create file storage**.
   1. Name the storage.

      {% include [name-format-2](../../../_includes/name-format-2.md) %}

   1. (optional) Add a description.
   1. Select an [availability zone](../../../overview/concepts/geo-scope.md): either `{{ region-id }}-a` or `{{ region-id }}-b`. You can only attach storage to virtual machines from the same availability zone.
   1. Select the [storage type](../../concepts/filesystem.md#types).

      {% note warning %}

      You can't change the availability zone and type of storage after you create it.

      {% endnote %}

   1. Specify the block and storage disk size.
   1. Click **Create**.

- API

   Use the [create](../../api-ref/Filesystem/create.md) REST API method for the [Filesystem](../../api-ref/Filesystem/index.md) resource or the [FilesystemService/Create](../../api-ref/grpc/filesystem_service.md#Create) gRPC API call.

{% endlist %}