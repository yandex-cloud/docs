# Getting a list of VM instances in a group

After creating an instance group, you can get a list of instances in the group.

To get a list of VM instances:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group in question.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select the group.
  1. Go to the **{{ ui-key.yacloud.compute.group.switch_instances }}** tab.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of VM instances:

      ```
      {{ yc-compute-ig }} list-instances --help
      ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select `ID` or `NAME` of the group in question, e.g., `first-instance-group`.
  1. Get information about the instance group:

      ```
      {{ yc-compute-ig }} list-instances --name first-instance-group
      ```

- API {#api}

  Use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}
