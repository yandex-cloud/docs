# Stopping an instance group

If you do not need instances in a group for now, stop the group. All VM instances in the group will be stopped. If an instance group is very large and creating that many VM instances is time-consuming, it is more efficient to stop the group rather than deleting it or scaling it down to zero.

{% note info %}

If you stop a single VM instance in a group rather than the entire group, {{ ig-name }} will [automatically restart](../../concepts/instance-groups/autohealing.md) that instance.

{% endnote %}

For stopped instances, only disks are billable. If you do not want to pay for disk usage, scale down the instance group to zero or [delete the group](delete.md). To avoid losing data, [make snapshots of the disks](../disk-control/create-snapshot.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group in question.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. In the line with the instance group, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_stop }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for stopping an instance group:

     ```bash
     {{ yc-compute-ig }} stop --help
     ```

  1. Get a list of instance groups in the default folder:

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select `ID` or `NAME` of the group in question, e.g., `first-instance-group`.
  1. Stop the instance group in the default folder:

     ```bash
     {{ yc-compute-ig }} stop first-instance-group
     ```

     {{ ig-name }} will initiate stopping VM instances in the group. When all instances are stopped, the group will get the `STOPPED` status.

- API {#api}

  To stop an instance group, use the [stop](../../instancegroup/api-ref/InstanceGroup/stop.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Stop](../../instancegroup/api-ref/grpc/InstanceGroup/stop.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}