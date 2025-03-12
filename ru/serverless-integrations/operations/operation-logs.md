# Просмотр операций с ресурсами сервиса {{ si-name }}

Все действия с ресурсами сервиса {{ si-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для шины {{ er-name }}. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится шина.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную шину.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранной шины.

     В открывшемся списке отображаются операции с выбранной шиной.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ si-name }}, воспользуйтесь командой:

  ```bash
  yc serverless <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для шины {{ er-name }}:

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

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

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

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<ресурс>/ListOperations`.

  Например, для шины {{ er-name }} воспользуйтесь методом REST API [listOperations](../../serverless-integrations/eventrouter/api-ref/Bus/listOperations.md) для ресурса [Bus](../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/ListOperations](../../serverless-integrations/eventrouter/api-ref/grpc/Bus/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations).
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

* [{#T}](../../api-design-guide/concepts/about-async.md)
