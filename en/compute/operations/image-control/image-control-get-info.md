---
title: "How to get information about a disk image in {{ compute-full-name }}"
---

# Getting information about a disk image

{% list tabs %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing your disk [image](../../concepts/image.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
  1. Select the image you need.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the image details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about a disk [image](../../concepts/image.md):

      ```bash
      yc compute image get --help
      ```

  1. Get information about your disk image by specifying its name or ID:

      ```bash
      yc compute image get <image_name>
      ```

      Result:

      ```text
      id: fd8orln8oii5********
      folder_id: b1g72vbihiut********
      created_at: "2023-05-19T06:46:14Z"
      name: image-ubuntu-20-04
      description: ubuntu-20.04.6-live-server-amd64
      min_disk_size: "1488977920"
      status: READY
      os:
        type: LINUX
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a disk [image](../../concepts/image.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_image" "my_image" {
        image_id = "<image_ID>"
      }
      output "image" {
        value = data.yandex_compute_image.my_image.min_disk_size
      }
      ```

      Where:

      * `data "yandex_compute_image"`: Describes the disk image as the data source:
        * `image_id`: Disk image ID.
      * `output "image"`: Output variable that contains information about the minimum disk size:
        * `value`: Returned value.

      You can replace `min_disk_size` with any other parameter to get the information you need. For more information about the `yandex_compute_image` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/datasource_compute_image).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      image = "20"
      ```

- API {#api}

  To get detailed information about a disk [image](../../concepts/image.md), use the [get](../../api-ref/Image/get.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Get](../../api-ref/grpc/image_service.md#Get) gRPC API call.

{% endlist %}
