---
title: How to get information about a public image in {{ compute-full-name }}
description: Follow this guide to get information about a public image.
---

# Getting information about a public image

You can get a public image ID or other information about it.

## Getting a public image ID {#get-id}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a virtual machine in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
  1. In the list that opens, select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, click ![image](../../../_assets/console-icons/circle-info.svg) next to the [public image](../../concepts/image.md#public) you need.
  1. Under **Product IDs**, you will see the public image ID: **image_id**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about a [public image](../../concepts/image.md#public) of a disk:

      ```bash
      yc compute image get --help
      ```

  1. Get the public image ID by specifying the operating system [family](../../concepts/image.md#family) name:

      ```bash
      yc compute image get-latest-from-family <family_name> --folder-id standard-images
      ```

      To learn the image family name, [get](#get-info) a list of images in the folder.

      Result:

      ```text
      id: fd85u0rct32prepgjlv0
      folder_id: standard-images
      created_at: "2024-03-11T10:57:40Z"
      name: ubuntu-22-04-lts-v20240311
      description: ubuntu 22.04 lts
      family: ubuntu-2204-lts
      storage_size: "7633633280"
      min_disk_size: "8589934592"
      product_ids:
        - f2ef01lju2nsansfdahf
      status: READY
      os:
        type: LINUX
      pooled: true
      ```

      You will find the public image ID in the `id` row.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get a [public image](../../concepts/image.md#public) ID using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_image" "ubuntu_image" {
        family = "<family_name>"
      }

      output "ubuntu_id" {
        value = data.yandex_compute_image.my_image.image_id
      }
      ```

      Where:

      * `data "yandex_compute_image"`: Description of the public image as a data source:
        * `family`: [Family](../../concepts/image.md#family) name of public image operating systems. To learn the image family name, [get](#get-info) a list of images in the folder.
      * `output "image"`: Output variable containing the public image ID:
        * `value`: Returned value.

      For more information about the `yandex_compute_image` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_compute_image).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      image = "fd85u0rct32prepgjlv0"
      ```

- API {#api}

  To get a [public image](../../concepts/image.md#public) ID, use the [get](../../api-ref/Image/get.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Get](../../api-ref/grpc/Image/get.md) gRPC API call.

{% endlist %}

## Getting information about a public image {#get-info}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a virtual machine in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
  1. In the list that opens, select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, click ![image](../../../_assets/console-icons/circle-info.svg) next to the [public image](../../concepts/image.md#public) you need.
  1. The window that opens will display information about the public image.
  1. To view all available public images, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about a [public image](../../concepts/image.md#public):

      ```bash
      yc compute image get --help
      ```

  1. Get information about a public image by specifying its ID:

      ```bash
      yc compute image get <image_ID>
      ```

      To find out the image ID, [get](#get-id) a list of images in the folder.

      Result:

      ```text
      id: fd89ls0nj4oqmlhhi568
      folder_id: standard-images
      created_at: "2024-04-29T10:58:27Z"
      name: ubuntu-2204-lts-oslogin-v20240429
      description: Ubuntu 22.04 OsLogin
      family: ubuntu-2204-lts-oslogin
      storage_size: "7511998464"
      min_disk_size: "10737418240"
      product_ids:
        - f2e48vn7nr04r2bpg4eg
      status: READY
      os:
        type: LINUX
      pooled: true
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [public image](../../concepts/image.md#public) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_image" "my_image" {
        image_id = "<image_ID>"
      }
      output "image" {
        value = data.yandex_compute_image.my_image.family
      }
      ```

      Where:

      * `data "yandex_compute_image"`: Description of the public image as a data source:
        * `image_id`: Public image ID. To find out the image ID, [get](#get-id) a list of images in the folder.
      * `output "image"`: Output variable containing information about the OS [family](../../concepts/image.md#family):
        * `value`: Returned value.

      Instead of `family` you can select any other parameter to get the information you need. For more information about the `yandex_compute_image` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_compute_image).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      image = "ubuntu-2204-lts"
      ```

- API {#api}

  To get detailed information about a [public disk image](../../concepts/image.md#public), use the [get](../../api-ref/Image/get.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Get](../../api-ref/grpc/Image/get.md) gRPC API call.

{% endlist %}

You can also view information about all available public images in [{{ marketplace-name }}]({{ link-cloud-marketplace }}).