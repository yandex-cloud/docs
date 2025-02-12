# Sequentially restarting instances in a group

You can [sequentially restart group instances](../../concepts/instance-groups/rolling-actions.md) based on the parameters specified in the [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md).

For example, if the deployment policy specifies a maximum of `1` unavailable instance per group, then only one instance will be down at any given time when sequentially restarting instances.

{% include [ig-opportunistic-warning](../../../_includes/compute/ig-opportunistic-warning.md) %}

To sequentially restart instances in a group:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for restarting an instance group:

      ```bash
      {{ yc-compute-ig }} rolling-restart --help
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

  1. Restart VM instances in the instance group:

      ```bash
      {{ yc-compute-ig }} rolling-restart --all \
        --name <instance_group_name> \
        --folder-name <folder_name>
      ```

      Where:
      * `--name`: Instance group name.
      * `--folder-name`: Name of the folder the instance group belongs to.

      {{ ig-name }} will begin restarting all instances in the group one by one. The restarted instances will change their status to `Running`.

      Result:

      ```text
      done (2m43s)
      id: amc65sbgfqeq********
      ...
      status: ACTIVE
      application_load_balancer_state: {}
      ```

      To restart individual instances in a group, [get](./get-list-instances.md) a list of instances in that group:

      ```bash
      {{ yc-compute-ig }} list-instances \
        --name <instance_group_name> \
        --folder-name <folder_name>
      ```

      Where:
      * `--name`: Instance group name.
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

      Restart the VM instances in question:

      ```bash
      {{ yc-compute-ig }} rolling-restart \
        --instance-ids <VM_instance_IDs> \
        --name <instance_group_name> \
        --folder-name <folder_name>
      ```

      Where:
      * `--instance-ids`: Comma-separated IDs of instances to restart. For example, to restart the first and third instances from those listed, specify `--instance-ids epdl7gdvb69f********,epd3anghn4vb********`.
      * `--name`: Instance group name.
      * `--folder-name`: Name of the folder the instance group belongs to.
      
      {{ ig-name }} will begin restarting the specified instances in the group one by one. The restarted instances will change their status to `Running`.

  For more information about the `{{ yc-compute-ig }} rolling-restart` command parameters, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance-group/rolling-restart.md).

- API {#api}

  Use the [rollingRestart](../../instancegroup/api-ref/InstanceGroup/rollingRestart.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/rollingRestart](../../instancegroup/api-ref/grpc/InstanceGroup/rollingRestart.md) gRPC API call.

{% endlist %}