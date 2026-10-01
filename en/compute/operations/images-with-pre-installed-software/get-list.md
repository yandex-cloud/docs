---
title: How to get information about a public image in {{ compute-full-name }}
description: Follow this guide to get information about a public image in {{ compute-full-name }}.
---

# Getting public image info

When creating a VM instance, you need to select an [image](../../concepts/image.md) with the software you want to use.

## Getting a list of public images {#get-list}

To get a list of [public images](../../concepts/image.md#public) in {{ compute-full-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  You can view a list of public images when creating a virtual machine:

  1. In the [management console]({{ link-console-main }}), open the folder where you want to create your VM.
  1. [Navigate]({{ link-console-main }}/link/compute) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. You will see a list of all available public images.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  A list of public images resides in the **standard-images** folder.

  * Get a list of all public images.
  
      {% include [standard-images](../../../_includes/standard-images.md) %}

      {% note info %}

      By default, the command returns only the first 1,000 images. To view the full list of images, include the `--limit 0` parameter.

      {% endnote %}

  * {% include [standard-images](../../../_includes/compute/list-image-families-cli.md) %}  
  * Get a list of available public images belonging to a particular family:

      ```bash
      yc compute image list \
        --folder-id standard-images \
        | grep <family_ID>
      ```

      Where `<family_ID>` is the image family ID, e.g., `ubuntu-2204-lts-oslogin`.

      Result:

      ```text
      ...
      | fd827n44qr0q******** | ubuntu-2204-lts-oslogin-v20240617 | ubuntu-2204-lts-oslogin | f2eofgd2cj0e******** | READY |
      | fd827ukfjohd******** | ubuntu-2204-lts-oslogin-v20240701 | ubuntu-2204-lts-oslogin | f2evubhrcfsh******** | READY |
      | fd82sdt0b96a******** | ubuntu-2204-lts-oslogin-v20240304 | ubuntu-2204-lts-oslogin | f2ecb2d55npl******** | READY |
      ...
      ```

  For more information about the `yc compute image list` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/image/list.md).

- API {#api}

  1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) used for authentication in these examples:

      * [Guide](../../../iam/operations/iam-token/create.md) for a Yandex account user.
      * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
      * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.
      * [Guide](../../../iam/operations/iam-token/create-for-local.md) for a local account.
  1. To get a list of {{ yandex-cloud }} public images, use the [List](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/Image/list.md) gRPC API call. In your request, specify the following parameters:

      * Specify `standard-images` as the folder ID.
      * The folder contains many images, so specify `pageSize=1000` or use the obtained value of `nextPageToken` to get the next page.
      * Write the result to a file, e.g., `output.json`.

      **Request example:**

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://compute.{{ api-host }}/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
      ```

      {% note info %}

      To only write info about a specific [image family](../../concepts/image.md#family) to a file, use `grep`.

      {% endnote %}

{% endlist %}

You can also view information about all available public images in [{{ marketplace-name }}](/marketplace).

## Getting detailed information about a public image {#get-info}

  To get detailed information about a [public image](../../concepts/image.md#public), including its ID:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/compute) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
  
      You will see a list of all available public images.
  1. In the list that opens, select the public image you need. If required, use the search bar or filter.

      The action will open a window with detailed information about the public image. The image ID is displayed at the bottom of the page under **{{ ui-key.yacloud_components.marketplace.label_product-ids }}** in the **{{ ui-key.yacloud_components.marketplace.related-products_row_vm }}** field.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. See the description of the CLI command for getting information about a [public image](../../concepts/image.md#public):

      ```bash
      yc compute image get --help
      ```
  1. Get image info by specifying its ID:

      ```bash
      yc compute image get <image_ID>
      ```

      Result:

      {% include [standard-images](../../../_includes/compute/image-get-cli-result.md) %}

      The public image ID is specified in the `id` field.
  1. {% include [standard-images](../../../_includes/compute/list-image-families-cli.md) %}
  1. Get information about the latest public image within a specific image family by specifying the family ID you obtained in the previous step:

      ```bash
      yc compute image get-latest-from-family <family_ID> \
        --folder-id standard-images
      ```

      Result:

      {% include [standard-images](../../../_includes/compute/image-get-cli-result.md) %}

      The public image ID is specified in the `id` field.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get public image info using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_image" "my_image" {
        family = "<family_name>"
      }

      output "image" {
        value = data.yandex_compute_image.my_image
      }
      ```

      Where:

      * `data "yandex_compute_image"`: Description of the public image as a data source:

          * `family`: ID of the [image family](../../concepts/image.md#family) the image belongs to.

              To get the image family ID, use the `yc compute image list` {{ yandex-cloud }} CLI [command](../../../cli/cli-ref/compute/cli-ref/image/list.md). For more information, see [{#T}](#get-list).

      * `output "instance_domain"`: Output variable that contains information about the latest public image in this family:
        * `value`: Return value.

      For more on the properties of the `yandex_compute_image` data source, see [this provider guide]({{ tf-provider-datasources-link }}/compute_image).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      image = {
        "created_at" = "2026-08-10T18:33:51Z"
        "description" = "Ubuntu 24.04 lts with oslogin  v20260807040314"
        "family" = "ubuntu-2404-lts-oslogin"
        "folder_id" = "standard-images"
        "hardware_generation" = tolist([
          {
            "generation2_features" = tolist([])
            "legacy_features" = tolist([
              {
                "pci_topology" = "PCI_TOPOLOGY_V2"
              },
            ])
          },
        ])
        "id" = "fd8udtumfhpr********"
        "image_id" = "fd8udtumfhpr********"
        "kms_key_id" = tostring(null)
        "labels" = tomap({
          "version" = "20260807040314"
          "x-hopper-operation-id" = "d9pm50s8l14n********"
          "x-hopper-source-image-id" = "fd8go5if6b3c********"
        })
        "min_disk_size" = 10
        "name" = "ubuntu-2404-lts-oslogin-v20260810"
        "os_type" = "linux"
        "pooled" = true
        "product_ids" = toset([
          "f2e00cd2gepc********",
        ])
        "size" = 2
        "status" = "ready"
      }
      ```

      The public image ID is specified in the `image_id` field.

- API {#api}

  To get detailed information about an image by its ID, use the [Get](../../api-ref/Image/get.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Get](../../api-ref/grpc/Image/get.md) gRPC API call.

  To get detailed information about the latest image within an [image family](../../concepts/image.md#family), use the [GetLatestByFamily](../../api-ref/Image/getLatestByFamily.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/GetLatestByFamily](../../api-ref/grpc/Image/getLatestByFamily.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/image.md)
