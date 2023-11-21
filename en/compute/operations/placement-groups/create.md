# Creating a placement group

Create a [placement group](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your placement group in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
   1. Go to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}** tab.
   1. In the top-right corner, click **{{ ui-key.yacloud.compute.placement-groups.button_create }}** and choose **{{ ui-key.yacloud.compute.placement-groups.button_create-instance-pg }}**.
   1. Enter a name for the placement group. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. (Optional) Add a placement group description.
   1. Click **{{ ui-key.yacloud.compute.placement-groups.create.button_create }}**.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a placement group:

      ```bash
      yc compute placement-group create --help
      ```

   1. Create a placement group:

      ```bash
      yc compute placement-group create --spread-strategy --name my-group
      ```

      Result:

      ```bash
      id: fd83bv4rnsna********
      folder_id: b1g5kkhshgs9********
      created_at: "2019-12-30T10:07:34Z"
      name: my-group
      spread_placement_strategy: {}
      ```

      This command creates a placement group with the following characteristics:

      - Name: `my-group`
      - Placement strategy: `spread`

   1. Check that the placement group was added:

      ```bash
      yc compute placement-group list
      ```

      Result:

      ```bash
      +----------------------+----------+----------+
      |          ID          |   NAME   | STRATEGY |
      +----------------------+----------+----------+
      | fd83bv4rnsna******** | my-group | SPREAD   |
      +----------------------+----------+----------+
      ```

- API

   Use the [create](../../api-ref/PlacementGroup/create.md) REST API method for the [PlacementGroup](../../api-ref/PlacementGroup/index.md) resource or the [PlacementGroupService/Create](../../api-ref/grpc/placement_group_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the placement group parameters:

      * `name`: Placement group name. The name format is as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `folder_id`: ID of the folder where the placement group is being created.
      * `description`: Placement group description.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_compute_placement_group" "group1" {
        name        = "<placement group name>"
        folder_id   = "<folder ID>"
        description = "<placement group description>"
      }
      ```

      For more information about the parameters of the `yandex_compute_placement_group` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_placement_group).

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc compute placement-group list
      ```

{% endlist %}

## See also {see-also}

* [How to add a VM instance to a placement group](add-vm.md)
* [How to create a VM in a placement group](create-vm-in-pg.md)