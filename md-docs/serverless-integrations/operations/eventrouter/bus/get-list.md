# Получить список шин

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список [шин](../../../concepts/eventrouter/bus.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**. На странице **Шины** отобразится список шин.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра списка [шин](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus list --help
      ```

  1. Получите список шин:
     
     ```bash
     yc serverless eventrouter bus list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------------+----------------------+--------+---------------------+
     |          ID          |       NAME       |      FOLDER ID       | STATUS | DELETION PROTECTION |
     +----------------------+------------------+----------------------+--------+---------------------+
     | f6676a9ti657******** | my-new-bus-17    | b1g681qpemb4******** | ACTIVE | false               |
     | f66aevm4ithv******** | my-favourite-bus | b1g681qpemb4******** | ACTIVE | true                |
     | f66m2q222n92******** | my-bus-42        | b1g681qpemb4******** | ACTIVE | false               |
     +----------------------+------------------+----------------------+--------+---------------------+
     ```

- API {#api}

  Чтобы посмотреть список [шин](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [list](../../../eventrouter/api-ref/Bus/list.md) для ресурса [Bus](../../../eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/List](../../../eventrouter/api-ref/grpc/Bus/list.md).

{% endlist %}