# Creating an image from another custom image

To create an image from another user image:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create the image.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/image-pic.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
   1. In the line with the appropriate snapshot, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.images.button_action-image }}**.
   1. Enter the image name.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If required, provide a text description for the image.
   1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create an image:

      ```
      yc compute image create --help
      ```

   1. Get a list of images in the default folder:

      {% include [compute-image-list](../../../_includes/compute/image-list.md) %}

   1. Select the ID (`ID`) or the name (`NAME`) of the desired snapshot.
   1. Create an image in the default folder:

      ```
      yc compute image create \
        --name new-image \
        --source-image-name first-image \
        --description "new image via yc"
      ```

      This command will create an image named `new-image` and the description `new image via yc` from the `first-image` image.

      To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), use the `--pooled` flag:

      ```
      yc compute image create \
        --name new-image \
        --source-image-name first-image \
        --description "new image via yc" \
        --pooled
      ```

- API

   1. Get the list of images using the [list](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/image_service.md#List) gRPC API call.
   1. Create a new image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/image_service.md#Create) gRPC API call. In your request, specify the source image ID.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the resource parameters in the `yandex_compute_image` configuration file.

      Example of the configuration file structure:

      ```
      resource "yandex_compute_image" "image-1" {
        name         = "<image name>"
        source_image = "<source image ID>"
      }
      ```

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. Run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

{% endlist %}

After creation, the image will have the `CREATING` status. Wait until the image status changes to `READY` before using it.
