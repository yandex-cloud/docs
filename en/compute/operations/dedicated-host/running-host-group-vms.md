# Creating a VM in a group of dedicated hosts

A created VM will be linked to one of the hosts in the group. When the VM is stopped, it won't be available on the group hosts, and when it's restarted, it may be linked to a different host from the group.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

To create a VM that is linked to a group of dedicated hosts, follow these steps:

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
      done (6s)
      id: abcdefg1hi23gkl16dnf
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T07:36:49Z"
      zone_id: {{ region-id }}-a
      status: READY
      type_id: intel-6230-c66-m454
      maintenance_policy: RESTART
      scale_policy:
        fixed_scale:
          size: "2"
      ```

   1. View the ID of the dedicated host group to link your VM to:

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

   1. Create a VM that is linked to a group of dedicated hosts.

      For more information about how to create a VM, see [Creating VMs](../../operations/index.md#vm-create).

      ```bash
      yc compute instance create \
        --host-group-id abcdefg1hi23gkl16dnf \
        --network-interface subnet-name=network-{{ region-id }}-a \
        --zone {{ region-id }}-a
      ```

      Where:

      * `host-group-id`: ID of the dedicated host group.
      * `subnet-name`: Name of the selected subnet.
      * `zone`: Availability zone that corresponds to the selected subnet.

      Result:

      ```bash
      done (20s)
      id: fhmbdt1jj2k3ls036909
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T07:41:19Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostGroupId
          op: IN
          values:
          - abcdefg1hi23gkl16dnf
      ```

- API

   1. Select the host type using the [list](../../api-ref/HostType/list.md) method for the `HostType` resource.

   1. Create a group of dedicated hosts using the [Create](../../api-ref/HostGroup/create.md) method for the `HostGroup` resource.

   1. View the ID of the dedicated host group using the [list](../../api-ref/HostGroup/list.md) method for the `HostGroup` resource.

   1. Create a VM that is linked to a group of dedicated hosts using the [Create](../../api-ref/Instance/create.md) method for the `Instance`.

{% endlist %}