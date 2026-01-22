---
title: How to manage networks and IP prefixes in a {{ cr-name }} routing instance
description: Follow this guide to update a list of networks and IP prefixes in a {{ cr-name }} routing instance.
---

# Managing networks and IP prefixes in a routing instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

## Updating networks and IP prefixes in a routing instance {#update-networks}

You can use the `yc cloudrouter routing-instance update-networks` {{ yandex-cloud }} CLI [command](../cli-ref/routing-instance/update-networks.md) to simultaneously manage multiple [announced IP prefixes](../concepts/announces.md) of {{ vpc-full-name }} cloud [networks](../../vpc/concepts/network.md#network) added to a [routing instance](../concepts/routing-instance.md), as well as add new networks to a routing instance and delete the existing ones. 

{% include [ri-roles-necessary](../../_includes/cloud-router/ri-roles-necessary.md) %}

### Adding a cloud network to a routing instance {#add-network}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. {% include [ri-update-networks-help](../../_includes/cloud-router/ri-update-networks-help.md) %}
  1. {% include [ri-list-cli](../../_includes/cloud-router/ri-list-cli.md) %}
  1. {% include [ri-update-networks-get](../../_includes/cloud-router/ri-update-networks-get.md) %}
  1. Add a new network with an announced IP prefix to the routing instance by specifying this network's [ID](../../vpc/operations/network-get-info.md) under `id` in the `--add-vpc-net` parameter:

      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <folder_ID> \
        --id c3lgk007olse******** \
        --add-vpc-net id=enpvt41bh5gk********,zone={{ region-id }}-a,ipv4-prefixes=192.168.100.0/24,192.168.101.0/24 \
        --async
      ```

      Result:

      ```text
      id: foku4jbrp07i********
      description: routing instance update prefix mask
      created_at: "2025-12-23T08:35:04.852963002Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-12-23T08:35:04.852963002Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3lgk007olse********
      ```

      {% include [ri-async-output-legend](../../_includes/cloud-router/ri-async-output-legend.md) %}

  1. Wait for the operation to [complete](../../cli/cli-ref/operation/cli-ref/get.md) and make sure the routing instance configuration has been updated:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <folder_ID>
      ```

      Result:

      
      ```text
      id: c3lgk007olse********
      name: ri1
      description: Routing instance 1
      folder_id: b1gt6g8ht345********
      region_id: {{ region-id }}
      vpc_info:
        - vpc_network_id: enpcfncr6uldme5e5929
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-d
                prefixes:
                  - 192.168.7.0/24
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 192.168.2.0/24
            - manual_info:
                az_id: {{ region-id }}-b
                prefixes:
                  - 192.168.15.0/24
        - vpc_network_id: enpt8ok6snlp********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 192.168.45.0/24
                  - 192.168.46.0/24
        - vpc_network_id: enpvt41bh5gk********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 192.168.100.0/24
                  - 192.168.101.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3or586ln29********
        - cic_private_connection_id: cf3uj9uph7b6********
      status: ACTIVE
      created_at: "2025-12-23T08:35:07Z"
      ```


      {% include [ri-output-legend](../../_includes/cloud-router/ri-output-legend.md) %}

{% endlist %}

### Deleting an existing cloud network from a routing instance {#remove-network}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. {% include [ri-update-networks-help](../../_includes/cloud-router/ri-update-networks-help.md) %}
  1. {% include [ri-list-cli](../../_includes/cloud-router/ri-list-cli.md) %}
  1. {% include [ri-update-networks-get](../../_includes/cloud-router/ri-update-networks-get.md) %}
  1. Delete an existing network from the routing instance:

      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <folder_ID> \
        --id c3lgk007olse******** \
        --delete-vpc-net-id id=enpt8ok6snlp******** \
        --async
      ```

      Result:

      ```text
      id: fokg66rcqie1********
      description: routing instance update prefix mask
      created_at: "2025-12-23T08:53:09.626102995Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-12-23T08:53:09.626102995Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3lgk007olse********
      ```

      {% include [ri-async-output-legend](../../_includes/cloud-router/ri-async-output-legend.md) %}

  1. Wait for the operation to [complete](../../cli/cli-ref/operation/cli-ref/get.md) and make sure the routing instance configuration has been updated:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <folder_ID>
      ```

      Result:

      
      ```text
      id: c3lgk007olse********
      name: ri1
      description: Routing instance 1
      folder_id: b1gt6g8ht345********
      region_id: {{ region-id }}
      vpc_info:
        - vpc_network_id: enpcfncr6uldme5e5929
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-d
                prefixes:
                  - 192.168.7.0/24
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 192.168.2.0/24
            - manual_info:
                az_id: {{ region-id }}-b
                prefixes:
                  - 192.168.15.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3or586ln29********
        - cic_private_connection_id: cf3uj9uph7b6********
      status: ACTIVE
      created_at: "2025-12-23T08:35:07Z"
      ```


      {% include [ri-output-legend](../../_includes/cloud-router/ri-output-legend.md) %}

{% endlist %}

### Updating IP prefixes of existing cloud networks in a routing instance {#update-prefixes}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. {% include [ri-update-networks-help](../../_includes/cloud-router/ri-update-networks-help.md) %}
  1. {% include [ri-list-cli](../../_includes/cloud-router/ri-list-cli.md) %}
  1. {% include [ri-update-networks-get](../../_includes/cloud-router/ri-update-networks-get.md) %}
  1. Update the announced IP prefixes in the routing instance:

      
      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <folder_ID> \
        --id c3lgk007olse******** \
        --update-vpc-net id=enpcfncr6uld********,zone={{ region-id }}-a,ipv4-prefixes=192.168.2.0/28 \
        --update-vpc-net id=enpcfncr6uld********,zone={{ region-id }}-b,ipv4-prefixes=192.168.15.0/24 \
        --update-vpc-net id=enpcfncr6uld********,zone={{ region-id }}-d,ipv4-prefixes=192.168.7.0/24 \
        --update-vpc-net id=enpt8ok6snlp********,zone={{ region-id }}-d,ipv4-prefixes=192.168.47.0/28 \
        --async
      ```


      Result:

      ```text
      id: fokr80vgdskp********
      description: routing instance update prefix mask
      created_at: "2025-12-23T09:56:40.259684884Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-12-23T09:56:40.259684884Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3lgk007olse********
      ```

      {% include [ri-async-output-legend](../../_includes/cloud-router/ri-async-output-legend.md) %}

  1. Wait for the operation to [complete](../../cli/cli-ref/operation/cli-ref/get.md) and make sure the routing instance configuration has been updated:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <folder_ID>
      ```

      Result:

      
      ```text
      id: c3lgk007olse********
      name: ri1
      description: Routing instance 1
      folder_id: b1gt6g8ht345********
      region_id: {{ region-id }}
      vpc_info:
        - vpc_network_id: enpcfncr6uld********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 192.168.2.0/28
            - manual_info:
                az_id: {{ region-id }}-b
                prefixes:
                  - 192.168.15.0/24
            - manual_info:
                az_id: {{ region-id }}-d
                prefixes:
                  - 192.168.7.0/24
        - vpc_network_id: enpt8ok6snlp********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 192.168.47.0/28
      cic_private_connection_info:
        - cic_private_connection_id: cf3or586ln29********
        - cic_private_connection_id: cf3uj9uph7b6********
      status: ACTIVE
      created_at: "2025-12-23T10:46:55Z"
      ```


      {% include [ri-output-legend](../../_includes/cloud-router/ri-output-legend.md) %}

{% endlist %}

## Adding IP prefixes to a routing instance {#upsert-prefixes}

You can use the `yc cloudrouter routing-instance upsert-prefixes` {{ yandex-cloud }} CLI [command](../cli-ref/routing-instance/upsert-prefixes.md) to [announce new IP prefixes](../concepts/announces.md) in a routing instance.

{% note tip %}

If you need to add new IP prefixes to a routing instance while also deleting all or some of its existing prefixes, [use](#update-networks) the `yc cloudrouter routing-instance update-networks` command.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. See the description of the CLI command for updating a list of IP prefixes in a [routing instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance upsert-prefixes --help
      ```

  1. View the routing instance configuration and the list of IP prefixes:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <folder_ID>
      ```

      Where `--folder-id` is the [ID of the folder](../../resource-manager/operations/folder/get-id.md) containing the routing instance.

      Result:

      ```text
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: {{ region-id }}
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 10.128.0.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```
  1. Add more prefixes to the routing instance IP prefix list:

      {% include [ri-roles-necessary](../../_includes/cloud-router/ri-roles-necessary.md) %}

      
      ```bash
      yc cloudrouter routing-instance upsert-prefixes c3l871dpin4f******** \
        --folder-id <folder_ID> \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-b,ipv4-prefixes=10.129.0.0/24 \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-d,ipv4-prefixes=172.16.1.0/24 \
        --async
      ```


      Result:

      ```text
      id: al457njn6pj1********
      description: routing instance upsert prefixes
      created_at: "2025-03-24T15:24:15.817401507Z"
      created_by: bfbudv7dfn22********
      modified_at: "2025-03-24T15:24:15.817401507Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l871dpin4f********
      ```

      {% include [ri-async-output-legend](../../_includes/cloud-router/ri-async-output-legend.md) %}

  1. Wait for the operation to [complete](../../cli/cli-ref/operation/cli-ref/get.md) and make sure the routing instance configuration has been updated:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <folder_ID>
      ```

      Result:

      
      ```
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: {{ region-id }}
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 10.128.0.0/24
            - manual_info:
                az_id: {{ region-id }}-b
                prefixes:
                  - 10.129.0.0/24
            - manual_info:
                az_id: {{ region-id }}-d
                prefixes:
                  - 172.16.1.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```


      Where:

      {% include [ri-output-legend](../../_includes/cloud-router/ri-output-legend.md) %}

{% endlist %}

## Deleting IP prefixes from a routing instance {#remove-prefixes}

You can use the `yc cloudrouter routing-instance remove-prefixes` {{ yandex-cloud }} CLI [command](../cli-ref/routing-instance/remove-prefixes.md) to delete [announced IP prefixes](../concepts/announces.md) from a routing instance.

{% note tip %}

If you need to delete existing IP prefixes from a routing instance while also adding new prefixes to it, [use](#update-networks) the `yc cloudrouter routing-instance update-networks` command.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. See the description of the CLI command for deleting IP prefixes from a [routing instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance remove-prefixes --help
      ```

  1. View the routing instance configuration and the list of IP prefixes:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <folder_ID>
      ```

      Where `--folder-id` is the [ID of the folder](../../resource-manager/operations/folder/get-id.md) containing the routing instance.

      Result:

      
      ```text
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: {{ region-id }}
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-a
                prefixes:
                  - 10.128.0.0/24
            - manual_info:
                az_id: {{ region-id }}-b
                prefixes:
                  - 10.129.0.0/24
            - manual_info:
                az_id: {{ region-id }}-d
                prefixes:
                  - 172.16.1.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```


  1. Delete IP prefixes from the routing instance:

      {% include [ri-roles-necessary](../../_includes/cloud-router/ri-roles-necessary.md) %}

      
      ```bash
      yc cloudrouter routing-instance remove-prefixes c3l871dpin4f******** \
        --folder-id <folder_ID> \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-b,ipv4-prefixes=10.128.0.0/24 \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-d,ipv4-prefixes=10.129.0.0/24 \
        --async
      ```


      Result:

      ```text
      id: al457njn6pj1********
      description: routing instance remove prefixes
      created_at: "2025-03-24T15:24:15.817401507Z"
      created_by: bfbudv7dfn22********
      modified_at: "2025-03-24T15:24:15.817401507Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l871dpin4f********
      ```

      {% include [ri-async-output-legend](../../_includes/cloud-router/ri-async-output-legend.md) %}

  1. Wait for the operation to [complete](../../cli/cli-ref/operation/cli-ref/get.md) and make sure the routing instance configuration has been updated:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <folder_ID>
      ```

      Result:

      
      ```text
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: {{ region-id }}
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
          az_infos:
            - manual_info:
                az_id: {{ region-id }}-d
                prefixes:
                  - 172.16.1.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```


      Where:

      {% include [ri-output-legend](../../_includes/cloud-router/ri-output-legend.md) %}

{% endlist %}