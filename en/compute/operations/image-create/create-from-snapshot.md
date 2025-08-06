---
title: How to create an image from a disk snapshot in {{ compute-full-name }}
description: Follow this guide to create an image from a disk snapshot.
---

# Creating an image from a disk snapshot

To create an image from a disk [snapshot](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. In the line with the snapshot, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.snapshots.list.button_action-image }}**.
  1. Specify the image name. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Provide a text description for the image, if required.
  1. Expand the **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** section:
  1. Optionally, in the **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** field, select the virtualized hardware [generation](../../concepts/hardware-generations.md#configurations) you want to assign to the new image:

      {% include [generation-types-console](../../../_includes/compute/generation-types-console.md) %}

      If you make no assignment, by default the new image will get the same generation assigned as the source snapshot.
  1. Optionally, to create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating an image:

      ```
      yc compute image create --help
      ```
  1. Get a list of snapshots in the default folder:

      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

  1. Select `ID` or `NAME` of the snapshot in question.
  1. Create an image in the default folder:

      ```
      yc compute image create \
        --name <name_of_new_image> \
        --source-snapshot-name <source_snapshot_name> \
        --pooled \
        --hardware-generation-id <hardware_generation> \
        --hardware-features pci_topology=<PCI_topology>
      ```

      Where:
      * `--name`: Image name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--source-snapshot-name`: Source snapshot name. Instead of a name, you can provide the source snapshot ID in the `--source-snapshot-id` parameter.
      * `--pooled`: Parameter you can use to create an [optimized image](../../concepts/image.md#images-optimized-for-deployment). This is an optional setting.
      * `--hardware-generation-id`: Virtualized hardware [generation](../../concepts/hardware-generations.md#configurations) assigned to the image. This is an optional setting. The possible values are:

          {% include [generation-types-cli](../../../_includes/compute/generation-types-cli.md) %}

          If not specified, the new image will get the same hardware generation assigned as the source snapshot.
      * `--hardware-features`: Additional settings for `Gen 1`. This is an optional setting. The possible values are:

          * `pci_topology=v1`: `PCI_TOPOLOGY_V1` topology.
          * `pci_topology=v2`: `PCI_TOPOLOGY_V2` topology.


          If the source snapshot has `Gen 1` assigned, by default the new image will get the same `--hardware-features` value as the source snapshot.

      Result:

      ```text
      done (5s)
      id: fd8lt5sskh12********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T19:26:46Z"
      name: my-first-image
      storage_size: "3116367872"
      min_disk_size: "21474836480"
      product_ids:
        - f2evcrm9ti79********
      status: READY
      os:
        type: LINUX
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_image` resource in the configuration file.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_compute_image" "image-1" {
       name            = "<image_name>"
       source_snapshot = "<source_snapshot_ID>"
       hardware_generation {
         legacy_features {
           pci_topology = "<PCI_topology>"
         }
       }
     }
     ```

      Where:
      * `name`: Image name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `source_snapshot`: Source snapshot ID.
      * `hardware_generation`: Block of settings describing the virtualized hardware [generation](../../concepts/hardware-generations.md#configurations) assigned to the image. This is an optional setting. It includes the following blocks of settings:

          {% include [generation-types-tf](../../../_includes/compute/generation-types-tf.md) %}

          {% note info %}

          If the `hardware_generation` settings are not specified, the new image will get the same hardware generation assigned as the source snapshot.

          {% endnote %}

     For more information about the `yandex_compute_image` resource, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_image).

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

       If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

     1. Run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources.

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  1. Get a list of snapshots using the [list](../../api-ref/Snapshot/list.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md) gRPC API call.
  1. Create an image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Snapshot/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call. In your request, specify the source snapshot ID, and optionally the required virtualized hardware [generation](../../concepts/hardware-generations.md#configurations) in the [`hardwareGeneration` object](../../api-ref/Image/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../api-ref/grpc/Image/create.md#yandex.cloud.compute.v1.HardwareGeneration) if using the gRPC API).

{% endlist %}

Once created, the image will get the `CREATING` status. Wait until its status changes to `READY` before using it.
