# Просмотр операций с ресурсами сервиса

Все действия с ресурсами сервиса {{ iot-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для реестра. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится реестр.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.iot.label_registries }}**.
  1. Выберите нужный реестр.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного реестра.

     В открывшемся списке отображаются операции с выбранным реестром.

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для реестра воспользуйтесь методом REST API [listOperations](../api-ref/Registry/listOperations.md) для ресурса [Registry](../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListOperations](../api-ref/grpc/registry_service.md#ListOperations).

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
      id: areojeqlg1bh********
      description: Create device registry
      created_at: "2024-06-19T06:23:13.216Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-06-19T06:23:13.265Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.iot.devices.v1.CreateRegistryMetadata
        registry_id: aresm2hpmh4s********
      response:
        '@type': type.googleapis.com/yandex.cloud.iot.devices.v1.Registry
        id: aresm2hpmh4s********
        folder_id: b1g681qpemb4********
        created_at: "2024-06-19T06:23:13.245974425Z"
        name: my-registry
        status: ACTIVE
        log_options:
          folder_id: b1g681qpemb4********
      ```

   - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
