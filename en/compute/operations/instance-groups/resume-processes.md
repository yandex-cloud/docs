# Resuming instance group processes

On resume, previously stopped [update](../../concepts/instance-groups/deploy/), [automatic recovery](../../concepts/instance-groups/autohealing.md), and [scaling](../../concepts/instance-groups/policies/scale-policy.md) processes will be restarted, and significant group changes associated with the paused processes will be applied (such as group size or instance configuration changes).

To resume processes in an instance group:

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Select an instance group, click ![image](../../../_assets/horizontal-ellipsis.svg), and select **Resume**.
   1. In the window that opens, click **Resume**.

- API

   Use the [resumeProcesses](../../api-ref/InstanceGroup/resumeProcesses.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/ResumeProcesses](../../api-ref/grpc/instance_group_service.md#ResumeProcesses) gRPC API call.

{% endlist %}