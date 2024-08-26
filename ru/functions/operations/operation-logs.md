# Просмотр операций с ресурсами сервиса

Все действия с ресурсами сервиса {{ sf-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для функции. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится функция.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
  1. Выберите нужную функцию.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранной функции.

     В открывшемся списке отображаются операции с выбранной функцией.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ sf-name }}, воспользуйтесь командой:

  ```bash
  yc serverless <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для функции:

  ```bash
  yc serverless function list-operations epdplu8jn7sr********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  | d4e952nebqdb******** | 2024-06-19 08:33:11 | aje9k8luj4qf******** | 2024-06-19 08:33:12 | DONE   | Create session  |
  | d4elh7hqnj7g******** | 2024-06-19 08:33:04 | aje9k8luj4qf******** | 2024-06-19 08:33:04 | DONE   | Create function |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc serverless function list-operations <имя_или_идентификатор_ресурса> --format yaml
  ```

  Результат:

  ```bash
  - id: d4e952nebqdb********
    description: Create session
    created_at: "2024-06-19T08:33:11.658Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-06-19T08:33:12.345Z"
    done: true
    metadata:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ...
  ```

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для функции воспользуйтесь методом REST API [listOperations](../functions/api-ref/Function/listOperations.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/ListOperations](../functions/api-ref/grpc/function_service.md#ListOperations).

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
        id: d4elh7hqnj7g********
        description: Create function
        created_at: "2024-06-19T08:33:04.513Z"
        created_by: aje9k8luj4qf********
        modified_at: "2024-06-19T08:33:04.665Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.serverless.functions.v1.CreateFunctionMetadata
          function_id: d4e3f75v8kti********
        response:
          '@type': type.googleapis.com/yandex.cloud.serverless.functions.v1.Function
          id: d4e3f75v8kti********
          folder_id: b1g681qpemb4********
          created_at: "2024-06-19T08:33:04.587Z"
          name: my-db-function
          http_invoke_url: https://functions.yandexcloud.net/d4e3f75v8kti********
          status: ACTIVE
      ```

   - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../functions/api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
