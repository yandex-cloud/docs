[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > EventRouter > Получение информации о правиле > Получить информацию о правиле

# Получить информацию о правиле

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [правило](../../../concepts/eventrouter/rule.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **Правила**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Выберите правило. На странице **Обзор** отобразится подробная информация о правиле.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [правиле](../../../concepts/eventrouter/rule.md):

     ```bash
     yc serverless eventrouter rule get --help
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

  1. Получите подробную информацию о правиле, указав его имя или идентификатор:

     ```bash
     yc serverless eventrouter rule get <идентификатор_правила>
     ```

     Результат:

     ```text
     id: f66ir9eeie4e********
     bus_id: f662ctjn8vv4********
     folder_id: b1geoelk7fld********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-20T12:26:40.769479Z"
     name: rule1
     targets:
       - logging:
           folder_id: b1geoelk7fld********
           service_account_id: ajebg060mvrb********
         status: ENABLED
     status: ENABLED
     ```

- API {#api}

  Чтобы получить информацию о [правиле](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [get](../../../eventrouter/api-ref/Rule/get.md) для ресурса [Rule](../../../eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [RuleService/Get](../../../eventrouter/api-ref/grpc/Rule/get.md).

{% endlist %}