# Получить список правил

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список [правил](../../../concepts/eventrouter/rule.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **Правила**. На странице **Правила** отобразится список правил.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../../cli/index.md) для просмотра списка [правил](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule list --help
      ```

  1. Получите список правил:
     
     ```bash
     yc serverless eventrouter rule list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------+----------------------+----------------------+---------+---------------------+
     |          ID          | NAME  |        BUS ID        |      FOLDER ID       | TARGETS | DELETION PROTECTION |
     +----------------------+-------+----------------------+----------------------+---------+---------------------+
     | f66ir9eeie4e******** | rule1 | f662ctjn8vo6******** | b1geoelk7fld******** | Logging | false               |
     | f66q0kq19n2q******** | rule2 | f662ctjn8vv4******** | b1geoelk7fld******** | YMQ     | false               |
     +----------------------+-------+----------------------+----------------------+---------+---------------------+
     ```

- API {#api}

  Чтобы посмотреть список [правил](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [list](../../../eventrouter/api-ref/Rule/list.md) для ресурса [Rule](../../../eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [RuleService/List](../../../eventrouter/api-ref/grpc/Rule/list.md).

{% endlist %}