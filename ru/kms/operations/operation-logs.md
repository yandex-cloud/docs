# Посмотреть операции с ресурсами сервиса

Все действия с ресурсами сервиса {{ kms-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Ниже показано, как получить список операций для симметричного ключа. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится симметричный ключ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Выберите нужный ключ.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **Операции** для выбранного ключа.

     В открывшемся списке отображаются операции с выбранным симметричным ключом.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ kms-name }}, воспользуйтесь командой:

  ```bash
  yc kms <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для симметричного ключа:

  ```bash
  yc kms symmetric-key list-operations epdplu8jn7sr********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |     DESCRIPTION      |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  | abji19ucm6b1******** | 2024-03-26 10:33:12 | aje9k8luj4qf******** | 2024-03-26 10:33:12 | DONE   | update key           |
  | abjluv2sk1sp******** | 2024-03-26 10:19:52 | aje9k8luj4qf******** | 2024-03-26 10:19:52 | DONE   | create symmetric key |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc kms symmetric-key list-operations epdplu8jn7sr******** --format yaml
  ```

  Результат:

  ```yaml
  - id: abji19ucm6b1********
    description: update key
    created_at: "2024-03-26T10:33:12.360289758Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-26T10:33:12.360314054Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.kms.v1.UpdateSymmetricKeyMetadata
      key_id: abjip2tl1frh********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  - id: abjluv2sk1sp********
    description: create symmetric key
    created_at: "2024-03-26T10:19:52.794225911Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-26T10:19:52.794265993Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.kms.v1.CreateSymmetricKeyMetadata
      key_id: abjip2tl1frh********
      primary_version_id: abjg82vbog68********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.
  
  Например, для симметричного ключа воспользуйтесь методом REST API [listOperations](../api-ref/SymmetricKey/listOperations.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/ListOperations](../api-ref/grpc/symmetric_key_service.md#ListOperations).

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
      id: abji19ucm6b1********
      description: update key
      created_at: "2024-03-26T10:33:12.360Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-03-26T10:33:12.360Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.kms.v1.UpdateSymmetricKeyMetadata
        key_id: abjip2tl1frh********
      response:
        '@type': type.googleapis.com/yandex.cloud.kms.v1.SymmetricKey
        id: abjip2tl1frh********
        folder_id: b1g681qpemb4********
        created_at: "2024-03-26T10:19:52Z"
        name: sym-key
        status: ACTIVE
        primary_version:
          id: abjg82vbog68kv5jvj6s
          key_id: abjip2tl1frh********
          status: ACTIVE
          algorithm: AES_256
          created_at: "2024-03-26T10:19:52Z"
          primary: true
        default_algorithm: AES_192
      ```

   - API {#api}

     Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get).

   {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
