# Starting an instance group

When an instance group is started, all its stopped instances are started. You can start a single instance for troubleshooting purposes, for example, but to enable [automatic recovery](../../concepts/instance-groups/autohealing.md) and [scaling](../../concepts/instance-groups/scale.md), you need to start an entire group.

{% note warning %}

If an instance group is stopped by {{ yandex-cloud }} because it was blocked for failure to pay, the instance group can be started again only after the block is removed.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder the instance group is in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. In the line with the instance group, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-start }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_start }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI instance group start command below:

     ```bash
     {{ yc-compute-ig }} start --help
     ```

  1. Get a list of instance groups in the default folder:

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select the `ID` or `NAME` of the group you need, e.g., `first-instance-group`.
  1. Start an instance group in the default folder:

     ```bash
     {{ yc-compute-ig }} start first-instance-group
     ```

     {{ ig-name }} will begin starting instances in the group. Once all instances are started, the group status switches to `ACTIVE`.

- API {#api}

  You can start an instance group using the [start](../../instancegroup/api-ref/InstanceGroup/start.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Start](../../instancegroup/api-ref/grpc/InstanceGroup/start.md) gRPC API call.

  To request the list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}