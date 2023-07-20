# Creating a disk placement group

Create a [placement group](../../concepts/disk-placement-group.md) for non-replicated disks.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a disk placement group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
   1. Click the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab.
   1. In the top-right corner, click **{{ ui-key.yacloud.compute.placement-groups.button_create }}** → **{{ ui-key.yacloud.compute.placement-groups.button_create-disk-pg }}**.
   1. Enter a name for the group.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If required, add a group description.
   1. Specify the [availability zone](../../../overview/concepts/geo-scope.md).

      
      {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}


   1. Click **{{ ui-key.yacloud.compute.placement-groups.create.button_create }}**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI commands to create a disk placement group:

      ```bash
      yc compute disk-placement-group create --help
      ```

   1. Create a group in the default folder:

      ```bash
      yc compute disk-placement-group create \
        --name first-group \
        --description "first disk placement group"
      ```

      This will create a disk placement group named `first-group` with the description `first disk placement group`.

   1. Get a list of disk placement groups in the default folder:

      ```bash
      yc compute disk-placement-group list
      ```

      Result:

      ```text
      +----------------------+-------------+---------------+--------+
      |          ID          |    NAME     |     ZONE      | STATUS |
      +----------------------+-------------+---------------+--------+
      | epd4sug6keskb72ub9m7 | first-group | {{ region-id }}-b | READY  |
      +----------------------+-------------+---------------+--------+
      ```

   1. Get information about the group created:

      ```bash
      yc compute disk-placement-group get \
        --name first-group
      ```

      Result:

      ```text
      id: epd4sug6keskb72ub9m7
      folder_id: w3qrbj9swotyns6oiyny
      created_at: "2021-03-23T12:49:59Z"
      name: first-group
      description: first disk placement group
      zone_id: {{ region-id }}-b
      status: READY
      spread_placement_strategy: {}
      ```

- API

   Use the [create](../../api-ref/DiskPlacementGroup/create.md) REST API method for the [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md) resource or the [DiskPlacementGroupService/Create](../../api-ref/grpc/disk_placement_group_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the disk placement group parameters:

      ```hcl
      resource "yandex_compute_disk_placement_group" "group1" {
        name        = "<name_of_disk_placement_group>"
        folder_id   = "<folder_ID>"
        description = "<description_of_disk_placement_group>"
        zone        = "<availability_zone>"
      }
      ```

      Where:
      * `name`: Disk placement group name. The name format is as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `folder_id`: ID of the folder where the disk placement group is being created.
      * `description`: Disk placement group description.
      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md). We recommend creating disk placement groups in the `{{ region-id }}-a` or `{{ region-id }}-b` availability zone.

      For more information about the `yandex_compute_disk_placement_group` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_disk_placement_group).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

         ```bash
         yc compute disk-placement-group list
         ```

{% endlist %}
