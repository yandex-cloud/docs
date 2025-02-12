# Removing an instance group from a placement group

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a group:

      ```bash
      {{ yc-compute-ig }} update --help
      ```

  1. Get a list of instance groups in the default folder:

      ```bash
      yc compute instance-group list
      ```

      Result:

      ```text
      {{ yc-compute-ig }} list
      +----------------------+-----------------------+------+
      |          ID          |         NAME          | SIZE |
      +----------------------+-----------------------+------+
      | amc65sbgfqeq******** | first-instance-group  |    2 |
      +----------------------+-----------------------+------+
      ```

  1. Select `ID` of the instance group in question.
  1. Delete the `placement_policy` section from the YAML file you used to create the group, e.g., `specification.yaml`. If this YAML file is missing, [get info](../instance-groups/get-info.md) on the instance group and create a new file. For more information, see [{#T}](../instance-groups/create-fixed-group.md).
  1. Update the instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} update --id <instance_group_ID> --file specification.yaml
      ```

  {{ ig-name }} will initiate removing the instance group from the placement group.

- API {#api}

  You can remove an instance group from a placement group by using the [update](../../instancegroup/api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}
