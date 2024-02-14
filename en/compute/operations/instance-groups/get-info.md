# Getting information about an instance group

After creating an instance group, you can get basic information about the group.

You can only use the CLI or API to retrieve user [metadata](../../concepts/vm-metadata.md) transmitted when creating or editing a group.

To get information about an instance group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Click the name of the group.

- CLI {#cli}

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's get instance group info command:

      ```
      {{ yc-compute-ig }} get --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Get information about the instance group:

      ```
      {{ yc-compute-ig }} get --name first-instance-group
      ```

- API {#api}

   Use the [get](../../api-ref/InstanceGroup/get.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Get](../../api-ref/grpc/instance_group_service.md#Get) gRPC API call.

   To request the list of available instance groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances) gRPC API call.


{% endlist %}
