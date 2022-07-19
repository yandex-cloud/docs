# Creating a VM on a dedicated host

A created VM will be linked to the host selected from a group of hosts. When the VM is stopped, it won't be available on the host, and when it's restarted, it will be linked to the same host from the group.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

To create a VM on a dedicated host, follow these steps:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the list of available dedicated host types:

      ```bash
      yc compute host-type list
      ```

      Result:

      ```bash
      +---------------------+-------+--------------+
      |         ID          | CORES |    MEMORY    |
      +---------------------+-------+--------------+
      | intel-6230-c66-m454 |    66 | 487478788096 |
      +---------------------+-------+--------------+
      ```

   1. Create a group of dedicated hosts of the selected type. A group may contain one or more hosts.

      ```bash
      yc compute host-group create \
        --fixed-size 2 \
        --type intel-6230-c66-m454 \
        --zone {{ region-id }}-a
      ```

      Where:

      * `fixed-size`: The number of dedicated hosts in the group.
      * `type`: The type of dedicated hosts.
      * `zone`: [availability zone](../../../overview/concepts/geo-scope.md).

      Result:

      ```bash
      done (5s)
      id: fhm123hj4l56abcg10qf
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T07:54:08Z"
      zone_id: {{ region-id }}-a
      status: READY
      type_id: intel-6230-c66-m454
      maintenance_policy: RESTART
      scale_policy:
        fixed_scale:
          size: "2"
      ```

   1. View the IDs of the dedicated hosts in the group and select the host to create your VM on:

      ```bash
      yc compute host-group list-hosts fhm123hj4l56abcg10qf
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

   1. Create a VM that is linked to a dedicated host.

      For more information about how to create a VM, see [Creating VMs](../../operations/index.md#vm-create).

      ```bash
      yc compute instance create \
        --host-id fhm1ab2mhnf3cd1610f5 \
        --network-interface subnet-name=network-{{ region-id }}-a \
        --zone {{ region-id }}-a
      ```

      Where:

      * `host-id`: ID of the dedicated host.
      * `subnet-name`: Name of the selected subnet.
      * `zone`: Availability zone that corresponds to the selected subnet.

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

   1. Select the host type using the [list](../../api-ref/HostType/list.md) method for the `HostType` resource.

   1. Create a group of dedicated hosts using the [Create](../../api-ref/HostGroup/create.md) method for the `HostGroup` resource.

   1. Check out the IDs of the dedicated hosts in the group using the [listHosts](../../api-ref/HostGroup/listHosts.md) method for the `HostGroup` resource.

   1. Create a VM on a dedicated host using the [Create](../../api-ref/Instance/create.md) method for the `Instance`.

{% endlist %}