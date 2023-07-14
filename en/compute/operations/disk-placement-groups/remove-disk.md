# Removing a disk from a placement group

Remove a non-replicated disk from a [placement group](../../concepts/disk-placement-group.md). You can then [permanently delete](../disk-control/delete.md) the disk or add it back to the placement group.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to remove the disk from the placement group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
   1. Click the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab.
   1. Select the placement group to remove a disk from.
   1. Go to the **{{ ui-key.yacloud.compute.placement-group.switch_disks }}** panel.
   1. To the right of the name of the disk to remove, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.disks.popup-confirm_button_delete }}**.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To remove a non-replicated disk created with {{ TF }} from a placement group:

   1. Open the {{ TF }} configuration file and delete the fragment describing the non-replicated disk.

      {% cut "Sample non-replicated disk description in the {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_compute_disk" "nr" {
        name       = "non-replicated-disk-name"
        size       = 93
        block_size = 4096
        type       = "network-ssd-nonreplicated"
        zone       = "{{ region-id }}-b"

        disk_placement_policy {
          disk_placement_group_id = yandex_compute_disk_placement_group.this.id
        }
      }

      resource "yandex_compute_disk_placement_group" "this" {
        zone = "{{ region-id }}-b"
      }
      ...
      ```

      {% endcut %}

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command below:

      ```bash
      yc compute disk-placement-group get <placement_group_name>
      ```

{% endlist %}
