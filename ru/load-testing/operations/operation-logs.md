# Посмотреть операции с ресурсами сервиса

Все действия с ресурсами сервиса {{ load-testing-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором вы хотите посмотреть операции.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

  В открывшемся списке также отображаются операции для ресурсов, которые были удалены.
  
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

      ```yaml
      id: ff67zb1214j6********
      description: Create Job
      created_at: "2024-02-01T09:07:33.271288Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T09:07:33.398853Z"
      done: true
      metadata:
        '@type': type.googleapis.com/google.protobuf.Empty
        value: {}
      response:
        '@type': type.googleapis.com/google.protobuf.Empty
        value: {}
      ```

    - API {#api}

      Воспользуйтесь методом REST API [get](../../api-design-guide/concepts/operation.md#monitoring), или вызовом gRPC API [OperationService/Get](../user/api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
