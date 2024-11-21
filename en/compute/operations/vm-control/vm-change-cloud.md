# Moving a VM to another cloud

You cannot move a VM to another cloud; however, you can create an image from its boot disk and then create a VM from this image in another cloud.

1. Use a boot disk of your VM to [create an image](../image-create/create-from-disk.md).
1. Get the boot disk image ID:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder the disk image is in.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
     1. Copy the value from the **{{ ui-key.yacloud.common.id }}** column of a relevant image.

   - CLI {#cli}

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
     | xc8n3spmksqm******** | original-image |        |             | READY  |
     +----------------------+----------------+--------+-------------+--------+
     ```

   - API {#api}

     Use the [list](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/Image/list.md) gRPC API call.

   {% endlist %}

1. Get an ID of the cloud hosting the folder with the image:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), click the cloud in the list on the left.
     1. On the **{{ ui-key.yacloud.iam.cloud.switch_overview }}** tab, copy the value from the **{{ ui-key.yacloud.common.id }}** field.

   - CLI {#cli}

     Retrieve a list of clouds with their IDs:

     ```bash
     yc resource-manager cloud list
     ```

     Result:

     ```text
     +----------------------+------------+--------------------------+
     |          ID          |    NAME    |      ORGANIZATION ID     |
     +----------------------+------------+--------------------------+
     | b1g66mft1vop******** | my-cloud-1 |                          |
     | b1gd129pp9ha******** | my-cloud-2 |                          |
     +----------------------+------------+--------------------------+
     ```

   - API {#api}

     To get the list of clouds with IDs, use the [list](../../../resource-manager/api-ref/Cloud/list.md) REST API method for the [Cloud](../../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/List](../../../resource-manager/api-ref/grpc/Cloud/list.md) gRPC API call.

   {% endlist %}

1. [Add a user](../../../iam/operations/users/create.md) from the target cloud (where you want to move the VM instance) to the cloud hosting the folder with the source image.
1. [Assign](../../../iam/operations/roles/grant.md) the target cloud user the `{{ roles-cloud-member }}` and `{{ roles-image-user }}` roles for the cloud hosting the folder with the source image.
1. Create a new image in the target cloud:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     yc compute image create \
       --name <new_image_name> \
       --source-image-id <source_image_ID> \
       --cloud-id <destination_cloud_ID> \
       --folder-id <destination_folder_ID>
     ```

   - API {#api}

     Use the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call. Specify the image ID in your request.

   {% endlist %}

1. In the target cloud, [create a VM](../vm-create/create-from-user-image.md) from the image you created.
