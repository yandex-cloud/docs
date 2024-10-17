# Recreating instances in a group one by one

You can [recreate group instances one by one](../../concepts/instance-groups/rolling-actions.md) based on the parameters specified in the [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md).

For example, if the maximum number of unhealthy instances per group set in the deployment policy is `1`, then, when recreating instances one by one, only one instance will be unavailable at any given time.

{% include [ig-opportunistic-warning](../../../_includes/compute/ig-opportunistic-warning.md) %}

To recreate group instances one by one:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to recreate an instance group:

      ```bash
      {{ yc-compute-ig }} rolling-recreate --help
      ```

   1. Get a list of folders in the default cloud:

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```text
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
      | b1g66mft1vop******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

   1. Get a list of instance groups in the selected folder by specifying its name:

      ```bash
      {{ yc-compute-ig }} list \
        --folder-name <folder_name>
      ```

      Result:

      ```text
      +----------------------+-----------------------+--------+------+
      |          ID          |         NAME          | STATUS | SIZE |
      +----------------------+-----------------------+--------+------+
      | amc65sbgfqeq******** | first-instance-group  | ACTIVE |    4 |
      +----------------------+-----------------------+--------+------+
      ```

   1. Recreate instances in the instance group:

      ```bash
      {{ yc-compute-ig }} rolling-recreate --all \
        --name <instance_group_name> \
        --folder-name <folder_name>
      ```

      Where:
      * `--name`: Name of the instance group.
      * `--folder-name`: Name of the folder the instance group belongs to.

      {{ ig-name }} will begin to recreate all instances in the group one by one. The status of recreated instances will change to `Running`.

      Result:

      ```text
      done (2m43s)
      id: amc65sbgfqeq********
      ...
      status: ACTIVE
      application_load_balancer_state: {}
      ```

      To recreate individual instances in a group, [get](./get-list-instances.md) a list of instances in this group:

      ```bash
      {{ yc-compute-ig }} list-instances \
        --name <instance_group_name> \
        --folder-name <folder_name>
      ```

      Where:
      * `--name`: Name of the instance group.
      * `--folder-name`: Name of the folder the instance group belongs to.

      Result:

      ```text
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      | epdl7gdvb69f******** | cl17k72ehu54********-amyk | 130.193.**.*** | 192.168.0.33 | RUNNING_ACTUAL [8m]    |                |
      | epdjtb04efcf******** | cl17k72ehu54********-oper | 84.201.***.*** | 192.168.0.17 | RUNNING_ACTUAL [6m]    |                |
      | epd3anghn4vb******** | cl17k72ehu54********-axec | 84.201.***.*** | 192.168.0.14 | RUNNING_ACTUAL [1m50s] |                |
      | epdbt0c7o6d3******** | cl17k72ehu54********-ihez | 51.250.***.*** | 192.168.0.29 | RUNNING_ACTUAL [1m0s]  |                |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      ```

      Recreate the instances you need:

      ```bash
      {{ yc-compute-ig }} rolling-recreate \
        --instance-ids <instance_IDs> \
        --name <instance_group_name> \
        --folder-name <folder_name>
      ```

      Where:
      * `--instance-ids`: Comma-separated list of IDs of instances to be recreated. For example, to recreate the first and third instances from the above list, specify `--instance-ids epdl7gdvb69f********,epd3anghn4vb********`.
      * `--name`: Name of the instance group.
      * `--folder-name`: Name of the folder the instance group belongs to.

      {{ ig-name }} will begin to recreate the specified instances in the group one by one. The status of recreated instances will change to `Running`.

   For more information about the `{{ yc-compute-ig }} rolling-recreate` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance-group/rolling-recreate.md).

- API {#api}

   Use the [rollingRecreate](../../instancegroup/api-ref/InstanceGroup/rollingRecreate.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/RollingRecreate](../../instancegroup/api-ref/grpc/InstanceGroup/rollingRecreate.md) gRPC API call.

{% endlist %}