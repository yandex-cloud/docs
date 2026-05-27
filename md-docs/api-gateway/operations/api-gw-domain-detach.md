# Отключить домен

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится API-шлюз.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **API Gateway**.
  1. Нажмите на имя нужного API-шлюза.
  1. Перейдите на вкладку **Домены**.
  1. В строке с доменом нажмите кнопку ![image](../../_assets/options.svg) и выберите **Отключить**.
  1. Подтвердите отключение.
  1. Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
      * Если ваш домен делегирован Cloud DNS:

        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
        1. Выберите зону, в которой находится домен.
        1. Нажмите ![image](../../_assets/options.svg) в строке записи со значком ![image](../../_assets/api-gateway/service-icon.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.
        1. Подтвердите удаление.

      * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- API {#api}

  Чтобы отключить домен от API-шлюза, воспользуйтесь методом REST API [removeDomain](../apigateway/api-ref/ApiGateway/removeDomain.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/RemoveDomain](../apigateway/api-ref/grpc/ApiGateway/removeDomain.md).

  Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
  * Если ваш домен делегирован Cloud DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

  * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

{% endlist %}