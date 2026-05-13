# Включить правило

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите включить [правило](../../../concepts/eventrouter/rule.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **Правила**.
  1. В строке с нужным правилом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/toggle-on.svg) **Включить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для включения [правила](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule enable --help
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
  1. Включите правило:

      ```bash
      yc serverless eventrouter rule enable <имя_или_идентификатор_правила>
      ```

      Результат:

      ```text
      id: f66aa46qtt1l********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T10:30:59.611601Z"
      name: renamed-rule
      ...
      status: ENABLED
      ```

- API {#api}

  Чтобы включить [правило](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Enable](../../../eventrouter/api-ref/Rule/enable.md) для ресурса [Rule](../../../eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Enable](../../../eventrouter/api-ref/grpc/Rule/enable.md).

{% endlist %}