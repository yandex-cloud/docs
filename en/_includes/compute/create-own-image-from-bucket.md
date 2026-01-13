Create a new image using the link you got in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an image.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
  1. Click **{{ ui-key.yacloud.compute.images.button_upload }}**, and in the window that opens:

      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the image. Follow these naming requirements:

          {% include [name-format](../name-format.md) %}

      1. Optionally, in the **{{ ui-key.yacloud.common.description }}** field, add a description of the new image.
      1. In the **{{ ui-key.yacloud.compute.images.popup-upload_field_url }}** field, paste the image file link you got in {{ objstorage-name }} earlier.
      1. In the **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** field, select the hardware generation for the virtual machines created from your image. For more information about the available options, see [{#T}](../../compute/concepts/hardware-generations.md).

          {% note alert %}

          If you select `Gen 2`, make sure the bootloader in your image supports [UEFI](https://en.wikipedia.org/wiki/UEFI) and [GPT](https://en.wikipedia.org/wiki/GUID_Partition_Table). Otherwise, VMs will not be able to boot the operating system.

          {% endnote %}

      1. To enable image [optimization](../../compute/concepts/image.md#images-optimized-for-deployment) for deployment, enable the **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}** option.
      1. Click **{{ ui-key.yacloud.common.button_upload }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To create a new image via the link, run the following command:

  ```bash
  yc compute image create \
    --name <image_name> \
    --source-uri <image_URL> \
    --pooled
  ```

  Where:
  * `--name`: Name to assign to the image. Follow these image naming requirements:

      {% include [name-format](../name-format.md) %}
  
  * `--source-uri`: Image link you got in {{ objstorage-name }}.
  * `--pooled`: Enables image [optimization](../../compute/concepts/image.md#images-optimized-for-deployment) for deployment. This is an optional setting. By default, the optimization is disabled.

  Add a description as required and specify the [family](../../compute/concepts/image.md#family) the image belongs to:

  ```bash
  yc compute image create \
    --name ubuntu-cosmic \
    --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
    --family ubuntu \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  If you know the minimum required size of a [disk](../../compute/concepts/disk.md) to create from this image, specify it in GB:

  ```bash
  yc compute image create \
    --name big-image \
    --min-disk-size 20 \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  {% include [min-disk-size](../../compute/_includes_service/min-disk-size.md) %}

  If you want to create an image with the `Gen 1.2` VM hardware [generation](../../compute/concepts/hardware-generations.md) assigned:

  ```bash
  yc compute image create \
    --name gen12-image \
    --description "Ubuntu Server Hardware Generation Gen 1.2" \
    --hardware-generation-id legacy \
    --hardware-features pci_topology=v2 \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  If you want to create an image with the `Gen 2` VM hardware generation assigned:

  ```bash
  yc compute image create \
    --name gen2-image \
    --description "Ubuntu Server Hardware Generation Gen 2" \
    --hardware-generation-id generation2 \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  For more information about the `yc compute image create` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/image/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create an image:
  1. Specify the parameters of the `yandex_compute_image` resource in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<image_name>"
        os_type              = "LINUX"
        source_url           = "<image_link>"
        pooled               = "false"

        hardware_generation {
          generation2_features {}
          legacy_features {
            pci_topology = "PCI_TOPOLOGY_V1|PCI_TOPOLOGY_V2"
          }
        }
      }
      ```

      Where:
      * `name`: Name to assign to the image. Follow these image naming requirements:
      
          {% include [name-format](../name-format.md) %}

      * `source_url`: Image link in {{ objstorage-name }}.
      * `pooled`: Enables image [optimization](../../compute/concepts/image.md#images-optimized-for-deployment) for deployment. The possible values are:
      
          * `true`: Optimization enabled.
          * `false`: Optimization disabled.
          
          This is an optional setting. By default, the optimization is disabled.
      * `hardware_generation`: VM [hardware generation](../../compute/concepts/hardware-generations.md) configuration:

          * `generation2_features`: Parameter that assigns the `Gen 2` hardware generation to the new image. This is an optional setting. You cannot use this parameter together with `legacy_features`.
          * `legacy_features`: Parameter to assign the `Gen 1.2` hardware generation to the new image. You cannot use this parameter together with `generation2_features`.

              * `pci_topology`: PCI topology configuration. The possible values are:

                  * `PCI_TOPOLOGY_V1`: Matches the `Gen 1.1` hardware generation.
                  * `PCI_TOPOLOGY_V2`: Matches the `Gen 1.2` hardware generation.
          The `hardware_generation` configuration section is optional. If it is not specified, `Gen 1.1` will be assigned to the new image.
      For detailed information about the `yandex_compute_image` resource parameters, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_image).
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check new resources in the [management console]({{ link-console-main }}) or using this CLI command:

      ```bash
      yc compute image list
      ```

- API {#api}

  Create a new image using the [create](../../compute/api-ref/Image/create.md) REST API method for the [Image](../../compute/api-ref/Image/index.md) resource or the [ImageService/Create](../../compute/api-ref/grpc/Image/create.md) gRPC API call. In the request, specify the image link you got in {{ objstorage-name }}.

  By default, the `Gen 1.1` [hardware generation](../../compute/concepts/hardware-generations.md) is assigned to newly created images.

  To create an image with the `Gen 1.2` hardware generation assigned, provide the following object in the request body:

  ```json
  ...
  "hardwareGeneration": {
    "legacyFeatures": {
      "pciTopology": "PCI_TOPOLOGY_V2"
    }
  }
  ...
  ```

  To create an image with the `Gen 2` hardware generation assigned, provide the following object in the request body:

  ```json
  ...
  "hardwareGeneration": {
    "generation2Features": {}
  }
  ...
  ```

{% endlist %}

Once created, the image will get the `CREATING` status. Wait until its status changes to `READY` before using it.