# Creating a placement group

Create a [placement group](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your placement group in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Navigate to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.compute.placement-groups.button_create }}** and select **{{ ui-key.yacloud.compute.placement-groups.button_menu-create-instance-placement-group }}**.
  1. Enter a name for the placement group. Follow these naming requirements:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Optionally, specify a description for the placement group.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating a placement group:

     ```bash
     yc compute placement-group create --help
     ```

  1. Create a placement group in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) with one of the following placement strategies:

     {% include [pg-create](../../../_includes/compute/placement-groups-create.md) %}

  1. Check that the placement group has been added:

     ```bash
     yc compute placement-group list
     ```

     Result:

     ```text
     +----------------------+----------+----------+
     |          ID          |   NAME   | STRATEGY |
     +----------------------+----------+----------+
     | fd83bv4rnsna******** | my-group | SPREAD   |
     +----------------------+----------+----------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the placement group parameters:
     * `name`: Placement group name. Follow these naming requirements:

       {% include [name-format](../../../_includes/name-format.md) %}

     * `folder_id`: ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create a placement group in.
     * `description`: Placement group description.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_compute_placement_group" "group1" {
       name        = "<placement_group_name>"
       folder_id   = "<catalog_ID>"
       description = "<placement_group_description>"
     }
     ```

     For more information about the `yandex_compute_placement_group` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_placement_group).
  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.
  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc compute placement-group list
     ```

- API {#api}

  Use the [create](../../api-ref/PlacementGroup/create.md) REST API method for the [PlacementGroup](../../api-ref/PlacementGroup/index.md) resource or the [PlacementGroupService/Create](../../api-ref/grpc/PlacementGroup/create.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [How to add a VM to a placement group](add-vm.md)
* [How to create a VM in a placement group](create-vm-in-pg.md)