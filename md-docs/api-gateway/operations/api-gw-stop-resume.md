[Документация Yandex Cloud](../../index.md) > [Yandex API Gateway](../index.md) > [Пошаговые инструкции](index.md) > Управление API-шлюзом > Остановить и запустить API-шлюз

# Остановить и запустить API-шлюз

После создания [API-шлюза](../concepts/index.md) вы можете остановить его и запустить заново.


# Остановить API-шлюз {#stop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите остановить API-шлюз.
  1. [Перейдите](https://console.yandex.cloud/link/api-gateway) в сервис **API Gateway**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![square](../../_assets/console-icons/square.svg) **Остановить**.

     API-шлюз перейдет в статус `Stopped`.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для остановки API-шлюза:

     ```bash
     yc serverless api-gateway stop --help
     ```

  1. Остановите API-шлюз:

     ```bash
     yc serverless api-gateway stop <имя_или_идентификатор_API-шлюза>
     ```

     Результат:

     ```text
     id: d5daqt0ofc4t********
     folder_id: b1g681qpemb4********
     created_at: "2026-08-20T12:56:16.354Z"
     name: my-gateway
     status: STOPPED
     domain: d5daqt0ofc4t********.********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       disabled: true
       folder_id: b1g681qpemb4********
     execution_timeout: 300s
     ```
- API {#api}

  Чтобы остановить API-шлюз, воспользуйтесь методом REST API [stop](../apigateway/api-ref/ApiGateway/stop.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Stop](../apigateway/api-ref/grpc/ApiGateway/stop.md).

{% endlist %}


# Запустить API-шлюз {#resume}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите запустить API-шлюз.
  1. [Перейдите](https://console.yandex.cloud/link/api-gateway) в сервис **API Gateway**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![play](../../_assets/console-icons/play.svg) **Запустить**.

     API-шлюз перейдет в статус `Active`.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для запуска API-шлюза:

     ```bash
     yc serverless api-gateway resume --help
     ```

  1. Запустите API-шлюз:

     ```bash
     yc serverless api-gateway resume <имя_или_идентификатор_API-шлюза>
     ```

     Результат:

     ```text
     id: d5daqt0ofc4t********
     folder_id: b1g681qpemb4********
     created_at: "2026-08-20T12:56:16.354Z"
     name: my-gateway
     status: ACTIVE
     domain: d5daqt0ofc4t********.********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       disabled: true
       folder_id: b1g681qpemb4********
     execution_timeout: 300s
      ```

- API {#api}

  Чтобы запустить API-шлюз, воспользуйтесь методом REST API [resume](../apigateway/api-ref/ApiGateway/resume.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Resume](../apigateway/api-ref/grpc/ApiGateway/resume.md).

{% endlist %}