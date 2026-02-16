---
title: Как управлять сетями и IP-префиксами в Routing Instance {{ cr-name }}
description: Следуя этой инструкции, вы сможете изменить список сетей и IP-префиксов в Routing Instance в {{ cr-name }}.
---

# Управлять сетями и IP-префиксами в Routing Instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

## Изменить сети и IP-префиксы в Routing Instance {#update-networks}

[Команда](../cli-ref/routing-instance/update-networks.md) {{ yandex-cloud }} CLI `yc cloudrouter routing-instance update-networks` позволяет одновременно управлять набором [анонсированных IP-префиксов](../concepts/announces.md) облачных [сетей](../../vpc/concepts/network.md#network) {{ vpc-full-name }}, добавленных в [Routing Instance](../concepts/routing-instance.md), а также добавлять новые сети в Routing Instance и удалять имеющиеся. 

{% include [ri-roles-necessary](../../_includes/cloud-router/ri-roles-necessary.md) %}

### Добавить новую облачную сеть в Routing Instance {#add-network}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. {% include [ri-update-networks-help](../../_includes/cloud-router/ri-update-networks-help.md) %}
  1. {% include [ri-list-cli](../../_includes/cloud-router/ri-list-cli.md) %}
  1. {% include [ri-update-networks-get](../../_includes/cloud-router/ri-update-networks-get.md) %}
  1. Добавьте в Routing Instance новую сеть с анонсированным IP-префиксом, указав [идентификатор](../../vpc/operations/network-get-info.md) этой сети в поле `id` параметра `--add-vpc-net`:

      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <идентификатор_каталога> \
        --id c3lgk007olse******** \
        --add-vpc-net id=enpvt41bh5gk********,zone={{ region-id }}-a,ipv4-prefixes=192.168.100.0/24,192.168.101.0/24 \
        --async
      ```

      Результат:

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

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация Routing Instance изменилась:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
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

### Удалить имеющуюся облачную сеть из Routing Instance {#remove-network}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. {% include [ri-update-networks-help](../../_includes/cloud-router/ri-update-networks-help.md) %}
  1. {% include [ri-list-cli](../../_includes/cloud-router/ri-list-cli.md) %}
  1. {% include [ri-update-networks-get](../../_includes/cloud-router/ri-update-networks-get.md) %}
  1. Удалите из Routing Instance имеющуюся сеть:

      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <идентификатор_каталога> \
        --id c3lgk007olse******** \
        --delete-vpc-net-id id=enpt8ok6snlp******** \
        --async
      ```

      Результат:

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

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация Routing Instance изменилась:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
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

### Обновить IP-префиксы имеющихся облачных сетей в Routing Instance {#update-prefixes}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. {% include [ri-update-networks-help](../../_includes/cloud-router/ri-update-networks-help.md) %}
  1. {% include [ri-list-cli](../../_includes/cloud-router/ri-list-cli.md) %}
  1. {% include [ri-update-networks-get](../../_includes/cloud-router/ri-update-networks-get.md) %}
  1. Обновите анонсированные IP-префиксы в Routing Instance:

      
      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <идентификатор_каталога> \
        --id c3lgk007olse******** \
        --update-vpc-net id=enpcfncr6uld********,zone={{ region-id }}-a,ipv4-prefixes=192.168.2.0/28 \
        --update-vpc-net id=enpcfncr6uld********,zone={{ region-id }}-b,ipv4-prefixes=192.168.15.0/24 \
        --update-vpc-net id=enpcfncr6uld********,zone={{ region-id }}-d,ipv4-prefixes=192.168.7.0/24 \
        --update-vpc-net id=enpt8ok6snlp********,zone={{ region-id }}-d,ipv4-prefixes=192.168.47.0/28 \
        --async
      ```


      Результат:

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

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация Routing Instance изменилась:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
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

## Добавить IP-префиксы в Routing Instance {#upsert-prefixes}

[Команда](../cli-ref/routing-instance/upsert-prefixes.md) {{ yandex-cloud }} CLI `yc cloudrouter routing-instance upsert-prefixes` позволяет [анонсировать новые IP-префиксы](../concepts/announces.md) в Routing Instance.

{% note tip %}

Если вам необходимо добавить в Routing Instance новые IP-префиксы с одновременным удалением всех или части имеющихся в нем префиксов, [воспользуйтесь](#update-networks) командой `yc cloudrouter routing-instance update-networks`.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для изменения списка IP-префиксов в [Routing Instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance upsert-prefixes --help
      ```

  1. Посмотрите конфигурацию Routing Instance и состав IP-префиксов:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Где `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором находится нужный Routing Instance.

      Результат:

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
  1. Добавьте дополнительные префиксы в список IP-префиксов Routing Instance:

      {% include [ri-roles-necessary](../../_includes/cloud-router/ri-roles-necessary.md) %}

      
      ```bash
      yc cloudrouter routing-instance upsert-prefixes c3l871dpin4f******** \
        --folder-id <идентификатор_каталога> \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-b,ipv4-prefixes=10.129.0.0/24 \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-d,ipv4-prefixes=172.16.1.0/24 \
        --async
      ```


      Результат:

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

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация Routing Instance изменилась:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
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


      Где:

      {% include [ri-output-legend](../../_includes/cloud-router/ri-output-legend.md) %}

{% endlist %}

## Удалить IP-префиксы из Routing Instance {#remove-prefixes}

[Команда](../cli-ref/routing-instance/remove-prefixes.md) {{ yandex-cloud }} CLI `yc cloudrouter routing-instance remove-prefixes` позволяет удалить [анонсированные IP-префиксы](../concepts/announces.md) из Routing Instance.

{% note tip %}

Если вам необходимо удалить имеющиеся IP-префиксы из Routing Instance с одновременным добавлением в него новых префиксов, [воспользуйтесь](#update-networks) командой `yc cloudrouter routing-instance update-networks`.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для удаления IP-префиксов из [Routing Instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance remove-prefixes --help
      ```

  1. Посмотрите конфигурацию Routing Instance и состав IP-префиксов:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Где `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором находится нужный Routing Instance.

      Результат:

      
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


  1. Удалите IP-префиксы из Routing Instance:

      {% include [ri-roles-necessary](../../_includes/cloud-router/ri-roles-necessary.md) %}

      
      ```bash
      yc cloudrouter routing-instance remove-prefixes c3l871dpin4f******** \
        --folder-id <идентификатор_каталога> \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-b,ipv4-prefixes=10.128.0.0/24 \
        --vpc-net id=c64ckjtr7b3l********,zone={{ region-id }}-d,ipv4-prefixes=10.129.0.0/24 \
        --async
      ```


      Результат:

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

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация Routing Instance изменилась:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
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


      Где:

      {% include [ri-output-legend](../../_includes/cloud-router/ri-output-legend.md) %}

{% endlist %}