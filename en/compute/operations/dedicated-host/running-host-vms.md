# Creating a VM on a dedicated host

A created VM will be linked to the host selected from a group of [dedicated hosts](../../concepts/dedicated-host.md). When the VM is stopped, it won't be available on the host, and when it's restarted, it will be linked to the same host from the group.

If you don't have a group of dedicated hosts, [create](create-host-group.md) one.

To create a VM:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Get the group ID for the dedicated host group where you need to create the VM:

      ```bash
      yc compute host-group list
      ```

      Result:

      ```bash
      +----------------------+------+---------------+--------+---------------------+------+
      |          ID          | NAME |     ZONE      | STATUS |        TYPE         | SIZE |
      +----------------------+------+---------------+--------+---------------------+------+
      | abcdefg1hi23gkl16dnf |      | {{ region-id }}-a | READY  | intel-6230-c66-m454 |    2 |
      +----------------------+------+---------------+--------+---------------------+------+
      ```

   1. Retrieve the ID of the group's dedicated host where you need to create the VM:

      ```bash
      yc compute host-group list-hosts <ID of the dedicated host group>
      ```

      Result:

      ```bash
      +----------------------+----------------------+
      |          ID          |      SERVER ID       |
      +----------------------+----------------------+
      | fhm1ab2mhnf3cd1610f5 | fhmlabct12vp3de45728 |
      | fhmabcun12kbbvhdeug3 | fhm1a2bcsl13ide4cqp2 |
      +----------------------+----------------------+
      ```

   1. Get a list of available subnets:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```bash
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

   1. Run the command to create a VM:

      ```bash
      yc compute instance create \
        --host-id <IDs of the dedicated hosts> \
        --zone <availability zone>
        --network-interface subnet-name=<subnet name> \
      ```

      Where:

      * `host-id`: ID of the dedicated host.
      * `zone` is the [availability zone](../../../overview/concepts/geo-scope.md) to place the group of dedicated hosts in.
      * `network-interface subnet-name` is the name of the subnet in the availability zone.

      To specify VM properties, use the parameters for the `yc compute instance create` command as described in the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/create.md). For more information, see [{#T}](../../concepts/vm.md) and [{#T}](../index.md#vm-create).

      Result:

      ```bash
      done (41s)
      id: fhm1abc23407de854r9e
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T08:00:55Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostId
          op: IN
          values:
          - fhm1ab2mhnf3cd1610f5
      ```

- API

   1. Find out  the ID of the dedicated host group using the [list](../../api-ref/HostGroup/list.md) method for the `HostGroup` resource.
   1. Find out the IDs of the dedicated hosts in the group using the [listHosts](../../api-ref/HostGroup/listHosts.md) method for the `HostGroup` resource.
   1. Create a VM using the [create](../../api-ref/Instance/create.md) method for the `Instance` resource.

{% endlist %}