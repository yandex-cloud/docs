---
title: "Как перенести подсеть в другую зону доступности"
description: "Следуя данной инструкции, вы сможете перенести подсеть в другую зону доступности."
---


# Перенести подсеть в другую зону доступности

[Подсеть](../concepts/network.md) можно перенести в другую [зону доступности](../../overview/concepts/geo-scope.md). Для переноса подсеть должна быть пустой, в ней не должно быть [виртуальных машин](../../glossary/vm.md) и других ресурсов.

Чтобы перенести подсеть в другую зону доступности:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для переноса подсети:

      ```bash
      yc vpc subnet relocate --help
      ```

  1. В каталоге по умолчанию узнайте идентификатор подсети, которую требуется перенести:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```text
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      |          ID          |   NAME   |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      | e9bcd5mq43cn******** | subnet-a | encb4ubvmief******** |                | {{ region-id }}-a | [10.1.0.0/16]    |
      | e2llon52hhss******** | subnet-b | enc39op1vq9m******** |                | {{ region-id }}-b | [192.168.1.0/24] |
      | b0cscj0f9uq5******** | subnet-c | enc772aa2rgq******** |                | {{ region-id }}-c | [10.0.0.0/16]    |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      ```

      {% include [non-empty-subnet-relocate-notice](../../_includes/compute/subnet-relocate-novms-warning.md) %}

  1. Перенесите подсеть:

      ```bash
      yc vpc subnet relocate \
        --id <идентификатор_подсети> \
        --destination-zone-id <идентификатор_зоны_доступности>
      ```

      Где:
      * `--id` — идентификатор подсети, которую требуется перенести.
      * `--destination-zone-id` — идентификатор зоны доступности, в которую требуется перенести подсеть. Возможные значения:

          * `{{ region-id }}-a`;
          * `{{ region-id }}-b`;       
          * `{{ region-id }}-c`;
          * `{{ region-id }}-d`.

      Пример:
    
      ```
      yc vpc subnet relocate \
        --id e9bcd5mq43cn******** \
        --destination-zone-id {{ region-id }}-d
      ```

      Результат:
      
      ```
      id: e9bcd5mq43cn********
      folder_id: b1gt6g8ht345********
      created_at: "2023-10-06T10:30:06Z"
      name: subnet-a
      network_id: encb4ubvmief********
      zone_id: {{ region-id }}-d
      v4_cidr_blocks:
        - 10.1.0.0/16   
      dhcp_options: {}        
      ```

      Подробнее о команде `yc vpc subnet relocate` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/relocate.md).

- API {#api}

  Воспользуйтесь методом REST API [relocate](../api-ref/Subnet/relocate.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Relocate](../api-ref/grpc/subnet_service#Relocate).

  **Пример запроса**

  Чтобы воспользоваться примером, установите [cURL](https://curl.haxx.se).

  1. [Получите](../../iam/operations/index.md#iam-tokens) IAM-токен, чтобы [аутентифицироваться](../api-ref/authentication.md) в API.
  
  1. Сохраните полученный IAM-токен в переменную:

      ```bash
      export IAM_TOKEN=<полученный_IAM-токен>
      ```

  1. Подготовьте файл `body.json` с телом запроса, указав идентификатор [зоны доступности](../../overview/concepts/geo-scope.md), в которую требуется перенести подсеть:

      ```json
      {
        "destinationZoneId": "<идентификатор_зоны_доступности>"
      }
      ```

  1. Выполните запрос:

      ```bash
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@<файл_с_телом_запроса>" \
          https://vpc.api.cloud.yandex.net/vpc/v1/subnets/<идентификатор_подсети>:relocate
      ```

      Где:
      * `<файл_с_телом_запроса>` — путь к созданному ранее файлу с телом запроса `body.json`.
      * `<идентификатор_подсети>` — идентификатор подсети, которую требуется перенести в новую зону доступности.

      {% include [non-empty-subnet-relocate-notice](../../_includes/compute/subnet-relocate-novms-warning.md) %}

      Результат:
        
      ```json
      {
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.vpc.v1.RelocateSubnetMetadata",
          "subnetId": "b0cnd1srghnm********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.vpc.v1.Subnet",
          "v4CidrBlocks": [
            "192.168.3.0/24"
          ],
          "dhcpOptions": {},
          "id": "b0cnd1srghnm********",
          "folderId": "b1gt6g8ht345********",
          "createdAt": "2023-10-06T10:30:06Z",
          "name": "subnet-c",
          "networkId": "enpv51f8lple********",
          "zoneId": "{{ region-id }}-d"
        },
        "id": "enpfitqeageu********",
        "description": "Relocate subnet to other zone",
        "createdAt": "2023-11-02T10:40:52.330608134Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2023-11-02T10:40:52.782965099Z"
      }
      ```

{% endlist %}
