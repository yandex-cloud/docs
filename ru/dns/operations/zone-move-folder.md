---
title: Как перенести зону DNS в другой каталог в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете перенести зону DNS в другой каталог.
---

# Перенести зону DNS в другой каталог

При создании [зоны DNS](../concepts/dns-zone.md) она размещается в текущем каталоге.

В {{ yandex-cloud }} есть возможность переместить зону DNS в другой каталог.

[Подробнее об иерархии ресурсов в {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md).

## Ограничения {#limits}

При переносе зоны DNS метрики в [{{ monitoring-full-name }}](../../monitoring/) не переносятся. Те, что были в предыдущем каталоге, останутся в нём, а новые метрики будут создаваться уже в новом каталоге.

## Перенести зону DNS {#relocate-zone}

### Изменить каталог зоны {#change-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите список всех зон DNS в каталоге по умолчанию:

      ```bash
      yc dns zone list
      ```

      Результат:

      ```bash
      +----------------------+---------------------+--------------+----------------------------------------------------+
      |          ID          |        NAME         |     ZONE     |   VISIBILITY   |             DESCRIPTION           |
      +----------------------+---------------------+--------------+----------------+-----------------------------------+
      | aet29qhara5j******** | my-public-zone      | example.com. | PUBLIC         | Automatically created DNS for ... |
      | aet2q4fn8i8i******** | my-private-zone     | internal.    | PRIVATE        | Automatically created DNS for ... |
      +----------------------+---------------------+--------------+----------------+-----------------------------------+
      ```      

  1. Получите список всех каталогов в облаке по умолчанию:

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
      | b1g66mft1vop******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. Посмотрите описание команды CLI для переноса зоны DNS:

      ```bash
      yc dns zone move --help
      ```

  1. Перенесите зону DNS в другой каталог со следующими параметрами: 
      
      * в параметре `id` укажите идентификатор зоны DNS, например `aet29qhara5j********`;
      * в параметре `destination-folder-id` укажите идентификатор целевого каталога, например `b1g66mft1vop********`.

      ```bash
      yc dns zone move \
        --id aet29qhara5j******** \
        --destination-folder-id b1g66mft1vop********
      ```

      Подробнее о команде `yc dns zone move` см. в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/move.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. [Настройте](../../resource-manager/operations/folder/set-access-bindings.md) права доступа к целевому каталогу. У аккаунта из исходного каталога, от имени которого вы будете выполнять операцию, должна быть минимальная [роль](../security/index.md) `dns.editor` на целевой каталог.

  1. [Получите идентификатор целевого каталога](../../resource-manager/operations/folder/get-id.md).
  1. В конфигурационном файле в ресурсе `yandex_dns_zone` измените параметр `folder_id`:

      ```hcl
      resource "yandex_dns_zone" "zone1" {
          name        = "<имя_зоны>"
          description = "<описание_зоны>"
          zone        = "<доменная_зона>."
          public      = true
          folder_id   = "<идентификатор_целевого_каталога>"
      }
      ```

      Где:

      * `name` — имя зоны. Должно быть уникальным внутри каталога.
      * `description` — описание зоны. 
      * `zone` — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).
      * `public` — видимость зоны: публичная или внутренняя.
      * `folder_id` — идентификатор каталога, в котором должна размещаться зона DNS (по умолчанию указывается из [переменной окружения](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials)).

      Более подробную информацию о параметрах ресурса `yandex_dns_zone` см. в [документации провайдера]({{ tf-provider-resources-link }}/dns_zone).

  1. Примените новую конфигурацию:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} перенесет зону DNS в указанный каталог без пересоздания. Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [move](../api-ref/DnsZone/move.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Move](../api-ref/grpc/DnsZone/move.md).

  #### Пример REST API {#rest-api}

  Ниже описан пример Bash-скрипта для ОС Linux.
  
  Чтобы воспользоваться примером, [аутентифицируйтесь](../api-ref/authentication.md) в API и установите утилиту [cURL](https://curl.haxx.se).

  1. Создайте файл для скрипта:

      ```bash
      sudo touch <имя_файла>
      ```

  1. Откройте файл для записи:

      ```bash
      sudo nano <имя_файла>
      ```
  
  1. Поместите скрипт в файл:

      ```bash
      #!/bin/bash

      # Создание переменных

      export IAM_TOKEN=`yc iam create-token`
      
      dnsZoneId='<идентификатор_DNS_зоны>'
      destinationFolderId='<идентификатор_каталога>'
      
      # Перемещение зоны DNS

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "Content-Type: application/json" \
        --data '{ "destinationFolderId": "'"${destinationFolderId}"'" }' \
        "https://dns.{{ api-host }}/dns/v1/zones/${dnsZoneId}:move"
      ```

      Где:

      * `IAM_TOKEN` — IAM-токен для аутентификации в API.
      * `dnsZoneId` — идентификатор зоны DNS, которую надо перенести.
      * `destinationFolderId` — идентификатор каталога, в который будет перенесена зона DNS.

  1. Сделайте файл исполняемым:

      ```bash
      chmod +x <имя_файла>
      ```

  1. Выполните скрипт:

      ```bash
      ./<имя_файла>
      ```

  #### Пример gRPC API {#grpc-api}

  Ниже описан пример Bash-скрипта для вызова gRPC API с использованием утилиты `grpcurl`.

  1. Установите `grpcurl`:
        
        * С помощью Bash:
        
            ```bash
            curl -L https://github.com/fullstorydev/grpcurl/releases/download/v1.9.3/grpcurl_1.9.3_linux_x86_64.tar.gz | tar -xz
            sudo mv grpcurl /usr/local/bin/
            ```
            
        * С помощью Golang:

            ```go
            go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
            ```

  1. Создайте файл для скрипта:

      ```bash
      sudo touch <имя_файла>
      ```

  1. Откройте файл для записи:

      ```bash
      nano <имя_файла>
      ```

  1. Поместите скрипт в файл:

      ```bash
      #!/bin/bash

      # Создание переменных

      export IAM_TOKEN=$(yc iam create-token)

      dnsZoneId='<идентификатор_DNS_зоны>'
      destinationFolderId='<идентификатор_каталога>'

      # Перемещение зоны DNS

      grpcurl \
      -d "{
          \"dns_zone_id\": \"${dnsZoneId}\",
          \"destination_folder_id\": \"${destinationFolderId}\"
      }" \
      -H "authorization: Bearer ${IAM_TOKEN}" \
      -H "x-client-request-id: $(uuidgen)" \
      dns.api.cloud.yandex.net:443 \
      yandex.cloud.dns.v1.DnsZoneService/Move
      ```

      Где:

      * `IAM_TOKEN` — IAM-токен для аутентификации в API.
      * `dnsZoneId` — идентификатор зоны DNS, которую надо перенести.
      * `destinationFolderId` — идентификатор каталога, в который будет перенесена зона DNS.
      * `x-client-request-id` — уникальный идентификатор запроса для трассировки.

  1. Сделайте файл исполняемым:

      ```bash
      chmod +x <имя_файла>
      ```

  1. Выполните скрипт:

      ```bash
      ./<имя_файла>
      ```
 
    В ответ вы получите операцию в формате JSON:

    ```json
    {
        "id": "dns-zone-move-123456789",
        "description": "Update DNS Zone",
        "createdAt": "2026-02-19T09:52:35.239149422Z",
        "createdBy": "aje6f5h1h2h3********",
        "modifiedAt": "2026-02-19T09:52:35.239218092Z",
        "done": true,
        "metadata": {
            "@type": "type.googleapis.com/yandex.cloud.dns.v1.MoveDnsZoneMetadata",
            "dnsZoneId": "aet29qhara5j********"
        },
        "response": {
            "@type": "type.googleapis.com/yandex.cloud.dns.v1.DnsZone",
            "createdAt": "2026-02-19T07:09:53.853Z",
            "folderId": "b1g66mft1vop********",
            "id": "aet29qhara5j********",
            "name": "my-public-zone",
            "publicVisibility": {},
            "zone": "example.com."
        }
    }
    ```

    Где:

    * `id` — уникальный идентификатор операции.
    * `metadata.dnsZoneId` — ID перемещаемой зоны DNS.
    * `response` — обновленная зона DNS после переноса.
    * `done` — статус завершения операции.

    Подробное описание метода см. в [справочнике gRPC API](../api-ref/grpc/DnsZone/move.md).

{% endlist %}
