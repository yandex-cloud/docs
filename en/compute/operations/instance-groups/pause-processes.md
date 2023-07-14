# Pausing instance group processes

If you want to suspend the instance group [update](../../concepts/instance-groups/deploy/), [automatic recovery](../../concepts/instance-groups/autohealing.md), and [scaling](../../concepts/instance-groups/policies/scale-policy.md) processes, you can pause them. This will not stop the actual instances.

To pause an instance group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. In the line with the appropriate instance group, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-pause }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- API

   Use the [pauseProcesses](../../api-ref/InstanceGroup/pauseProcesses.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/PauseProcesses](../../api-ref/grpc/instance_group_service.md#PauseProcesses) gRPC API call.

{% endlist %}