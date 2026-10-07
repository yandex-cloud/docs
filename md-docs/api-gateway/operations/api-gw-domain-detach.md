[Документация Yandex Cloud](../../index.md) > [Yandex API Gateway](../index.md) > [Пошаговые инструкции](index.md) > Управление API-шлюзом > Отключить домен

# Отключить домен

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится API-шлюз.
  1. [Перейдите](https://console.yandex.cloud/link/api-gateway) в сервис **API Gateway**.
  1. Нажмите на имя нужного API-шлюза.
  1. Перейдите на вкладку **Домены**.
  1. В строке с доменом нажмите кнопку ![image](../../_assets/options.svg) и выберите **Отключить**.
  1. Подтвердите отключение.
  1. Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
      * Если ваш домен делегирован Cloud DNS:

        1. [Перейдите](https://console.yandex.cloud/link/dns) в сервис **Cloud DNS**.
        1. Выберите зону, в которой находится домен.
        1. Нажмите ![image](../../_assets/options.svg) в строке записи со значком ![image](../../_assets/api-gateway/service-icon.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.
        1. Подтвердите удаление.

      * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отключения домена:

      ```bash
      yc serverless api-gateway remove-domain --help
      ```

  1. Выполните команду:

      ```bash
      yc serverless api-gateway remove-domain <идентификатор_API-шлюза> --domain-id <идентификатор_домена>
      ```

  1. Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
      * Если ваш домен делегирован Cloud DNS:

        1. Получите список всех записей в зоне DNS, указав идентификатор этой зоны:

            ```
            yc dns zone list-records <идентификатор_зоны_DNS>
            ```
        
            Нужная запись имеет тип `ANAME` и значение вида `d5dm1lba80md********.i9******.apigw.yandexcloud.net`.

        1. Удалите запись:

            ```
            yc dns zone delete-records <идентификатор_зоны_DNS> \
              --record "<доменное_имя> <TTL> <тип_записи> <значение>"
            ```

      * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и удалите блок `custom_domains` с отключаемым доменом из описания ресурса `yandex_api_gateway`:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
       name = "<имя_API-шлюза>"
       ...
       custom_domains {
         fqdn           = "<доменное_имя>"
         certificate_id = "<идентификатор_сертификата>"
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_api_gateway` читайте в [документации провайдера](../../terraform/resources/api_gateway.md).

  1. Примените изменения:

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

  1. Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:

      * Если ваш домен делегирован Cloud DNS, [удалите](../../dns/operations/resource-record-delete.md) ANAME-запись в зоне DNS.

      * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

- API {#api}

  Чтобы отключить домен от API-шлюза, воспользуйтесь методом REST API [removeDomain](../apigateway/api-ref/ApiGateway/removeDomain.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/RemoveDomain](../apigateway/api-ref/grpc/ApiGateway/removeDomain.md).

  Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
  * Если ваш домен делегирован Cloud DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

  * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

{% endlist %}