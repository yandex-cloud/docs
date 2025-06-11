# Pausing instance group processes

If you want to suspend the instance group [update](../../concepts/instance-groups/deploy/), [automatic recovery](../../concepts/instance-groups/autohealing.md), and [scaling](../../concepts/instance-groups/policies/scale-policy.md) processes, pause them. This will not stop the VM instances.

To pause instance group processes:
 
{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group in question.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. In the line with the instance group, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-pause }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- API {#api}

  Use the [pauseProcesses](../../instancegroup/api-ref/InstanceGroup/pauseProcesses.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/PauseProcesses](../../instancegroup/api-ref/grpc/InstanceGroup/pauseProcesses.md) gRPC API call.

{% endlist %}