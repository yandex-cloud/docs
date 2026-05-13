# Получить информацию о коннекторе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [коннектор](../../../concepts/eventrouter/connector.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter** и выберите шину. 
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/broadcast-signal.svg) **Коннекторы** и выберите коннектор.
  1. На странице **Обзор** отобразится подробная информация о коннекторе.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [коннекторе](../../../concepts/eventrouter/connector.md):

     ```bash
     yc serverless eventrouter connector get --help
     ```

  1. Получите список коннекторов:
     
     ```bash
     yc serverless eventrouter connector list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     |          ID          |         NAME          |        BUS ID        |      FOLDER ID       | STATUS  | DELETION PROTECTION |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     | f66g4h59ih2g******** | connector-my-ydb-flow | f66qn4p7uk6p******** | b1g681qpemb4******** | STOPPED | true                |
     | f66g6jcnc5no******** | yds-via-cli           | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     | f66jfhcg1u71******** | mq-via-terraform      | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     ```

  1. Получите подробную информацию о коннекторе, указав его имя или идентификатор:

     ```bash
     yc serverless eventrouter connector get <идентификатор_коннектора>
     ```

     Результат:

     ```bash
     id: f66b9arad2ui********
     bus_id: f669a9niloj3********
     folder_id: b1gk6obg9bqf********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-23T14:01:46.256658Z"
     name: my-connector
     source:
       message_queue:
         queue_arn: yrn:yc:ymq:ru-central1:b1gk6obg9bqf********:my-queue
         service_account_id: ajeis9398lmk********
         visibility_timeout: 43200s
         batch_size: "10"
         polling_timeout: 10s
     status: RUNNING
     ```

- API {#api}

  Чтобы получить подробную информацию о [коннекторе](../../../concepts/eventrouter/connector.md), воспользуйтесь методом REST API [get](../../../eventrouter/api-ref/Connector/get.md) для ресурса [Connector](../../../eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Get](../../../eventrouter/api-ref/grpc/Connector/get.md).

{% endlist %}