# Посмотреть операции с ресурсами сервиса

Все действия с ресурсами сервиса {{ backup-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми ресурсами сервиса, на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

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
      id: cdg4g6c4jlak********
      description: apply policy
      created_at: "2024-05-14T15:24:23.800129Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-05-14T15:24:23.800129Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.backup.v1.ApplyPolicyMetadata
      response:
        '@type': type.googleapis.com/google.protobuf.Empty
        value: {}
      ```

    - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../backup/api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)