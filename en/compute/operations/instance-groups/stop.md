# Stop an instance group

If you do not need instances in a group for a while, stop the group. All instances in the group will be stopped. If the instance group is very large and it would take a long time to create that many instances afterwards, stopping a group is more effective than deleting it or reducing its size to zero.

{% note info %}

If you stop a single instance in a group instead of the whole group, {{ ig-name }} [automatically restarts](../../concepts/instance-groups/autohealing.md) the VM.

{% endnote %}

Only disks are billable for stopped instances. If you do not want to pay for disk usage, reduce the instance group size to 0 or [delete the group](delete.md). To avoid losing data, [make snapshots of the disks](../disk-control/create-snapshot.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. In the line with the appropriate instance group, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-stop }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_stop }}**.

- CLI {#cli}

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to stop an instance group:

      ```bash
      {{ yc-compute-ig }} stop --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Stop the instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} stop first-instance-group
      ```

      {{ ig-name }} will begin stopping instances in the group. When all instances are stopped, the group switches to the `STOPPED` status.

- API {#api}

   You can stop an instance group by using the [stop](../../api-ref/InstanceGroup/stop.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Stop](../../api-ref/grpc/instance_group_service.md#Stop) gRPC API call.

   To request the list of available instance groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances) gRPC API call.

{% endlist %}