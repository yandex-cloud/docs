# Перенести зону DNS в другой каталог

При создании [зоны DNS](../concepts/dns-zone.md) она размещается в текущем каталоге.

В Yandex Cloud есть возможность переместить зону DNS в другой каталог.

[Подробнее об иерархии ресурсов в Yandex Cloud](../../resource-manager/concepts/resources-hierarchy.md).

## Ограничения {#limits}

При переносе зоны DNS метрики в [Yandex Monitoring](../../monitoring/index.md) не переносятся. Те, что были в предыдущем каталоге, останутся в нём, а новые метрики будут создаваться уже в новом каталоге.

## Перенести зону DNS {#relocate-zone}

### Изменить каталог зоны {#change-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

      Подробнее о команде `yc dns zone move` в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/move.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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
      * `zone` — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://ru.wikipedia.org/wiki/Punycode).
      * `public` — видимость зоны: публичная или внутренняя.
      * `folder_id` — идентификатор каталога, в котором должна размещаться зона DNS (по умолчанию указывается из [переменной окружения](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials)).

      Подробнее о параметрах ресурса `yandex_dns_zone` в [документации провайдера](../../terraform/resources/dns_zone.md).

  1. Примените новую конфигурацию:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform перенесет зону DNS в указанный каталог без пересоздания. Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

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
        "https://dns.api.cloud.yandex.net/dns/v1/zones/${dnsZoneId}:move"
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

    Подробное описание метода в [справочнике gRPC API](../api-ref/grpc/DnsZone/move.md).

{% endlist %}