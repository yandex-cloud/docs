---
title: How to create an image from a disk snapshot in {{ compute-full-name }}
description: Follow this guide to create an image from a disk snapshot.
---

# Creating an image from a disk snapshot

To create an image from a disk snapshot:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. In the line with the snapshot, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.snapshots.list.button_action-image }}**.
  1. Specify the image name. Follow these naming requirements:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Provide a text description for the image, if required.
  1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
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
        --name first-image \
        --source-snapshot-name first-snapshot \
        --description "my first image via yc"
      ```
  
      This command will create an image named `first-image` and described as `my first image via yc` from `first-snapshot`.

      To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), use the `--pooled` flag:

      ```
      yc compute image create \
        --name first-image \
        --source-snapshot-name first-snapshot \
        --description "my first image via yc" \
        --pooled
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_image` resource in the configuration file.

     Here is an example of the configuration file structure:

     ```
     resource "yandex_compute_image" "image-1" {
       name            = "<image_name>"
       source_snapshot = "<snapshot_ID>"
     }
     ```

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).

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
  1. Create an image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Snapshot/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call. Specify the snapshot ID in your request.

{% endlist %}

Once created, the image will get the `CREATING` status. Wait until its status changes to `READY` before using it.
