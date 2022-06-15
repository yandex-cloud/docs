# Getting a list of disk images

To get a list of disk images:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where disk images are stored.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/image-pic.svg) **Images**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description on the CLI command for managing disk images:

      ```bash
      yc compute image --help
      ```

   1. Get a list of all the disks in the default folder:

      ```bash
      yc compute image list
      ```

      Output:

      ```bash
      +----------------------+-------------+--------+-------------+--------+
      |          ID          |    NAME     | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+-------------+--------+-------------+--------+
      | fd8n3spmksqmuraspf4h | first-image |        |             | READY  |
      +----------------------+-------------+--------+-------------+--------+
      ```

- API

   Use the gRPC API [ImageService/List](../../api-ref/grpc/image_service.md#List) or REST API [list](../../api-ref/Image/list.md) method.

{% endlist %}