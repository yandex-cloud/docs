# Getting a list of public images

When creating a VM, you need to select its [image](../../concepts/image.md) with the software that you want to use.

{% list tabs %}

- Management console

   You can view a list of public images when creating a virtual machine:

   1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
   1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
   1. In the list that opens, select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, click **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-os-products }}**. A list of all available public images will appear.

   To view information about a specific image, click ![image](../../../_assets/compute/info.svg).

- CLI

   {% include [standard-images](../../../_includes/standard-images.md) %}

- API

   1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for authentication in these examples:
      * [Instructions](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
      * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
      * [Instructions](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.
   1. Get the list of public images from {{ yandex-cloud }} using the [list](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/image_service.md#List) gRPC API call. In the request, specify the following parameters:
      * Specify `standard-images` as the folder ID.
      * The folder contains many images, so specify `pageSize=1000` or use the obtained value of `nextPageToken` to get the next page.

   Write the result to a file, for example `output.json`:

   ```bash
   export IAM_TOKEN=CggaATEVAgA...
   curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.{{ api-host }}/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
   ```

{% endlist %}

You can also view information about all available public images in [{{ marketplace-name }}](/marketplace).
