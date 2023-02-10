# Creating an image from other custom image

To create an image from another user image:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create the image.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/image-pic.svg) **Images**.
   1. In the row with the desired snapshot, click ![image](../../../_assets/horizontal-ellipsis.svg) and select the **Create image** command from the menu.
   1. Enter the image name.

      * Its length can be from 2 to 63 characters.
      * It may contain lowercase Latin letters, numbers, and hyphens.
      * The first character must be a letter. The last character can't be a hyphen.

   1. If required, provide a free-form text description for the image.
   1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **Optimize for deployment**.
   1. Click **Create**.

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

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the resource parameters in the `yandex_compute_image` configuration file.

      Example configuration file structure:

      ```
      resource "yandex_compute_image" "image-1" {
        name         = "<image name>"
        source_image = "<source image ID>"
      }
      ```

      For more information about resources that you can create with {{ TF }}, please see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. Run the command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

- API

   1. Retrieve a list of images using the [ImageService/List](../../api-ref/grpc/image_service.md#List) grPC API method or the [list](../../api-ref/Image/list.md) method of the REST API `Image` resource.
   1. Create a new image using the [ImageService/Create](../../api-ref/grpc/image_service.md#Create) method of the gRPC API or the [Create](../../api-ref/Image/create.md) method of the REST API `Image` resource. In your request, specify the source image ID.

{% endlist %}

After creation, the image will have the `CREATING` status. Wait until the image status changes to `READY` before using it.
