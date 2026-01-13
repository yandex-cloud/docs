---
title: How to create a VM with Gen 2 hardware
description: Follow this guide to create a VM running on virtualized Gen 2 hardware.
---

# Creating a VM with Gen 2 hardware

The [VM](../../concepts/vm.md) runs on virtualized hardware of the [generation](../../concepts/hardware-generations.md) [assigned](../../concepts/hardware-generations.md#locking-generations) to the medium (i.e., [image](../../concepts/image.md), [snapshot](../../concepts/snapshot.md), or [disk](../../concepts/disk.md)) the VM was created based on.

Therefore, to create a VM running on `Gen 2` hardware, you must first create a medium with `Gen 2` assigned, and then create your [VM](#create-vm) from this medium.

To create a VM running on virtualized `Gen 2` hardware, proceed as follows:

1. Prepare a medium of one of these types: [image](#create-image), [snapshot](#create-snapshot), or [disk](#create-disk).
1. [Create a VM from the medium you prepared](#create-vm).

## Create an image with the Gen 2 hardware generation assigned {#create-image}

You can create a VM image with the `Gen 2` hardware generation assigned either from your own image [pre-uploaded](#upload-own-image) to {{ yandex-cloud }} or from [existing](#create-image-from-existing-source) images, snapshots, and disks available in {{ yandex-cloud }}.

### Upload your disk image to {{ yandex-cloud }} {#upload-own-image}

You can upload your own UEFI and GPT-enabled VM image to {{ compute-name }} to create VMs running on `Gen 2` hardware. You can create an image in {{ compute-name }} from a prepared image file uploaded to [{{ objstorage-full-name }}](../../../storage/index.yaml).

#### Prepare an image file {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

{% include [available-image-format](../../../_includes/compute/available-image-format.md) %}

For configuration steps, see [{#T}](../image-create/custom-image.md).

#### Upload the image file to {{ objstorage-name }} {#upload-file}

{% include [image-file-upload-to-bucket](../../../_includes/compute/image-file-upload-to-bucket.md) %}

#### In {{ compute-name }}, create an image with the Gen 2 hardware generation assigned {#create-image-from-link}

To create a new image using the link you got in [{{ objstorage-name }}](../../../storage/index.yaml):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create the image.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![layers](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
  1. Click **{{ ui-key.yacloud.compute.images.button_upload }}**, and in the window that opens:

      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the image. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Optionally, in the **{{ ui-key.yacloud.common.description }}** and **{{ ui-key.yacloud.component.label-set.label_labels }}** fields, add a description and [labels](../../../resource-manager/concepts/labels.md) for the new image.
      1. In the **{{ ui-key.yacloud.compute.images.popup-upload_field_url }}** field, paste the image file link you got in {{ objstorage-name }} earlier.
      1. In the **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** field, select the `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}` [hardware generation](../../concepts/hardware-generations.md).
      1. To enable image [optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment, expand **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** and enable the **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}** option.
      1. Click **{{ ui-key.yacloud.common.button_upload }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the {{ yandex-cloud }} CLI command for creating an image:

      ```bash
      yc compute image create --help
      ```
  1. To create a new image with the `Gen 2` hardware generation assigned using a link, run this command:

      ```bash
      yc compute image create \
        --name <image_name> \
        --source-uri "<image_URL>" \
        --hardware-generation-id generation2 \
        --pooled
      ```

      Where:
      * `--name`: Name to assign to the image. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}
      
      * `--source-uri`: Image link you got in {{ objstorage-name }}.
      * `--pooled`: Enables image [optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment. This is an optional setting. By default, the optimization is disabled.

      Result:

      ```bash
      done (12s)
      id: fd86a13e6ro9********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T16:26:46Z"
      name: my-own-gen2-image
      storage_size: "1891631104"
      min_disk_size: "1891631104"
      status: READY
      os:
        type: LINUX
      hardware_generation:
        generation2_features: {}
      ```

  For more information about the `yc compute image create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/image/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create an image:
  1. Specify the parameters of the `yandex_compute_image` resource in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<image_name>"
        source_url           = "<image_link>"
        pooled               = "true|false"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Where:
      * `name`: Name to assign to the image. Follow these naming requirements:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * `source_url`: Image link in {{ objstorage-name }}.
      * `pooled`: Enables image [optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment. The possible values are:
      
          * `true`: Optimization enabled.
          * `false`: Optimization disabled.
          
          This is an optional setting. By default, the optimization is disabled.

      For detailed information about the `yandex_compute_image` resource parameters, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_image).
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check new resources in the [management console]({{ link-console-main }}) or using this CLI command:

      ```bash
      yc compute image list
      ```

- API {#api}

  Use the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call.

  For example, to create an image with the `Gen 2` hardware generation assigned using REST API:

  1. Install [cURL](https://curl.haxx.se).
  1. Get an [{{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md) used for API authentication:
      * [Guide](../../../iam/operations/iam-token/create.md) for a Yandex account user
      * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a [service account](../../../iam/concepts/users/service-accounts.md)
      * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account
      * [Guide](../../../iam/operations/iam-token/create-for-local.md) for a local account
  1. For your request to run smoothly, save the IAM token you got to the `IAM_TOKEN` environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. Create a file containing the body of your image create request (e.g., `body.json`) and add the following code to it:

      **body.json**

      ```json
      {
        "folderId": "<folder_ID>",
        "name": "<image_name>",
        "uri": "<link_to_uploaded_image>",
        "pooled": "true|false",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Where:

      * `folderId`: [ID](../../../resource-manager/operations/folder/get-id.md) of the image folder.
      * `name`: Image name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `uri`: Image link in {{ objstorage-name }}.
      * `pooled`: Enables [image optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment. The possible values are:
      
          * `true`: Optimization enabled.
          * `false`: Optimization disabled.

          This is an optional setting. By default, the optimization is disabled.

  1. Run this http request:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/images
      ```

      Result:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateImageMetadata",
        "imageId": "fd8g5p4hllq8********"
      },
      "id": "fd8m1tfm92kr********",
      "description": "Create image",
      "createdAt": "2025-12-05T16:41:54.452564354Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T16:41:54.452564354Z"
      }
      ```

{% endlist %}

After you create the image, you can [delete](../../../storage/operations/objects/delete.md) the original file from the bucket.

### Creating a disk image with the Gen 2 hardware generation assigned from another image, snapshot, or disk {#create-image-from-existing-source}

By default, a newly created image is assigned the [hardware generation](../../concepts/hardware-generations.md) [assigned](../../concepts/hardware-generations.md#locking-generations) to the original image, snapshot, or disk the image was created from. However, you can explicitly specify a hardware generation different from that assigned to the original image, snapshot, or disk.

[Public images](../../concepts/image.md#public) available for installation on VMs in [{{ marketplace-full-name }}](/marketplace) get `Gen 1.1` or `Gen 1.2` assigned by default. At the same time, some public images (e.g., those running Linux [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts)) support `Gen 2` hardware with [UEFI](https://en.wikipedia.org/wiki/UEFI) boot and the [GPT](https://en.wikipedia.org/wiki/GUID_Partition_Table) partition table; you can use such images to create a disk or an image of your own with `Gen 2` assigned. Other public images do not support UEFI boot, so you cannot use them to create a VM running on `Gen 2` hardware.

{% note info %}

You can create a new image with the `Gen 2` hardware generation assigned from a [public image](../../concepts/image.md#public) in [{{ marketplace-full-name }}](/marketplace) only with the help the [{{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/image/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/compute_image), or [API](../../api-ref/Image/create.md).

{% endnote %}

To create an image from an existing [image](../../concepts/image.md), [snapshot](../../concepts/snapshot.md), or [disk](../../concepts/disk.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an image.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Depending on the source you want to create the new image from, select ![archive](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.compute.storage_uisyT }}**, ![picture](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**, or ![layers](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}** in the left-hand panel.
  1. Depending on the source type you selected, in the list that opens, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the image, snapshot, or disk, and select ![layers](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.disks.button_action-image }}**. In the window that opens:

      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the new image. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Optionally, in the **{{ ui-key.yacloud.common.description }}** and **{{ ui-key.yacloud.component.label-set.label_labels }}** fields, add a description and [labels](../../../resource-manager/concepts/labels.md) for the new image.
      1. Expand the **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** section and select `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}` in the **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** field.

          {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

      1. To enable image [optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment, enable the **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}** option.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

  1. See the description of the {{ yandex-cloud }} CLI command for creating an image:

      ```bash
      yc compute image create --help
      ```

  1. To create a new image with the `Gen 2` hardware generation assigned from an existing [image](../../concepts/image.md), [snapshot](../../concepts/snapshot.md), or [disk](../../concepts/disk.md), run this command:

      ```bash
      yc compute image create \
        --name <image_name> \
        --source-image-id <source_image_ID> \
        --source-snapshot-id <source_snapshot_ID> \
        --source-disk-id <source_disk_ID> \
        --hardware-generation-id generation2 \
        --pooled
      ```

      Where:
      * `--name`: Name to assign to the image. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * Selecting a source for your image:

          * `--source-image-id`: Source image ID. Instead of the ID, you can provide its name in `--source-image-name`.
          * `--source-snapshot-id`: Source snapshot ID. Instead of the ID, you can provide its name in `--source-snapshot-name`.
          * `--source-disk-id`: Source disk ID. Instead of the ID, you can provide its name in `--source-disk-name`.

          {% note info %}

          `--source-image-id`, `--source-image-name`, `--source-snapshot-id`, `--source-snapshot-name`, `--source-disk-id`, and `--source-disk-name` are mutually exclusive: you can use only one of them in the command.

          {% endnote %}

      * `--pooled`: Enables image [optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment. This is an optional setting. By default, the optimization is disabled.

      Result:

      ```text
      done (9s)
      id: fd86kup8c7pa********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T06:57:09Z"
      name: my-sample-gen2-image
      storage_size: "9877585920"
      min_disk_size: "21474836480"
      product_ids:
        - f2ercusam4no********
      status: READY
      os:
        type: LINUX
      hardware_generation:
        generation2_features: {}
      ```

  For more information about the `yc compute image create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/image/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_image` resource in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<image_name>"
        source_image         = "<source_image_ID>"
        source_snapshot      = "<source_snapshot_ID>"
        source_disk          = "<source_disk_ID>"
        pooled               = "true|false"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

      Where:
      * `name`: Name to assign to the image. Follow these naming requirements:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * Selecting a source for your image:

          * `source_image`: Source image ID.
          * `source_snapshot`: Source snapshot ID.
          * `source_disk`: Source disk ID.

          {% note info %}

          `source_image`, `source_snapshot`, and `source_disk` are mutually exclusive: you can use only one of them in the configuration file.

          {% endnote %}

      * `pooled`: Enables image [optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment. The possible values are:
      
          * `true`: Optimization enabled.
          * `false`: Optimization disabled.
          
          This is an optional setting. By default, the optimization is disabled.

          For detailed information about the `yandex_compute_image` resource parameters, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_image).
          
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check new resources in the [management console]({{ link-console-main }}) or using this CLI command:

      ```bash
      yc compute image list
      ```

- API {#api}

  Use the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call.

  For example, to create an image with the `Gen 2` hardware generation assigned using REST API:

  1. Install [cURL](https://curl.haxx.se).
  1. Get an [{{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md) used for API authentication:
      * [Guide](../../../iam/operations/iam-token/create.md) for a Yandex account user
      * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a [service account](../../../iam/concepts/users/service-accounts.md)
      * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account
      * [Guide](../../../iam/operations/iam-token/create-for-local.md) for a local account
  1. For your request to run smoothly, save the IAM token you got to the `IAM_TOKEN` environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. Create a file containing the body of your image create request (e.g., `body.json`) and add the following code to it:

      **body.json**

      ```json
      {
        "folderId": "<folder_ID>",
        "name": "<image_name>",
        "imageId": "<source_image_ID>",
        "snapshotId": "<source_snapshot_ID>",
        "diskId": "<source_disk_ID>",
        "pooled": "true|false",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Where:

      * `folderId`: [ID](../../../resource-manager/operations/folder/get-id.md) of the image folder.
      * `name`: Image name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

      * Selecting a source for your image:

          * `imageId`: Source image ID.
          * `snapshotId`: Source snapshot ID.
          * `diskId`: Source disk ID.

          {% note info %}

          The `imageId`, `snapshotId`, and `diskId` fields are mutually exclusive: you can use only one of them in the request.

          {% endnote %}

      * `pooled`: Enables image [optimization](../../concepts/image.md#images-optimized-for-deployment) for deployment. The possible values are:
      
          * `true`: Optimization enabled.
          * `false`: Optimization disabled.

          This is an optional setting. By default, the optimization is disabled.

  1. Run this http request:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/images
      ```

      Result:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateImageMetadata",
        "imageId": "fd8j3jind4ij********"
      },
      "id": "fd8a7eged70b********",
      "description": "Create image",
      "createdAt": "2025-12-05T08:51:44.937021154Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T08:51:44.937021154Z"
      }
      ```

{% endlist %}

This will create an image with the `Gen 2` virtualized hardware [generation](../../concepts/hardware-generations.md) assigned.

## Create a disk snapshot with the Gen 2 hardware generation assigned {#create-snapshot}

You can snapshot the boot disk of an existing VM running on `Gen 1.1` or `Gen 1.2` generation virtualized hardware and assign the `Gen 2` generation hardware to this snapshot.

### Prepare the disk for a snapshot {#prepare-for-making-snapshot}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

### Create a snapshot {#create-snapshot-operation}

To create a disk snapshot with the `Gen 2` hardware generation assigned:

{% note info %}

You can assign to a snapshot a generation different from the one assigned to the source disk only using the [{{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/snapshot/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/compute_snapshot), or [API](../../api-ref/Snapshot/create.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating snapshots:

      ```bash
      yc compute snapshot create --help
      ```

  1. Create a snapshot in the default folder:

      ```bash
      yc compute snapshot create \
        --name <snapshot_name> \
        --disk-id <source_disk_ID> \
        --hardware-generation-id generation2
      ```

      Where:
      * `--name`: Snapshot name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--disk-id`: ID of the disk you are creating the snapshot for. Instead of the ID, you can provide its name in `--disk-name`.

      Result:

      ```text
      done (18s)
      id: fd8jnmpan5ff********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T14:10:15Z"
      name: my-gen2-snapshot
      storage_size: "3632267264"
      disk_size: "21474836480"
      product_ids:
        - f2ebiogvi127********
      status: READY
      source_disk_id: epd89t47vnhd********
      hardware_generation:
        generation2_features: {}
      ```

  For more information about the `yc compute snapshot create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/snapshot/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_snapshot` resource in the configuration file.

      Here is an example of the configuration file structure:
      
      ```hcl
      resource "yandex_compute_snapshot" "snapshot-1" {
        name                 = "<snapshot_name>"
        source_disk_id       = "<disk_ID>"
        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Where:
      * `name`: Name to assign to the snapshot. Follow these naming requirements:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * `source_disk_id`: ID of the disk to create the snapshot for.

      For detailed information about the `yandex_compute_snapshot` resource parameters, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_snapshot).
          
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check new resources in the [management console]({{ link-console-main }}) or using this CLI command:

      ```bash
      yc compute snapshot list
      ```

- API {#api}

  Use the [create](../../api-ref/Snapshot/create.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Create](../../api-ref/grpc/Snapshot/create.md) gRPC API call.

  For example, to create a snapshot with the `Gen 2` hardware generation assigned using REST API:

  1. Install [cURL](https://curl.haxx.se).
  1. Get an [{{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md) used for API authentication:
      * [Guide](../../../iam/operations/iam-token/create.md) for a Yandex account user
      * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a [service account](../../../iam/concepts/users/service-accounts.md)
      * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account
      * [Guide](../../../iam/operations/iam-token/create-for-local.md) for a local account
  1. For your request to run smoothly, save the IAM token you got to the `IAM_TOKEN` environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. Create a file containing the body of your snapshot create request (e.g., `body.json`), and add the following code to it:

      **body.json**

      ```json
      {
        "folderId": "<folder_ID>",
        "name": "<snapshot_name>",
        "diskId": "<disk_ID>",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Where:

      * `folderId`: [ID](../../../resource-manager/operations/folder/get-id.md) of the snapshot folder.
      * `name`: Snapshot name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `diskId`: ID of the [disk](../../concepts/disk.md) you are making a snapshot of.

  1. Run this http request:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/snapshots
      ```

      Result:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateSnapshotMetadata",
        "snapshotId": "fd8apannhdo9********",
        "diskId": "epd89t47vnhd********"
      },
      "id": "epd473ndlm58********",
      "description": "Create snapshot",
      "createdAt": "2025-12-05T14:43:02.803028670Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T14:43:02.803028670Z"
      }
      ```

{% endlist %}

This will create a disk snapshot with the `Gen 2` virtualized hardware [generation](../../concepts/hardware-generations.md) assigned.


## Create a disk with the Gen 2 hardware generation assigned {#create-disk}

By default, a newly created disk is assigned the [hardware generation](../../concepts/hardware-generations.md) [assigned](../../concepts/hardware-generations.md#locking-generations) to the original image or snapshot the disk was created from. However, you can explicitly specify a hardware generation different from that assigned to the original image or snapshot.

To create a disk with the `Gen 2` hardware generation assigned:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an image.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![archive](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.compute.storage_uisyT }}** and click **{{ ui-key.yacloud.compute.storage.button_create-disk }}**. In the window that opens:

      1. Name the disk in the **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** field. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}
      1. In the **{{ ui-key.yacloud.compute.disk-form.field_zone }}** field, select an [availability zone](../../../overview/concepts/geo-scope.md) for the new disk.
      1. Depending on the source you are creating the disk from, in the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` or `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and select the snapshot or image from the list that opens.
      1. In the **{{ ui-key.yacloud.compute.disk-form.field_type }}** field, select disk [type](../../concepts/disk.md#disks-types). Possible values:

          * `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}`: Fast network drive; SSD network block storage.
          * `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}`: Standard network drive; HDD network block storage.
          * `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-io-m3_pPfnG }}`: Enhanced performance network drive with redundancy.
          * `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-nonreplicated_d7W56 }}`: Enhanced performance network drive without redundancy.
      1. In the **{{ ui-key.yacloud.compute.disk-form.field_size }}** field, specify the required disk size.
      1. Expand the **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** section and select `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}` in the **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** field.
      1. Click **{{ ui-key.yacloud.compute.disks.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the {{ yandex-cloud }} CLI command to create a disk:

      ```bash
      yc compute disk create --help
      ```
  1. Create a disk with the `Gen 2` hardware generation assigned in the default folder:

      ```
      yc compute disk create \
        --name <disk_name> \
        --zone <availability_zone> \
        --type <disk_type> \
        --size <disk_size> \
        --source-image-id <source_image_ID> \
        --source-snapshot-id <source_snapshot_ID> \
        --hardware-generation-id generation2
      ```

      Where:
      * `--name`: Disk name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) of the new disk.
      * `--type`: [Disk type](../../concepts/disk.md#disks-types). Possible values:

          * `network-ssd`: Fast network drive; SSD network block storage.
          * `network-hdd`: Standard network drive; HDD network block storage.
          * `network-ssd-nonreplicated`: Enhanced performance network drive without redundancy.
          * `network-ssd-io-m3`: Enhanced performance network drive with redundancy.
      * `--size`: Disk size in GB. For example, specify `--size 32` to create a 32 GB disk.

      * Selecting a source for your disk:

          * `--source-image-id`: ID of the [image](../../concepts/image.md) you are creating the disk based on. Instead of the ID, you can provide its name in `--source-image-name`.
          * `--source-snapshot-id`: ID of the [snapshot](../../concepts/snapshot.md) you are creating the disk based on. Instead of the ID, you can provide its name in `--source-snapshot-name`.

          {% note info %}

          `--source-image-id`, `--source-image-name`, `--source-snapshot-id`, and `--source-snapshot-name` are mutually exclusive: you can use only one of them in the command.

          {% endnote %}

      Result:

      ```text
      done (9s)
      id: fv45fajiusvq********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-04T08:15:45Z"
      name: ubuntu2404-gen2-disk
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "34359738368"
      block_size: "4096"
      product_ids:
        - f2ebiogvi127********
      status: READY
      source_image_id: fd8bnguet48k********
      disk_placement_policy: {}
      hardware_generation:
        generation2_features: {}
      ```

  For more information about the `yc compute disk create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/disk/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_disk` resource in the configuration file.

      Here is a configuration file example:

      ```hcl
      resource "yandex_compute_disk" "my-disk" {
        name            = "<disk_name>"
        type            = "<disk_type>"
        zone            = "<availability_zone>"
        size            = <disk_size>
        image_id        = "<source_image_ID>"
        snapshot_id     = "<source_snapshot_ID>"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Where:
      * `name`: Name to assign to the disk. Follow these naming requirements:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * `type`: [Disk type](../../concepts/disk.md#disks-types). Possible values:

          * `network-ssd`: Fast network drive; SSD network block storage.
          * `network-hdd`: Standard network drive; HDD network block storage.
          * `network-ssd-nonreplicated`: Enhanced performance network drive without redundancy.
          * `network-ssd-io-m3`: Enhanced performance network drive with redundancy.

      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) of the new disk.
      * `size`: Disk size in GB.
      * Selecting a source for your disk:

          * `image_id`: ID of the [image](../../concepts/image.md) you are creating the disk based on.
          * `snapshot_id`: ID of the [snapshot](../../concepts/snapshot.md) you are creating the disk based on.

          {% note info %}

          `image_id` and `snapshot_id` are mutually exclusive: you can use only one of them in the configuration file.

          {% endnote %}

          For detailed information about the `yandex_compute_disk` resource parameters, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_disk).
          
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check new resources in the [management console]({{ link-console-main }}) or using this CLI command:

      ```bash
      yc compute disk list
      ```

- API {#api}

  Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

  For example, to create a disk with the `Gen 2` hardware generation assigned using REST API:

  1. Install [cURL](https://curl.haxx.se).
  1. Get an [{{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md) used for API authentication:
      * [Guide](../../../iam/operations/iam-token/create.md) for a Yandex account user
      * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a [service account](../../../iam/concepts/users/service-accounts.md)
      * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account
      * [Guide](../../../iam/operations/iam-token/create-for-local.md) for a local account
  1. For your request to run smoothly, save the IAM token you got to the `IAM_TOKEN` environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. Create a file containing the body of your disk create request (e.g., `body.json`), and add the following code to it:

      **body.json**

      ```json
      {
        "folderId": "<folder_ID>",
        "name": "<disk_name>",
        "typeId": "<disk_type>",
        "zoneId": "<availability_zone>",
        "size": "<disk_size_in_bytes>",
        "imageId": "<source_image_ID>",
        "snapshotId": "<source_snapshot_ID>",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Where:

      * `folderId`: [ID](../../../resource-manager/operations/folder/get-id.md) of the disk folder.
      * `name`: Disk name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `typeId`: [Disk type](../../concepts/disk.md#disks-types). Possible values:

          * `network-ssd`: Fast network drive; SSD network block storage.
          * `network-hdd`: Standard network drive; HDD network block storage.
          * `network-ssd-nonreplicated`: Enhanced performance network drive without redundancy.
          * `network-ssd-io-m3`: Enhanced performance network drive with redundancy.

      * `zoneId`: [Availability zone](../../../overview/concepts/geo-scope.md) of the new disk.
      * `size`: Disk size, in bytes.
      * Selecting a source for your disk:

          * `imageId`: ID of the [image](../../concepts/image.md) you are creating the disk based on.
          * `snapshotId`: ID of the [snapshot](../../concepts/snapshot.md) you are creating the disk based on.

          {% note info %}

          The `imageId` and `snapshotId` fields are mutually exclusive, you can use only one of them in the request.

          {% endnote %}

  1. Run this http request:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/disks
      ```

      Result:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateDiskMetadata",
        "diskId": "fv4lmsdol4fi********"
      },
      "id": "fv4pt28gishg********",
      "description": "Create disk",
      "createdAt": "2025-12-04T09:19:00.743099068Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-04T09:19:00.743099068Z"
      }
      ```

{% endlist %}

This will create a disk with the `Gen 2` virtualized hardware [generation](../../concepts/hardware-generations.md) assigned.

## Create a VM running on Gen 2 hardware {#create-vm}

{% note info %}

Before you create a VM, [prepare](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private) for SSH access to the VM.

{% endnote %}

Use a pre-prepared [image](#create-image), [snapshot](#create-snapshot), or [disk](#create-disk) with the `Gen 2` hardware generation assigned to create a VM based on that hardware generation:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../../overview/concepts/geo-scope.md) where your VM will reside.

      {% note info %}

      If creating your VM by attaching a ready-made boot disk to it, make sure your disk is in the same availability zone you are creating your VM in.

      {% endnote %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab and click **{{ ui-key.yacloud.common.select }}**. In the window that opens:

      * To create a VM from a [pre-prepared snapshot](#create-snapshot):
      
          1. Make sure you selected `{{ ui-key.yacloud.compute.component.instance-storage-dialog.value_disk-attach-type-create-new }}` at the top of the screen and `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` in the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field.
          1. Select the snapshot from the list. Optionally, use the filter.
          1. Name the VM boot disk in the **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** field. Follow these naming requirements:

              {% include [name-format](../../../_includes/name-format.md) %}
          1. In the **{{ ui-key.yacloud.compute.disk-form.field_type }}** and **{{ ui-key.yacloud.compute.disk-form.field_size }}** fields, select the [type](../../concepts/disk.md#disks-types) and size for your new disk.
          1. Optionally, in the **{{ ui-key.yacloud.compute.field_additional_vt356 }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}** to activate auto-deletion of the new boot disk together with the VM.
          1. Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
      * To create a VM from a [pre-prepared image](#create-image):
      
          1. Make sure you selected `{{ ui-key.yacloud.compute.component.instance-storage-dialog.value_disk-attach-type-create-new }}` at the top of the screen.
          1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}`.
          1. Select the image from the list. Optionally, use the filter.
          1. Name the VM boot disk in the **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** field. Follow these naming requirements:

              {% include [name-format](../../../_includes/name-format.md) %}
          1. In the **{{ ui-key.yacloud.compute.disk-form.field_type }}** and **{{ ui-key.yacloud.compute.disk-form.field_size }}** fields, select the [type](../../concepts/disk.md#disks-types) and size for your new disk.
          1. Optionally, in the **{{ ui-key.yacloud.compute.field_additional_vt356 }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}** to activate auto-deletion of the new boot disk together with the VM.
          1. Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
      * To create a VM from a [pre-prepared disk](#create-disk):
      
          1. At the top of the screen, select `{{ ui-key.yacloud.compute.component.instance-storage-dialog.value_disk-attach-type-attach-existing }}`.
          1. Select the disk from the list. Optionally, use the filter.
          1. Optionally, in the **{{ ui-key.yacloud.compute.field_additional_vt356 }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}** to activate auto-deletion of the new boot disk together with the VM.
          1. Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
  1. {% include [section-platform](../../../_includes/compute/create/section-platform.md) %}
  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:
  
      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username.
  
          {% note alert %}
  
          Do not use `root` or other reserved usernames. For operations requiring root privileges, use the `sudo` command.
  
          {% endnote %}
  
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for your VM:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  1. View the description of the CLI command to create a VM:

     ```bash
     yc compute instance create --help
     ```
  1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute instance create \
        --name <VM_name> \
        --zone <VM_availability_zone> \
        --network-interface subnet-id=<subnet_ID>,nat-ip-version=ipv4 \
        --create-boot-disk name=<disk_name>,type=<disk_type>,size=<disk_size>,image-id=<image_ID>,snapshot-id=<snapshot_ID>,auto-delete=true \
        --use-boot-disk disk-id=<ID_of_existing_disk>,auto-delete=true \
        --ssh-key "<path_to_public_SSH_key>"
      ```

      Where:
      * `--name`: VM name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) of the new VM.
      
          The VM availability zone must be the same as that of the subnet.
          
          When creating a VM using a pre-prepared boot disk, the VM availability zone must be the same as that of the boot disk.
      * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
          * `subnet-id`: [Subnet](../../../vpc/concepts/network.md#subnet) ID.
          * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, omit this parameter.

          {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

      * VM boot disk settings:

          {% note info %}

          `--create-boot-disk` and `--use-boot-disk` are mutually exclusive: you can use only one of them.

          {% endnote %}

          * `--create-boot-disk`: Enables creating a new boot disk for the VM based on an image or snapshot:

              * `name`: Disk name. Follow these naming requirements:

                  {% include [name-format](../../../_includes/name-format.md) %}
              
              * `type`: Disk [type](../../concepts/disk.md#disks-types). Possible values:

                  * `network-ssd`: Fast network drive; SSD network block storage.
                  * `network-hdd`: Standard network drive; HDD network block storage.
                  * `network-ssd-nonreplicated`: Enhanced performance network drive without redundancy.
                  * `network-ssd-io-m3`: Enhanced performance network drive with redundancy.
              * `size`: Disk size in GB.
              * Selecting a source for the boot disk:

                  * `image-id`: ID of the [pre-prepared image](#create-image) the VM boot disk will be created from.
                  * `snapshot-id`: ID of the [pre-prepared snapshot](#create-snapshot) the VM boot disk will be created from.

                      {% note info %}

                      The `image-id` and `snapshot-id` keys are mutually exclusive, you can use only one of them.

                      {% endnote %}

              * `auto-delete`: Auto-delete the boot disk together with the VM. See [{#T}](../../concepts/disk.md#autodelete-disks).
          * `--use-boot-disk`: Allows using an existing [pre-prepared](#create-disk) boot disk for the VM:

              * `disk-id`: Existing boot disk ID.
              * `auto-delete`: Auto-delete the boot disk together with the VM. See [{#T}](../../concepts/disk.md#autodelete-disks).
      * `--ssh-key`: Path to the file with the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

      Result:

      ```text
      done (19s)
      id: fv4l7qqpi4e0********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T18:23:55Z"
      name: my-first-gen2-vm
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv4h89mv71cb********
        auto_delete: true
        disk_id: fv4h89mv71cb********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:15:3e:b5:99
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.3.3
            one_to_one_nat:
              address: 158.160.***.***
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4l7qqpi4e0********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        generation2_features: {}
      application: {}
      ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_compute_disk" "boot-disk" {
        name            = "<disk_name>"
        type            = "<disk_type>"
        zone            = "<availability_zone>"
        size            = "<disk_size>"
        image_id        = "<source_image_ID>"
        snapshot_id     = "<source_snapshot_ID>"
      }

      resource "yandex_compute_instance" "vm-1" {
        name                      = "<VM_name>"
        platform_id               = "standard-v3"
        zone                      = "<availability_zone>"

        resources {
          cores  = "<number_of_vCPUs>"
          memory = "<RAM_in_GB>"
        }

        boot_disk {
          auto_delete = true|false
          disk_id = yandex_compute_disk.boot-disk.id
        }

        network_interface {
          subnet_id = "<subnet_ID>"
          nat       = true
        }

        metadata = {
          ssh-keys = "<username>:<SSH_key_contents>"
        }
      }
      ```

      Where:
      * `yandex_compute_disk`: Boot [disk](../../concepts/disk.md) description:

          {% note info %}

          Use the `yandex_compute_disk` resource if creating a new boot disk for the VM from a pre-prepared image or snapshot.
          
          If your new VM will use an existing [pre-prepared](#create-disk) boot disk, specify the disk's ID in the `boot_disk.disk_id` parameter of the `yandex_compute_instance` resource without creating a new `yandex_compute_disk` resource.

          {% endnote %}

          * `name`: Disk name. Follow these naming requirements:

              {% include [name-format](../../../_includes/name-format.md) %}

          * `type`: Disk [type](../../concepts/disk.md#disks-types). Possible values:

              * `network-ssd`: Fast network drive; SSD network block storage.
              * `network-hdd`: Standard network drive; HDD network block storage.
              * `network-ssd-nonreplicated`: Enhanced performance network drive without redundancy.
              * `network-ssd-io-m3`: Enhanced performance network drive with redundancy.
          * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
          * `size`: Disk size in GB.
          * Selecting a source for the boot disk:

              {% note info %}

              `image_id` and `snapshot_id` are mutually exclusive: you can use only one of them.

              {% endnote %}

              * `image_id`: ID of the [pre-prepared image](#create-image) the VM boot disk will be created from.
              * `snapshot_id`: ID of the [pre-prepared snapshot](#create-snapshot) the VM boot disk will be created from.

          For detailed information about the `yandex_compute_disk` resource parameters, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_disk).

      * `yandex_compute_instance`: VM description:
          * `name`: VM name. Follow these naming requirements:

              {% include [name-format](../../../_includes/name-format.md) %}

          * `platform_id`: [Platform](../../concepts/vm-platforms.md).
          * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the VM will reside in.

              The VM must reside in the same availability zone as the subnet, plus in the same availability zone as the boot disk if created from a pre-prepared disk.
          * `resources`: Number of vCPUs and amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
          * `boot_disk`: Boot disk settings.
          
              * `disk_id`: Disk ID. If your new VM will use an existing [pre-prepared](#create-disk) boot disk, specify its ID in this parameter.
              * `auto_delete`: Auto-delete the boot disk together with the VM. See [{#T}](../../concepts/disk.md#autodelete-disks).
          * `network_interface`: VM [network interface](../../concepts/network.md) settings:
          
              * `subnet_id`: ID of the [subnet](../../../vpc/concepts/network.md#subnet) in the same availability zone as the new VM.
              * To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

              {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

          * `metadata`: In the metadata, provide the user name and public SSH key for VM access. For more information, see [{#T}](../../concepts/vm-metadata.md).

      For detailed information about the `yandex_compute_instance` resource parameters, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_instance).
          
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check new resources in the [management console]({{ link-console-main }}) or using this CLI command:

      ```bash
      yc compute instance list
      ```

- API {#api}

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

  For example, to create a VM using REST API:

  1. Install [cURL](https://curl.haxx.se).
  1. Get an [{{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md) used for API authentication:
      * [Guide](../../../iam/operations/iam-token/create.md) for a Yandex account user
      * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a [service account](../../../iam/concepts/users/service-accounts.md)
      * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account
      * [Guide](../../../iam/operations/iam-token/create-for-local.md) for a local account
  1. For your request to run smoothly, save the IAM token you got to the `IAM_TOKEN` environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. Create a file containing the body of your VM create request (e.g., `body.json`), and add the following code to it:

      **body.json**

      ```json
      {
        "folderId": "<folder_ID>",
        "name": "<VM_name>",
        "zoneId": "<availability_zone>",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "<RAM_in_bytes>",
          "cores": "<number_of_vCPUs>"
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
        },
        "bootDiskSpec": {
          "autoDelete": true,
          "diskSpec": {
            "size": "<disk_size_in_bytes>",
            "imageId": "<source_image_ID>",
            "snapshotId": "<source_snapshot_ID>"
          },
          "diskId": "<disk_ID>"
        },
        "networkInterfaceSpecs": [
          {
            "subnetId": "<subnet_ID>",
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
          }
        ]
      }
      ```

      Where:

      * `folderId`: [ID](../../../resource-manager/operations/folder/get-id.md) of the VM folder.
      * `name`: VM name. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `zoneId`: [Availability zone](../../../overview/concepts/geo-scope.md) the VM will reside in.

          The VM must reside in the same availability zone as the subnet, plus in the same availability zone as the boot disk if created from a [pre-prepared disk](#create-disk).
      * `platformId`: VM [platform](../../concepts/vm-platforms.md).
      * `resourceSpec`: Number of vCPUs and amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
      * `metadata`: In metadata, provide the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `bootDiskSpec`: VM boot disk settings:

          * `autoDelete`: Auto-delete the boot disk together with the VM. See [{#T}](../../concepts/disk.md#autodelete-disks).

          {% note info %}

          `diskSpec` and `diskId` are mutually exclusive: you can use only one of them.

          {% endnote %}

          * `diskSpec`: Setting of the new boot disk if created from a pre-prepared image or snapshot:

              * `size`: New disk size, in bytes.
              * Selecting a source for the boot disk:

                  {% note info %}

                  `imageId` and `snapshotId` are mutually exclusive: you can use only one of them.

                  {% endnote %}

                  * `imageId`: ID of the [pre-prepared image](#create-image) the VM boot disk will be created from.
                  * `snapshotId`: ID of the [pre-prepared snapshot](#create-snapshot) the VM boot disk will be created from.
          * `diskId`: ID of the existing [pre-prepared](#create-disk) boot disk if one is used to create the VM.
      * `networkInterfaceSpecs`: VM [network interface](../../concepts/network.md) settings:

          * `subnetId`: ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). The subnet must be in the same availability zone as your new VM.
          * `primaryV4AddressSpec`: IP address to assign to the VM. To add a [public IP address](../../../vpc/concepts/address.md#public-addresses) to your VM, specify the following:

            ```json
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```
          To add multiple [network interfaces](../../concepts/network.md) to your VM, provide an array with the required number of objects containing network interface settings in the `networkInterfaceSpecs` parameter.

  1. Run this http request:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/instances
      ```

      Result:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateInstanceMetadata",
        "instanceId": "fv41kcr9qbd8********"
      },
      "id": "fv4tll89q78c********",
      "description": "Create instance",
      "createdAt": "2025-12-05T20:37:44.940310692Z",
      "createdBy": "ajeol2afu1jsk********",
      "modifiedAt": "2025-12-05T20:37:44.940310692Z"
      }
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/hardware-generations.md)