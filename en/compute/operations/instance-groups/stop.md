# Stop an instance group

If you don't need instances in a group for a while, stop the group. All instances in the group are stopped. If the instance group is very large and it would take a long time to create that many instances afterwards, stopping a group is more effective than deleting it or reducing its size to zero.

{% note info %}

If you stop a single virtual machine in a group instead of an entire group, {{ ig-name }} will [automatically restart](../../concepts/instance-groups/autohealing.md) the virtual machine.

{% endnote %}

Only disks are charged for stopped instances. If you don't want to pay for disk usage, then reduce the instance group size to 0 or [delete the group](delete.md). To avoid losing data, [make snapshots of the disks](../disk-control/create-snapshot.md).

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Select an instance group, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Stop group**.
   1. Confirm the action.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the stop instance group command in the CLI:

      ```
      {{ yc-compute-ig }} stop --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Stop an instance group in the default folder:

      ```
      {{ yc-compute-ig }} stop first-instance-group
      ```

      {{ ig-name }} will begin stopping the group's virtual machines. When all instances are stopped, the group switches to `STOPPED` status.

- API

   You can stop an instance group using the API method [stop](../../api-ref/InstanceGroup/stop.md).

   To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}