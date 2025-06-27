---
title: Moving a VM to a different cloud
description: Follow this guide to move a VM to a different cloud.
---

# Moving a VM to a different cloud

While directly moving a VM to a different cloud is not supported, you can create an image from its boot disk and then create a VM from this image in a different cloud.

1. Use the boot disk of your VM to [create an image](../image-create/create-from-disk.md).
1. Get the boot disk image ID:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder the disk image is in.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
      1. Copy the value from the **{{ ui-key.yacloud.common.id }}** column for the image in question.

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Get a list of disk images in the default folder:

      ```bash
      yc compute image list
      ```

      Result:

      ```text
      +----------------------+----------------+--------+-------------+--------+
      |          ID          |    NAME        | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+----------------+--------+-------------+--------+
      | xc8n3spmksqm******** | original-image |        |             | READY  |
      +----------------------+----------------+--------+-------------+--------+
      ```

    - {{ TF }} {#tf}

      {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, prepare the `output` variable with the output data:

          ```hcl
          resource "yandex_compute_snapshot" "snapshot-1" {
            name           = "<image_name>"
            source_disk_id = "<disk_ID>"
          }
          ...
          output "snapshot_id" {
            value = yandex_compute_snapshot.snapshot-1.id
          }
          ```

          Where `value` is the boot disk image ID. In the example above, the boot disk image is described in the `yandex_compute_snapshot` resource named `snapshot-1`.

      1. Apply the changes:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      1. Save the boot disk image ID to the `snapshot_id.txt` file using this console command:

          ```bash
          terraform output snapshot_id > snapshot_id.txt
          ```

    - API {#api}

      Use the [list](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/Image/list.md) gRPC API call.

    {% endlist %}

1. Get the ID of the target cloud you plan to move your VM to (next: `<target_cloud_ID>`):

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), click the cloud in the list on the left.
      1. On the **{{ ui-key.yacloud.iam.cloud.switch_overview }}** tab, copy the **{{ ui-key.yacloud.common.id }}** value.

    - CLI {#cli}

      Get a list of clouds with their IDs:

      ```bash
      yc resource-manager cloud list
      ```

      Result:

      ```text
      +----------------------+------------+--------------------------+
      |          ID          |    NAME    |      ORGANIZATION ID     |
      +----------------------+------------+--------------------------+
      | b1g66mft1vop******** | my-cloud-1 |                          |
      | b1gd129pp9ha******** | my-cloud-2 |                          |
      +----------------------+------------+--------------------------+
      ```

    - {{ TF }} {#tf}

      1. In the configuration file, prepare the `output` variable with the output data:

          ```hcl
          resource "yandex_resourcemanager_cloud" "cloud-1" {
            name            = "<cloud_name>"
            organization_id = "<organization_ID>"
          }

          output "destination_cloud_id" {
            value = yandex_resourcemanager_cloud.cloud-1.id
          }
          ```

          Where `destination_cloud_id` is the target cloud ID. In the example above, the cloud is described in the `yandex_resourcemanager_cloud` resource named `cloud-1`.

      1. Apply the changes:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      1. Save the target cloud ID named `destination_cloud_id.txt` using this console command:

          ```bash
          terraform output destination_cloud_id > destination_cloud_id.txt
          ```

    - API {#api}

      To get a list of clouds with their IDs, use the [list](../../../resource-manager/api-ref/Cloud/list.md) REST API method for the [Cloud](../../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/List](../../../resource-manager/api-ref/grpc/Cloud/list.md) gRPC API call.

    {% endlist %}

1. [Add a user](../../../iam/operations/users/create.md) from the target cloud (where you want to move your VM) to the cloud hosting the folder with the source image.
1. [Assign](../../../iam/operations/roles/grant.md) the target cloud user the `{{ roles-cloud-member }}` and `{{ roles-image-user }}` roles for the cloud hosting the folder with the source image.
1. Create a new image in the target cloud:

    {% list tabs group=instructions %}

    - CLI {#cli}

      ```bash
      yc compute image create \
        --name <new_image_name> \
        --source-image-id <source_image_ID> \
        --cloud-id <target_cloud_ID> \
        --folder-id <destination_folder_ID>
      ```


    - API {#api}

      Use the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call. Specify the image ID in your request.

    {% endlist %}

1. In the target cloud, [create a VM](../vm-create/create-from-user-image.md) from the image you created.
