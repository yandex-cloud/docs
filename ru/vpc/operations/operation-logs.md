# Посмотреть операции с ресурсами сервиса

Все действия с ресурсами сервиса {{ vpc-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми ресурсами сервиса, на панели слева выберите ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для облачной сети. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится облачная сеть.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Выберите нужную сеть.
  1. Перейдите на панель ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

     В открывшемся списке отображаются операции с облачной сетью.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ vpc-name }}, выполните команду:

  ```bash
  yc vpc <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для облачной сети:

  ```bash
  yc vpc network list-operations enpgl5o8te3k********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | enp75021agjg******** | 2024-02-01 10:16:51 | ajego134p5h1******** | 2024-02-01 10:16:53 | DONE   | Create network |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc vpc network list-operations enpgl5o8te3k******** --format yaml
  ```

  Результат:

  ```bash
  - id: enp75021agjg********
    description: Create network
    created_at: "2024-02-01T10:16:51.955935138Z"
    created_by: ajego134p5h1********
    modified_at: "2024-02-01T10:16:53.389542083Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.vpc.v1.CreateNetworkMetadata
      network_id: enpgl5o8te3k********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  Чтобы получить список операций, воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для облачной сети воспользуйтесь методом REST API [listOperations](../api-ref/Network/listOperations.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/ListOperations](../api-ref/grpc/network_service.md#ListOperations).

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
      id: enp75021agjg********
      description: Create network
      created_at: "2024-02-01T10:16:51.955Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T10:16:53.389Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.vpc.v1.CreateNetworkMetadata
        network_id: enpgl5o8te3k********
      response:
        '@type': type.googleapis.com/yandex.cloud.vpc.v1.Network
        id: enpgl5o8te3kke6q3psa
        folder_id: b1gmit33ngp3********
        created_at: "2024-02-01T10:16:51Z"
        name: test-network
        default_security_group_id: enp0catll8gm********
        ```

    - API {#api}

      Воспользуйтесь методом REST API [get](../api-ref/Operation/get.md) для ресурса [Operation](../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
