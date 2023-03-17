# Creating a group of dedicated hosts

You can create a group of [dedicated hosts](../../concepts/dedicated-host.md) that is intended solely for hosting your VMs in {{ yandex-cloud }}.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

To create a group of dedicated hosts:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the list of available dedicated host [types](../../concepts/dedicated-host.md#host-types):

      ```bash
      yc compute host-type list
      ```

      Result:

      {% include [dedicated-types-cli-output](../../../_includes/compute/dedicated-types-cli-output.md) %}

   1. Create a group of dedicated hosts of the selected type. A group may contain one or more hosts.

      ```bash
      yc compute host-group create \
        --fixed-size <number of dedicated hosts in the group> \
        --type <type of dedicated hosts> \
        --zone <availability zone>
      ```

      Where:

      * `fixed-size`: Number of dedicated hosts in the group.
      * `type`: Type of dedicated hosts.
      * `zone`: [Availability](../../../overview/concepts/geo-scope.md) zone to place the group in.

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

- API

   1. Select the host type using the [list](../../api-ref/HostType/list.md) method for the `HostType` resource.
   1. Create a group of dedicated hosts using the [create](../../api-ref/HostGroup/create.md) method for the `HostGroup` resource.

{% endlist %}

#### See also {#see-also}

* [{#T}](running-host-group-vms.md)
* [{#T}](running-host-vms.md)