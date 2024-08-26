# Просмотр операций с ресурсами сервиса

Все действия с ресурсами сервиса {{ serverless-containers-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для контейнера. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится контейнер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/boxes-3.svg) **{{ ui-key.yacloud.serverless-containers.label_containers }}**.
  1. Выберите нужный контейнер.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного контейнера.

      В открывшемся списке отображаются операции с выбранным контейнером.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ serverless-containers-name }}, воспользуйтесь командой:

  ```bash
  yc serverless <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для контейнера:

  ```bash
  yc serverless container list-operations epdplu8jn7sr********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION    |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  | bba1fu790ass******** | 2024-06-21 10:56:42 | aje9k8luj4qf******** | 2024-06-21 10:56:42 | DONE   | Update container |
  | bbaogemlt3jf******** | 2024-06-21 10:51:57 | aje9k8luj4qf******** | 2024-06-21 10:51:57 | DONE   | Create container |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc serverless container list-operations <имя_или_идентификатор_ресурса> --format yaml
  ```

  Результат:

  ```bash
  - id: bba1fu790ass********
    description: Update container
    created_at: "2024-06-21T10:56:42.746Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-06-21T10:56:42.763Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.serverless.containers.v1.UpdateContainerMetadata
      container_id: bbaqss6v9qv9********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ...
  ```

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для контейнера воспользуйтесь методом REST API [listOperations](../containers/api-ref/Container/listOperations.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/ListOperations](../containers/api-ref/grpc/container_service.md#ListOperations).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для ресурса.
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

      ```bash
      id: bbaogemlt3jf********
      description: Create container
      created_at: "2024-06-21T10:51:57.338Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-06-21T10:51:57.881Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.serverless.containers.v1.CreateContainerMetadata
        container_id: bbaqss6v9qv9********
      response:
        '@type': type.googleapis.com/yandex.cloud.serverless.containers.v1.Container
        id: bbaqss6v9qv9********
        folder_id: b1g681qpemb4********
        created_at: "2024-06-21T10:51:57.350Z"
        name: simple-container
        url: https://bbaqss6v9qv9********.containers.yandexcloud.net/
        status: ACTIVE
      ```

   - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../containers/api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
