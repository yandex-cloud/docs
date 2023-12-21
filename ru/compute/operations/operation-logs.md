# Получить список операций с ресурсами сервиса

Все действия с ресурсами сервиса {{ compute-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% note info %}

{{ compute-name }} хранит операции с ресурсами за прошедшие 2 недели.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы посмотреть операции со всеми ресурсами сервиса, на панели слева выберите ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.compute.switch_operations }}**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.
  
  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для виртуальной машины. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится виртуальная машина.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите на строку с нужной виртуальной машиной.
  1. Перейдите на панель ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.compute.switch_operations }}** для выбранной виртуальной машины.

     В открывшемся списке отображаются операции с выбранной виртуальной машиной и подключенными к ней ресурсами.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ compute-name }}, воспользуйтесь командой:

  ```bash
  yc compute <тип_ресурса> list-operations --id <идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для виртуальной машины:

  ```bash
  yc compute instance list-operations --id epdplu8jn7sr********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  | epd2ohv6ur6a******** | 2023-10-20 08:34:01 | ajeef73j5iq9******** | 2023-10-20 08:34:05 | DONE   | Update instance |
  | epd2lcg5na2r******** | 2023-10-20 08:32:28 | ajeef73j5iq9******** | 2023-10-20 08:32:55 | DONE   | Stop instance   |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc compute instance list-operations --id epdplu8jn7sr******** --format yaml
  ```

  Результат:

  ```yaml
  - id: epd2ohv6ur6a********
    description: Update instance
    created_at: "2023-10-20T08:34:01Z"
    created_by: ajeef73j5iq9********
    modified_at: "2023-10-20T08:34:05Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.compute.v1.UpdateInstanceMetadata
      instance_id: epdplu8jn7sr********
    response:
      '@type': type.googleapis.com/yandex.cloud.compute.v1.Instance
      id: epdplu8jn7sr********
      folder_id: b1g86q4m5vej********
      created_at: "2023-10-02T13:19:45Z"
      name: rewq
      zone_id: {{ region-id }}-b
      platform_id: standard-v3
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: STOPPED
      ...
  - id: epd2lcg5na2r********
    description: Stop instance
    created_at: "2023-10-20T08:32:28Z"
    created_by: ajeef73j5iq9********
    modified_at: "2023-10-20T08:32:55Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.compute.v1.StopInstanceMetadata
      instance_id: epdplu8jn7sr********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API

  Воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.
  
  Например, для виртуальной машины воспользуйтесь методом REST API [listOperations](../api-ref/Instance/listOperations.md) для ресурса [Instance](../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/ListOperations](../api-ref/grpc/instance_service.md#ListOperations).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

Чтобы получить подробную информацию об операции:

1. [Получите список операций](#get-operations) для ресурса.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

   {% list tabs %}

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Выполните команду:

     ```bash
     yc operation get <идентификатор_операции>
     ```

     Результат:

     ```yaml
     id: ef3ovrdqhhf9********
     description: Delete instance
     created_at: "2023-10-17T16:08:10Z"
     created_by: ajejisqqifen********
     modified_at: "2023-10-17T16:08:41Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.compute.v1.DeleteInstanceMetadata
       instance_id: ef3su74qmfp4********
     response:
       '@type': type.googleapis.com/google.protobuf.Empty
       value: {}
     ```

   - API

     Воспользуйтесь методом REST API [get](../api-ref/Operation/get.md) для ресурса [Operation](../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get).

   {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
