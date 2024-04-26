# Посмотреть операции с секретом

Все действия с ресурсами сервиса {{ lockbox-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. В меню слева выберите **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
    1. Нажмите на имя нужного секрета.
    1. На панели слева выберите раздел ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для секрета, воспользуйтесь командой:

  ```bash
  yc lockbox secret list-operations <имя_или_идентификатор_секрета>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+---------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION  |
  +----------------------+---------------------+----------------------+---------------------+--------+---------------+
  | e6qj8hr2mfoj******** | 2024-03-27 02:47:03 | aje9k8luj4qf******** | 2024-03-27 02:47:03 | DONE   | Update secret |
  | e6q4145hccpl******** | 2024-03-27 02:46:40 | aje9k8luj4qf******** | 2024-03-27 02:46:40 | DONE   | Update secret |
  +----------------------+---------------------+----------------------+---------------------+--------+---------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc lockbox secret list-operations <имя_или_идентификатор_секрета> --format yaml
  ```

  Результат:

  ```yaml
  - id: e6qj8hr2mfoj********
    description: Update secret
    created_at: "2024-03-27T02:47:03.482004186Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-27T02:47:03.482036369Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.lockbox.v1.UpdateSecretMetadata
      secret_id: e6qnva6ntl66********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  - id: e6q4145hccpl********
    description: Update secret
    created_at: "2024-03-27T02:46:40.035110019Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-27T02:46:40.035138179Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.lockbox.v1.UpdateSecretMetadata
      secret_id: e6qnva6ntl66********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../api-ref/Secret/listOperations.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/ListOperations](../api-ref/grpc/secret_service.md#ListOperations).

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
      id: e6qj8hr2mfoj********
      description: Update secret
      created_at: "2024-03-27T02:47:03.482Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-03-27T02:47:03.482Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.lockbox.v1.UpdateSecretMetadata
        secret_id: e6qnva6ntl66********
      response:
        '@type': type.googleapis.com/yandex.cloud.lockbox.v1.Secret
        id: e6qnva6ntl66********
        folder_id: b1g681qpemb4********
        created_at: "2024-03-27T02:45:05.184Z"
        name: top-secret
        labels:
          key2: value2
        status: ACTIVE
        current_version:
          id: e6qo5a6imnm0********
          secret_id: e6qnva6ntl66********
          created_at: "2024-03-27T02:45:05.184Z"
          status: ACTIVE
          payload_entry_keys:
            - key
        deletion_protection: true
      ```

    - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
