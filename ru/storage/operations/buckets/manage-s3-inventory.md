---
title: Управление выгрузкой метаданных объектов (S3 Inventory) в бакете
description: Из этой инструкции вы узнаете, как управлять выгрузкой метаданных объектов в бакете {{ objstorage-full-name }}.
---

# Управление выгрузкой метаданных объектов (S3 Inventory) в бакете

В {{ objstorage-name }} вы можете [выгрузить метаданные объектов](../../concepts/s3-inventory.md) (S3 Inventory) из бакетов для дальнейшего анализа и каталогизации.

{% include [s3-inventory-pricing](../../../_includes/storage/s3-inventory-pricing.md) %}

## Создать конфигурацию выгрузки {#create-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания конфигурации выгрузки:

      ```bash
      yc storage bucket create-inventory-configuration --help
      ```

  1. Создайте конфигурацию выгрузки:

      ```bash
      yc storage bucket create-inventory-configuration \
        --name <имя_бакета> \
        --configuration '{
          "id": "test_config",
          "is_enabled": true,
          "schedule": {
            "frequency": "DAILY"
          },
          "destination": {
            "bucket_destination": {
              "bucket": "<имя_целевого_бакета>",
              "format": "CSV",
              "prefix": "inventory"
            }
          },
          "filter": {
            "prefix": "for_inventory"
          },
          "included_object_versions": "ALL",
          "optional_fields": [
            "SIZE",
            "LAST_MODIFIED_DATE",
            "STORAGE_CLASS",
            "ETAG",
            "IS_MULTIPART_UPLOADED",
            "ENCRYPTION_STATUS",
            "OBJECT_LOCK_RETAIN_UNTIL_DATE",
            "OBJECT_LOCK_MODE",
            "OBJECT_LOCK_LEGAL_HOLD_STATUS",
            "CHECKSUM_ALGORITHM",
            "OBJECT_ACCESS_CONTROL_LIST",
            "OBJECT_OWNER"
          ]
        }'
      ```

      Где:

      * `--name` — имя бакета, метаданные объектов которого нужно выгрузить.
      * `--configuration` — параметры конфигурации выгрузки:      
        * `id` — идентификатор конфигурации. Обязательный параметр.
        * `is_enabled` — флаг включения или отключения конфигурации.
        * `frequency` — периодичность выгрузки. Обязательный параметр. Возможные значения:
          * `DAILY` — раз в день;
          * `WEEKLY` — раз в неделю.
        * `destination` — информация о том, где и как публиковать результаты выгрузки:
          * `bucket` — имя бакета, в который будут выгружаться метаданные. Исходный и целевой бакеты должны находиться в одном [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud). Обязательный параметр.
          * `format` — формат результатов выгрузки. Поддерживается только `CSV`. Обязательный параметр.
          * `prefix` — папка (префикс), в которой будут генерироваться результаты выгрузки.
        * `included_object_versions` — [версии](../../concepts/versioning.md) объектов, которые нужно включить в список для выгрузки. Обязательный параметр. Возможные значения:
          * `ALL` — все версии;
          * `CURRENT` — текущая версия.
        * `filter` — фильтр для объектов, которые будут включены в выгрузку. В поле `prefix` укажите папку, объекты из которой нужно включить в список для выгрузки. Необязательный параметр.
        * `optional_fields` — массив типов выгружаемых метаданных:
          * `SIZE` — размер объекта в байтах;
          * `LAST_MODIFIED_DATE` — дата создания или последнего изменения объекта;
          * `STORAGE_CLASS` — [класс хранилища](../../concepts/storage-class.md);
          * `ETAG` — хэш объекта;
          * `IS_MULTIPART_UPLOADED` — указывает, был ли объект загружен в результате [составной загрузки](../../concepts/multipart.md);
          * `ENCRYPTION_STATUS` — статус [шифрования](../../concepts/encryption.md) объекта;
          * `OBJECT_LOCK_RETAIN_UNTIL_DATE` — дата окончания [блокировки версии](../../concepts/object-lock.md) объекта;
          * `OBJECT_LOCK_MODE` — тип блокировки версии объекта;
          * `OBJECT_LOCK_LEGAL_HOLD_STATUS` — статус бессрочной блокировки версии объекта;
          * `CHECKSUM_ALGORITHM` — алгоритм, используемый для расчета контрольной суммы объекта;
          * `OBJECT_ACCESS_CONTROL_LIST` — [список управления доступом](../../concepts/acl.md) (ACL) для объекта;
          * `OBJECT_OWNER` — владелец объекта.

      Вы также можете создать файл с конфигурацией в формате JSON и передать его в команде:

      ```bash
      yc storage bucket create-inventory-configuration \
        --name <имя_бакета> \
        --configuration "$(cat <путь_к_файлу>)"
      ```

      {% cut "Пример содержимого файла" %}

      ```json
      {
        "id": "test_config",
        "is_enabled": true,
        "schedule": {
          "frequency": "WEEKLY"
        },
        "destination": {
          "bucket_destination": {
            "bucket": "<имя_целевого_бакета>",
            "format": "CSV",
            "prefix": "inventory"
          }
        },
        "included_object_versions": "ALL",
        "optional_fields": [
          "SIZE",
          "LAST_MODIFIED_DATE",
          "STORAGE_CLASS",
          "ETAG",
          "IS_MULTIPART_UPLOADED",
          "ENCRYPTION_STATUS",
          "OBJECT_LOCK_RETAIN_UNTIL_DATE",
          "OBJECT_LOCK_MODE",
          "OBJECT_LOCK_LEGAL_HOLD_STATUS",
          "CHECKSUM_ALGORITHM",
          "OBJECT_ACCESS_CONTROL_LIST",
          "OBJECT_OWNER"
        ]
      }
      ```

      {% endcut %}

- API {#api}

  Чтобы создать конфигурацию выгрузки, воспользуйтесь методом REST API [createInventoryConfiguration](../../api-ref/Bucket/createInventoryConfiguration.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService.CreateInventoryConfiguration](../../api-ref/grpc/Bucket/createInventoryConfiguration.md).

{% endlist %}

## Скачать результаты выгрузки {#get-result}

Результаты будут представлены в нескольких файлах:

* Манифест:

  * `<префикс_выгрузки>/<имя_исходного_бакета>/<идентификатор_конфигурации>/<дата_выгрузки>/manifest.json` — манифест выгрузки;
  * `<префикс_выгрузки>/<имя_исходного_бакета>/<идентификатор_конфигурации>/<дата_выгрузки>/manifest.checksum` — контрольные суммы манифеста.

    Где:
    
    * `<префикс_выгрузки>` — префикс, по которому производилась выгрузка;
    * `<имя_исходного_бакета>` — имя бакета, из которого выгружаются метаданные;
    * `<идентификатор_конфигурации>` — идентификатор конфигурации выгрузки;
    * `<дата_выгрузки>` — дата выгрузки в формате `YYYY-MM-DDThh:mmZ`.

* Отчет: `<префикс_выгрузки>/<имя_исходного_бакета>/<идентификатор_конфигурации>/data/<имя_отчета>.csv`, где `<имя_отчета>` — [UUID](https://{{ lang }}.wikipedia.org/wiki/UUID) отчета.

  Для выгрузки метаданных из крупных бакетов отчет может быть разбит на несколько файлов.

Вы можете [скачать](../objects/download.md) результаты выгрузки аналогично другим объектам.

## Получить список конфигураций выгрузки {#list-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра списка конфигураций выгрузки:

      ```bash
      yc storage bucket list-inventory-configurations --help
      ```

  1. Получите список конфигураций выгрузки для бакета:

      ```bash
      yc storage bucket list-inventory-configurations <имя_бакета>
      ```

      Результат:

      ```text
      configurations:
        - id: test_config
          destination:
            bucket_destination:
              bucket: test-bucket
              format: CSV
              prefix: inventory
          included_object_versions: ALL
          is_enabled: true
          schedule:
            frequency: DAILY
          optional_fields:
            - SIZE
            - LAST_MODIFIED_DATE
            - STORAGE_CLASS
            - ETAG
            - IS_MULTIPART_UPLOADED
            - ENCRYPTION_STATUS
            - OBJECT_LOCK_RETAIN_UNTIL_DATE
            - OBJECT_LOCK_MODE
            - OBJECT_LOCK_LEGAL_HOLD_STATUS
            - CHECKSUM_ALGORITHM
            - OBJECT_ACCESS_CONTROL_LIST
            - OBJECT_OWNER
      ```

- API {#api}

  Чтобы посмотреть список конфигураций выгрузки, воспользуйтесь методом REST API [listInventoryConfigurations](../../api-ref/Bucket/listInventoryConfigurations.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService.ListInventoryConfigurations](../../api-ref/grpc/Bucket/listInventoryConfigurations.md).

{% endlist %}

## Получить информацию о конфигурации выгрузки {#get-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра конфигурации выгрузки:

      ```bash
      yc storage bucket get-inventory-configuration --help
      ```

  1. [Получите список](#list-inventory) конфигураций выгрузки для бакета и скопируйте значение поля `id` нужной конфигурации.

  1. Получите информацию о конфигурации выгрузки:

      ```bash
      yc storage bucket get-inventory-configuration <имя_бакета> --id <идентификатор_выгрузки>
      ```

      Результат:

      ```text
      id: test_config
      destination:
        bucket_destination:
          bucket: test-bucket
          format: CSV
          prefix: inventory
      included_object_versions: ALL
      is_enabled: true
      schedule:
        frequency: DAILY
      optional_fields:
        - SIZE
        - LAST_MODIFIED_DATE
        - STORAGE_CLASS
        - ETAG
        - IS_MULTIPART_UPLOADED
        - ENCRYPTION_STATUS
        - OBJECT_LOCK_RETAIN_UNTIL_DATE
        - OBJECT_LOCK_MODE
        - OBJECT_LOCK_LEGAL_HOLD_STATUS
        - CHECKSUM_ALGORITHM
        - OBJECT_ACCESS_CONTROL_LIST
        - OBJECT_OWNER
      ```

- API {#api}

  Чтобы получить информацию о конфигурации выгрузки, воспользуйтесь методом REST API [getInventoryConfiguration](../../api-ref/Bucket/getInventoryConfiguration.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService.GetInventoryConfiguration](../../api-ref/grpc/Bucket/getInventoryConfiguration.md).

{% endlist %}

## Удалить конфигурацию выгрузки {#delete-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления конфигурации выгрузки:

      ```bash
      yc storage bucket delete-inventory-configuration --help
      ```

  1. [Получите список](#list-inventory) конфигураций выгрузки для бакета и скопируйте значение поля `id` нужной конфигурации.

  1. Удалите конфигурацию выгрузки:

      ```bash
      yc storage bucket delete-inventory-configuration <имя_бакета> --id <идентификатор_выгрузки>
      ```

- API {#api}

  Чтобы удалить конфигурацию выгрузки, воспользуйтесь методом REST API [deleteInventoryConfiguration](../../api-ref/Bucket/deleteInventoryConfiguration.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService.DeleteInventoryConfiguration](../../api-ref/grpc/Bucket/deleteInventoryConfiguration.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/s3-inventory.md)
* [{#T}](../objects/download.md)
* [{#T}](./enable-logging.md)
