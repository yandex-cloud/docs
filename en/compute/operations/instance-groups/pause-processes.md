# Pausing instance group processes

If you want to suspend the instance group [update](../../concepts/instance-groups/deploy/), [automatic recovery](../../concepts/instance-groups/autohealing.md), and [scaling](../../concepts/instance-groups/policies/scale-policy.md) processes, you can pause them. This will not stop the actual instances.

To pause an instance group:

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Select an instance group, click ![image](../../../_assets/horizontal-ellipsis.svg), and select **Pause**.
   1. In the window that opens, click **Stop**.

- API

   Use the [pauseProcesses](../../api-ref/InstanceGroup/pauseProcesses.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/PauseProcesses](../../api-ref/grpc/instance_group_service.md#PauseProcesses) gRPC API call.

{% endlist %}