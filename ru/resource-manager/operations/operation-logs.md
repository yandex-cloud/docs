# Посмотреть операции с ресурсами сервиса {{ resmgr-name }}

Все действия с ресурсами сервиса {{ resmgr-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции с облаком или каталогом:
  
  1. Перейдите в нужное облако или каталог.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ resmgr-name }}, воспользуйтесь командой:

  ```bash
  yc resource-manager <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для каталога:

  ```bash
  yc resource-manager folder list-operations b1g681qpemb4********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | b1g4jml98i8c******** | 2023-06-07 12:35:50 | aje9k8luj4qf******** | 2023-06-07 12:35:50 | DONE   | Update resource-manager.folder |
  |                      |                     |                      |                     |        | access bindings                |
  | b1g3cmmtt3u4******** | 2023-04-05 06:05:45 | ajeuddo5f7pj******** | 2023-04-05 06:05:45 | DONE   | Create folder                  |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc resource-manager folder list-operations b1g681qpemb4******** --format yaml
  ```

  Результат:

  ```text
  - id: b1g4jml98i8c********
    description: Update resource-manager.folder access bindings
    created_at: "2023-06-07T12:35:50.143Z"
    created_by: aje9k8luj4qf********
    modified_at: "2023-06-07T12:35:50.543823061Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.access.UpdateAccessBindingsMetadata
      resource_id: b1g681qpemb4********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  - id: b1g3cmmtt3u4********
    description: Create folder
    created_at: "2023-04-05T06:05:45.617732162Z"
    created_by: ajeuddo5f7pj********
    modified_at: "2023-04-05T06:05:45.617995551Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.resourcemanager.v1.CreateFolderMetadata
      folder_id: b1g681qpemb4********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для каталога воспользуйтесь методом REST API [listOperations](../api-ref/Folder/listOperations.md) для ресурса [Folder](../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/ListOperations](../api-ref/grpc/Folder/listOperations.md).

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

      ```text
      id: b1g4jml98i8c********
      description: Update resource-manager.folder access bindings
      created_at: "2023-06-07T12:35:50.143Z"
      created_by: aje9k8luj4qf********
      modified_at: "2023-06-07T12:35:50.543Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.access.UpdateAccessBindingsMetadata
        resource_id: b1g681qpemb4********
      response:
        '@type': type.googleapis.com/yandex.cloud.access.AccessBindingsOperationResult
      ```

   - API {#api}

     Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md).

   {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
