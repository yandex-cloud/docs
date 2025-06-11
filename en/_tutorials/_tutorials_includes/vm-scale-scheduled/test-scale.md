{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select the `vm-scale-scheduled-ig` group.
  1. Under **{{ ui-key.yacloud.compute.group.overview.section_instances-state }}**, make sure the number of instances changes every two minutes: increases from 2 to 3, then decreases from 3 to 2, etc. You can also check if the instance group has been updated by opening the ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab.

- CLI {#cli}

  Run the following command several times:

  ```bash
  yc compute instance-group get vm-scale-scheduled-ig \
    --folder-name example-folder
  ```

  Result:

  ```yaml
  id: cl1l0ljqbmkp********
  folder_id: b1g9hv2loamq********
  created_at: "2022-03-28T13:24:20.693Z"
  ...
  managed_instances_state:
    target_size: "2"
    running_actual_count: "2"
  ...
  ```

  The value of the `target_size` field for the group should change from `2` to `3` and back.

- API {#api}

  Get information about the `vm-scale-scheduled-ig` instance group multiple times using the [get](../../../compute/instancegroup/api-ref/InstanceGroup/get.md) REST API method for the [InstanceGroup](../../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Get](../../../compute/instancegroup/api-ref/grpc/InstanceGroup/get.md) gRPC API call. The value of the `target_size` field for the group should change from `2` to `3` and back.

{% endlist %}