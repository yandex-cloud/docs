# Starting an instance group

Starting an instance group will automatically start all stopped VM instances within that group. You can start a single VM instance, e.g., for diagnostics, but to enable [automatic recovery](../../concepts/instance-groups/autohealing.md) or [scaling](../../concepts/instance-groups/scale.md), you need to start the entire group.

{% note warning %}

If {{ yandex-cloud }} stops an instance group due to a block for non-payment, that instance group can only be restarted after the block is removed.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group in question.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. In the line with the instance group, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-start }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_start }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for starting an instance group:

     ```bash
     {{ yc-compute-ig }} start --help
     ```

  1. Get a list of instance groups in the default folder:

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select `ID` or `NAME` of the group in question, e.g., `first-instance-group`.
  1. Start the instance group in the default folder:

     ```bash
     {{ yc-compute-ig }} start first-instance-group
     ```

     {{ ig-name }} will initiate starting VM instances in the group. Once all instances are started, the group will get the `ACTIVE` status.

- API {#api}

  To start an instance group, use the [start](../../instancegroup/api-ref/InstanceGroup/start.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Start](../../instancegroup/api-ref/grpc/InstanceGroup/start.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}