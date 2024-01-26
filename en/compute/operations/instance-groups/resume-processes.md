# Resuming instance group processes

On resume, previously stopped [update](../../concepts/instance-groups/deploy/), [automatic recovery](../../concepts/instance-groups/autohealing.md), and [scaling](../../concepts/instance-groups/policies/scale-policy.md) processes will be restarted, and significant group changes associated with the paused processes will be applied (such as group size or instance configuration changes).

To resume processes in an instance group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. In the line with the appropriate instance group, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-resume }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- API {#api}

   Use the [resumeProcesses](../../api-ref/InstanceGroup/resumeProcesses.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/ResumeProcesses](../../api-ref/grpc/instance_group_service.md#ResumeProcesses) gRPC API call.

{% endlist %}