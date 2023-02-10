# Moving a VM to another cloud

You can't move a VM to another cloud, but you create an image from its boot disk and then create a VM from this image in another cloud.

1. Use a boot disk of your VM to [create an image](../image-create/create-from-disk.md).
1. Get the boot disk image ID:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
      1. Select **{{ compute-name }}**.
      1. On the left-hand panel, select ![image](../../../_assets/compute/image-pic.svg) **Images**.
      1. Copy the value from the **ID** column of a relevant image.

   - CLI

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Get a list of all the disks in the default folder:

      ```bash
      yc compute image list
      ```

      Result:

      ```text
      +----------------------+----------------+--------+-------------+--------+
      |          ID          |    NAME        | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+----------------+--------+-------------+--------+
      | xc8n3spmksqmuraspf4h | original-image |        |             | READY  |
      +----------------------+----------------+--------+-------------+--------+
      ```

   - API

      Use the gRPC API [ImageService/List](../../api-ref/grpc/image_service.md#List) or REST API [list](../../api-ref/Image/list.md) method.

   {% endlist %}

1. Get an ID of the cloud hosting the folder with the image:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), click the desired cloud in the list on the left.
      1. On the **Overview** tab, copy the value from the **ID** field.

   - CLI

      Retrieve a list of clouds with their IDs:

      ```bash
      yc resource-manager cloud list
      ```

      Result:

      ```text
      +----------------------+------------+--------------------------+
      |          ID          |    NAME    |      ORGANIZATION ID     |
      +----------------------+------------+--------------------------+
      | b1g66mft1vopnevbn57j | my-cloud-1 |                          |
      | b1gd129pp9ha0vnvf5g7 | my-cloud-2 |                          |
      +----------------------+------------+--------------------------+
      ```

   - API

      To get the list of clouds with IDs, use the [list](../../../resource-manager/api-ref/Cloud/list.md) method for the [Cloud](../../../resource-manager/api-ref/Cloud/index.md) resource.

   {% endlist %}

1. [Add a user](../../../iam/operations/users/create.md) from the target cloud (where you want to move the VM instance) to the cloud hosting the folder with the source image.
1. [Assign](../../../iam/operations/roles/grant.md) the user the `{{ roles-cloud-member }}` and `{{ roles-image-user }}` roles for the cloud.
1. Create a new image in the target cloud:

   {% list tabs %}

   - CLI

      ```bash
      yc compute image create \
        --name <new_image_name> \
        --source-image-id <source_image_ID> \
        --cloud-id <source_cloud_ID>
      ```

   {% endlist %}

1. In the target cloud, [create a VM](../vm-create/create-from-user-image.md) from the image you created.
