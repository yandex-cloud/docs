---
title: Creating a group of dedicated hosts
description: Follow this guide to create dedicated host groups.
---

# Creating a group of dedicated hosts


You can create a group of [dedicated hosts](../../concepts/dedicated-host.md) that is intended solely for hosting your VMs in {{ yandex-cloud }}.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

To create a group of dedicated hosts:

{% list tabs group=instructions %}

- CLI {#cli}

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
        --fixed-size <number_of_dedicated_hosts_in_group> \
        --type <dedicated_host_type> \
        --zone <availability_zone>
      ```

      Where:

      * `--fixed-size`: Number of dedicated hosts in the group.
      * `--type`: Type of dedicated hosts.
      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) to place the group in.

      Result:

      ```text
      done (6s)
      id: abcdefg1hi23********
      folder_id: m4n56op78mev********
      created_at: "2020-10-13T07:36:49Z"
      zone_id: {{ region-id }}-a
      status: READY
      type_id: intel-6230-c66-m454
      maintenance_policy: RESTART
      scale_policy:
        fixed_scale:
          size: "2"
      ```

- API {#api}

  1. Select the host type using the [list](../../api-ref/HostType/list.md) REST API method for the [HostType](../../api-ref/HostType/index.md) resource or the [HostTypeService/List](../../api-ref/grpc/HostType/list.md) gRPC API call.
  1. Create a group of dedicated hosts using the [create](../../api-ref/HostGroup/create.md) REST API method for the [HostGroup](../../api-ref/HostGroup/index.md) resource or the [HostGroupService/Create](../../api-ref/grpc/HostGroup/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](running-host-group-vms.md)
* [{#T}](running-host-vms.md)