---
title: Как удалить ресурсную запись в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете удалить ресурсную запись.
---

# Удалить ресурсную запись

Чтобы удалить [ресурсную запись](../concepts/resource-record.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится зона DNS из которой требуется удалить запись.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите зону из списка.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке записи, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления записей:

      ```
      yc dns zone delete-records --help
      ```
  1. Получите список всех записей в зоне:

      ```
      yc dns zone list-records --name <имя_зоны>
      ```
  1. Если у записи есть описание, сбросьте его перед удалением:

      ```
      yc dns zone add-records --name <имя_зоны> \
      --record "<доменное_имя> <TTL> <тип_записи> <значение>" \
      --description ""
      ```
  1. Удалите запись:

     ```
     yc dns zone delete-records --name <имя_зоны> \
     --record "<доменное_имя> <TTL> <тип_записи> <значение>"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить из зоны DNS запись, созданную с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием DNS записи.
     
     {% cut "Пример описания DNS записи в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_dns_recordset" "rs1" {
       zone_id     = yandex_dns_zone.zone1.id
       name        = "srv.example.com."
       type        = "A"
       ttl         = 200
       data        = ["10.1.0.1"]
       description = "Web server"
     }
     ...
     ```

     {% endcut %}


  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone list-records <имя_зоны>
     ```

- API {#api}
  
  Чтобы удалить ресурсную запись, воспользуйтесь одним из методов:

  * [upsertRecordSets](../api-ref/DnsZone/upsertRecordSets.md) — метод REST API для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызов gRPC API [DnsZoneService/UpsertRecordSets](../api-ref/grpc/DnsZone/upsertRecordSets.md). Метод не требует точного совпадения поля `description`.

  * [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) — метод REST API для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызов gRPC API [DnsZoneService/UpdateRecordSets](../api-ref/grpc/DnsZone/updateRecordSets.md). Метод требует точного совпадения всех полей записи, включая `description`.

  #### Пример REST API для метода upsertRecordSets {#rest-api}

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

      export IAM_TOKEN=$(yc iam create-token)

      dnsZoneId='<идентификатор_DNS_зоны>'
      recordName='<доменное_имя>'
      recordType='<тип_записи>'
      recordTtl='<TTL>'
      recordData='<значение>'

      # Удаление записи через upsertRecordSets

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "Content-Type: application/json" \
        --data '{
          "deletions": [
            {
              "name": "'"${recordName}"'",
              "type": "'"${recordType}"'",
              "ttl": "'"${recordTtl}"'",
              "data": ["'"${recordData}"'"]
            }
          ]
        }' \
        "https://dns.api.cloud.yandex.net/dns/v1/zones/${dnsZoneId}:upsertRecordSets"
      ```

      Где:

      * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) для аутентификации в API.
      * `dnsZoneId` — идентификатор зоны DNS. Чтобы узнать идентификатор, [получите список зон DNS](zone-list.md).
      * `recordName` — доменное имя записи, например `srv.example.com.`.
      * `recordType` — тип записи, например `A`.
      * `recordTtl` — время жизни записи (TTL) в секундах, например `600`.
      * `recordData` — значение записи, например `10.1.0.1`.

      {% note tip %}

      Чтобы использовать метод `updateRecordSets`, замените в URL `upsertRecordSets` на `updateRecordSets`. Учтите, что в этом случае все поля записи, включая `description`, должны точно совпадать.

      {% endnote %}

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
    "id": "dns1234567890abcdef",
    "description": "",
    "createdAt": "2025-01-15T12:00:00.000000000Z",
    "createdBy": "aje1234567890abcdef",
    "modifiedAt": "2025-01-15T12:00:00.000000000Z",
    "done": true,
    "metadata": {},
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.dns.v1.RecordSetDiff",
      "additions": [],
      "deletions": [
        {
          "name": "srv.example.com.",
          "type": "A",
          "ttl": "600",
          "data": ["10.1.0.1"]
        }
      ]
    }
  }
  ```

  Где:

  * `id` — уникальный идентификатор операции.
  * `done` — статус завершения операции.
  * `response.deletions` — список удаленных записей.

  #### Пример gRPC API для метода upsertRecordSets {#grpc-api}

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
      recordName='<доменное_имя>'
      recordType='<тип_записи>'
      recordTtl='<TTL>'
      recordData='<значение>'

      # Удаление записи через UpsertRecordSets

      grpcurl \
        -d "{
          \"dns_zone_id\": \"${dnsZoneId}\",
          \"deletions\": [
            {
              \"name\": \"${recordName}\",
              \"type\": \"${recordType}\",
              \"ttl\": \"${recordTtl}\",
              \"data\": [\"${recordData}\"]
            }
          ]
        }" \
        -H "authorization: Bearer ${IAM_TOKEN}" \
        -H "x-client-request-id: $(uuidgen)" \
        dns.api.cloud.yandex.net:443 \
        yandex.cloud.dns.v1.DnsZoneService/UpsertRecordSets
      ```

      Где:

      * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) для аутентификации в API.
      * `dnsZoneId` — идентификатор зоны DNS. Чтобы узнать идентификатор, [получите список зон DNS](zone-list.md).
      * `recordName` — доменное имя записи, например `srv.example.com.`.
      * `recordType` — тип записи, например `A`.
      * `recordTtl` — время жизни записи (TTL) в секундах, например `600`.
      * `recordData` — значение записи, например `10.1.0.1`.
      * `x-client-request-id` — уникальный идентификатор запроса для трассировки.

      {% note tip %}

      Чтобы использовать метод `UpdateRecordSets`, замените в скрипте `UpsertRecordSets` на `UpdateRecordSets`. Учтите, что в этом случае все поля записи, включая `description`, должны точно совпадать.

      {% endnote %}

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
    "id": "dns1234567890abcdef",
    "description": "",
    "createdAt": "2025-01-15T12:00:00.000000000Z",
    "createdBy": "aje1234567890abcdef",
    "modifiedAt": "2025-01-15T12:00:00.000000000Z",
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.dns.v1.UpsertRecordSetsMetadata"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.dns.v1.RecordSetDiff",
      "additions": [],
      "deletions": [
        {
          "name": "srv.example.com.",
          "type": "A",
          "ttl": "600",
          "data": ["10.1.0.1"]
        }
      ]
    }
  }
  ```

  Где:

  * `id` — уникальный идентификатор операции.
  * `done` — статус завершения операции.
  * `metadata` — метаданные операции.
  * `response.deletions` — список удаленных записей.

  Подробное описание метода см. в [справочнике gRPC API](../api-ref/grpc/DnsZone/upsertRecordSets.md).

  {% endlist %}