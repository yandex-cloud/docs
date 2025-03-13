# Посмотреть операции с ресурсами сервиса {{ at-full-name }}

Все действия с ресурсами сервиса {{ at-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится трейл.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Выберите нужный трейл.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного трейла.

     В открывшемся списке отображаются операции с выбранным трейлом.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для трейла, воспользуйтесь командой:

  ```bash
  yc audit-trails trail list-operations <имя_или_идентификатор_трейла>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION    |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  | cnpne9jsof71******** | 2024-03-26 16:57:32 | aje9k8luj4qf******** | 2024-03-26 16:57:32 | DONE   | operation_update |
  | cnp7308f90cf******** | 2024-03-26 16:50:22 | aje9k8luj4qf******** | 2024-03-26 16:50:23 | DONE   | operation_create |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc audit-trails trail list-operations <имя_или_идентификатор_трейла> --format yaml
  ```

  Результат:

  ```text
  - id: cnpne9jsof71********
    description: operation_update
    created_at: "2024-03-26T16:57:32.085739756Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-26T16:57:32.324291102Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.audittrails.v1.UpdateTrailMetadata
      trail_id: cnpr443sd0c0********
  - id: cnp7308f90cf********
    description: operation_create
    created_at: "2024-03-26T16:50:22.501Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-26T16:50:23.963321235Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.audittrails.v1.CreateTrailMetadata
      trail_id: cnpr443sd0c0********
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../api-ref/Trail/listOperations.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/ListOperations](../api-ref/grpc/Trail/listOperations.md).

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
      id: cnpne9jsof71********
      description: operation_update
      created_at: "2024-03-26T16:57:32.085Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-03-26T16:57:32.324Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.audittrails.v1.UpdateTrailMetadata
        trail_id: cnpr443sd0c0********
      response:
        '@type': type.googleapis.com/yandex.cloud.audittrails.v1.Trail
        id: cnpr443sd0c0********
        folder_id: b1g681qpemb4********
        created_at: "2024-03-26T16:50:22.505Z"
        updated_at: "2024-03-26T16:57:32.111Z"
        name: operat-ions
        destination:
          object_storage:
            bucket_id: for-********
            object_prefix: nuts
        service_account_id: ajeevjv1lv01********
        status: ACTIVE
        filter:
          path_filter:
            root:
              any_filter:
                resource:
                  id: b1g681qpemb4********
                  type: resource-manager.folder
          event_filter: {}
        cloud_id: b1gia87mbaom********
      ```

    - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
