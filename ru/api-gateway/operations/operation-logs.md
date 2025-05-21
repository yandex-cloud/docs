# Просмотр операций с ресурсами сервиса {{ api-gw-name }}

Все действия с ресурсами сервиса {{ api-gw-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для API-шлюза. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится API-шлюз.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/branches-right.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-gateways }}**.
  1. Выберите нужный API-шлюз.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_operations }}** для выбранного API-шлюза.

     В открывшемся списке отображаются операции с выбранным API-шлюзом.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ api-gw-name }}, воспользуйтесь командой:

  ```bash
  yc serverless <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для API-шлюза:

  ```bash
  yc serverless api-gateway list-operations epdplu8jn7sr********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION    |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  | d5d6ja2j20tj******** | 2024-06-21 09:59:41 | aje9k8luj4qf******** | 2024-06-21 09:59:43 | DONE   | operation_update |
  | d5dphtf4p0tp******** | 2024-06-21 09:51:17 | aje9k8luj4qf******** | 2024-06-21 09:51:20 | DONE   | operation_create |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc serverless api-gateway list-operations <имя_или_идентификатор_API-шлюза> --format yaml
  ```

  Результат:

  ```text
  - id: d5d6ja2j20tj********
    description: operation_update
    created_at: "2024-06-21T09:59:41.804Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-06-21T09:59:43.519Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayMetadata
      api_gateway_id: d5dig9e60uco********
  ...
  ```

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для API-шлюза воспользуйтесь методом REST API [listOperations](../apigateway/api-ref/ApiGateway/listOperations.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/ListOperations](../apigateway/api-ref/grpc/ApiGateway/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для API-шлюза.
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
        id: d5dphtf4p0tp********
        description: operation_create
        created_at: "2024-06-21T09:51:17.430Z"
        created_by: aje9k8luj4qf********
        modified_at: "2024-06-21T09:51:20.810Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.serverless.apigateway.v1.CreateApiGatewayMetadata
          api_gateway_id: d5dig9e60uco********
        response:
          '@type': type.googleapis.com/yandex.cloud.serverless.apigateway.v1.ApiGateway
          id: d5dig9e60uco********
          folder_id: b1g681qpemb4********
          created_at: "2024-06-21T09:51:17.489Z"
          name: operation-logs
          status: ACTIVE
          domain: {{ api-host-apigw }}
          connectivity: {}
          log_options:
            folder_id: b1g681qpemb4********
          execution_timeout: 300s
      ```

    - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../apigateway/api-ref/grpc/Operation/get.md).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
