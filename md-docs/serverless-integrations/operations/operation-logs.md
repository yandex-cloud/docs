# Просмотр операций с ресурсами сервиса Serverless Integrations

Все действия с ресурсами сервиса Serverless Integrations сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для шины EventRouter. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится шина.
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева выберите ![image](../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную шину.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **Операции** для выбранной шины.

     В открывшемся списке отображаются операции с выбранной шиной.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для ресурса сервиса Serverless Integrations, воспользуйтесь командой:

  ```bash
  yc serverless <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для шины EventRouter:

  ```bash
  yc serverless eventrouter bus list-operations epdplu8jn7sr********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | f66oon77ahgu******** | 2025-02-24 20:48:53 | ajevfb0tjfts******** | 2025-02-24 20:48:53 | DONE   | Изменение шины |
  | f66a237f2f6v******** | 2025-02-24 20:48:30 | ajevfb0tjfts******** | 2025-02-24 20:48:30 | DONE   | Изменение шины |
  | f66cbrh8c1u4******** | 2025-02-20 12:22:56 | ajevfb0tjfts******** | 2025-02-20 12:22:57 | DONE   | Создание шины  |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc serverless eventrouter bus list-operations <имя_или_идентификатор_шины> --format yaml
  ```

  Результат:

  ```yaml
  - id: f66oon77ahgu********
    description: Изменение шины
    created_at: "2025-02-24T20:48:53.942469190Z"
    created_by: ajevfb0tjfts********
    modified_at: "2025-02-24T20:48:53.956957528Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.serverless.eventrouter.v1.UpdateBusMetadata
      bus_id: f662ctjn8vv4********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ...
  ```

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для шины EventRouter воспользуйтесь методом REST API [listOperations](../eventrouter/api-ref/Bus/listOperations.md) для ресурса [Bus](../eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/ListOperations](../eventrouter/api-ref/grpc/Bus/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations).
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      Результат:

      ```text
      id: f66oon77ahgu********
      description: Изменение шины
      created_at: "2025-02-24T20:48:53.942Z"
      created_by: ajevfb0tjfts********
      modified_at: "2025-02-24T20:48:53.956Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.serverless.eventrouter.v1.UpdateBusMetadata
        bus_id: f662ctjn8vv4********
      response:
        '@type': type.googleapis.com/yandex.cloud.serverless.eventrouter.v1.Bus
        id: f662ctjn8vv4********
        folder_id: b1geoelk7fld********
        cloud_id: b1gia87mbaom********
        created_at: "2025-02-20T12:22:57.005054Z"
        name: test
        description: tesst
        status: ACTIVE
      ```

    - API {#api}

      Чтобы получить подробную информацию об операции, воспользуйтесь методом REST API `get` для ресурса `Operation` или вызовом gRPC API `OperationService/Get`.

    {% endlist %}

#### См. также {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)