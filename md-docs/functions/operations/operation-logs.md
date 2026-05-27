# Просмотр операций с ресурсами сервиса Cloud Functions

Все действия с ресурсами сервиса Cloud Functions сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для функции. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится функция.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../_assets/console-icons/curly-brackets-function.svg) **Функции**.
  1. Выберите нужную функцию.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **Операции** для выбранной функции.

     В открывшемся списке отображаются операции с выбранной функцией.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для ресурса сервиса Cloud Functions, воспользуйтесь командой:

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

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc serverless function list-operations <имя_или_идентификатор_ресурса> --format yaml
  ```

  Результат:

  ```text
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

  Например, для функции воспользуйтесь методом REST API [listOperations](../functions/api-ref/Function/listOperations.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/ListOperations](../functions/api-ref/grpc/Function/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для ресурса.
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

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../functions/api-ref/grpc/Operation/get.md).

    {% endlist %}

#### См. также {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)