[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > EventRouter > Управление коннектором > Запустить коннектор

# Запустить коннектор

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите запустить [коннектор](../../../concepts/eventrouter/connector.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **Коннекторы**.
  1. В строке с нужным коннектором нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/play.svg) **Запустить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для запуска [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector start --help
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
  1. Запустите коннектор:

      ```bash
      yc serverless eventrouter connector start <имя_или_идентификатор_коннектора>
      ```

      Результат:

      ```text
      id: f66g4h59ih2g********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-20T15:30:05.248052Z"
      name: renamed-ydb
      ...
      status: RUNNING
      ```

- API {#api}

  Чтобы запустить [коннектор](../../../concepts/eventrouter/connector.md), воспользуйтесь методом REST API [Start](../../../eventrouter/api-ref/Connector/start.md) для ресурса [Connector](../../../eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [Connector/Start](../../../eventrouter/api-ref/grpc/Connector/start.md).

{% endlist %}