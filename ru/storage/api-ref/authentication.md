---
title: "Аутентификация в API {{ objstorage-full-name }}"
description: "Для выполнения операций через API в масштабируемом хранилище данных — {{ objstorage-full-name }} — необходимо получить IAM-токен для своего аккаунта."
---

# Аутентификация в API {{ objstorage-name }}

Вы можете работать с {{ objstorage-name }} с помощью следующих типов API:

* [AWS S3 API](#aws-s3-api);
* [{{ yandex-cloud }} gRPC и REST API](#yandex-api).

## AWS S3 API {#aws-s3-api}

Для аутентификации в [AWS S3 API](../s3/api-ref/) и работы с {{ TF }} и другими [поддерживаемыми инструментами](../tools/) используйте [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Статический ключ доступа выпускается на сервисный аккаунт, и все действия с использованием этого ключа выполняются от имени этого сервисного аккаунта. Подробнее см. [Как пользоваться S3 API](../../storage/s3/).

{% include [store-aws-key-in-lockbox](../../_includes/storage/store-aws-key-in-lockbox.md) %}

Полный перечень методов S3 API см. в [Справочнике S3 API](../s3/api-ref/).

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## {{ yandex-cloud }} gRPC и REST API {#yandex-api}


Для аутентификации в {{ yandex-cloud }} gRPC и REST API получите [IAM-токен](../../iam/concepts/authorization/iam-token.md). Подробнее о получении IAM-токена для разных типов аккаунтов:

* [Аккаунт на Яндексе](../../iam/operations/iam-token/create.md).
* [Федеративный аккаунт](../../iam/operations/iam-token/create-for-federation.md).
* [Сервисный аккаунт](../../iam/operations/iam-token/create-for-sa.md).

{% include [iam-token-usage](../../_includes/iam-token-usage.md) %}


Полный перечень вызовов и методов {{ yandex-cloud }} API смотрите в справочниках [gRPC API](../api-ref/grpc/) и [REST API](../api-ref/).


### Пример использования {{ yandex-cloud }} API {#example}

В примере создается бакет со стандартным классом хранилища и размером 50 ГБ.

{% list tabs %}

- gRPC

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{
      "name": "<имя_бакета>", 
      "folder_id": "<идентификатор_каталога>", 
      "default_storage_class": "STANDARD", 
      "max_size": "53687091200", 
      "anonymous_access_flags": [{
        "read": false, 
        "list": false, 
        "configRead": false
      }]
    }' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Create
  ```

  Где:

  * `IAM_TOKEN` — IAM-токен.
  * `name` — имя бакета.
  * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога.
  * `default_storage_class` — [класс](../../storage/concepts/storage-class.md) хранилища.
  * `max_size` — размер бакета.
  * `anonymous_access_flags` — настройки [доступа](../..//storage/concepts/bucket.md#bucket-access) к бакету:
    * `read` — публичный доступ на чтение объектов.
    * `list` — публичный доступ к списку объектов.
    * `configRead` — публичный доступ на чтение настроек.

  Результат:
  
  ```text  
  {
    "id": "e3ehmmasama1********",
    "description": "create bucket",
    "createdAt": "2023-08-10T06:32:19.836842Z",
    "createdBy": "ajego134p5h1********",
    "modifiedAt": "2023-08-10T06:32:19.836842Z",
    "done": true,
    "metadata": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.CreateBucketMetadata","name":"<имя_бакета>"},
    "response": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.Bucket","acl":{},"anonymousAccessFlags":{"read":false,"list":false},"createdAt":"2023-08-10T06:32:17.557756Z","defaultStorageClass":"STANDARD","folderId":"b1gmit33ngp3********","maxSize":"53687091200","name":"<имя_бакета>","versioning":"VERSIONING_DISABLED"}
  }
  ```

- REST

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{
      "name": "<имя_бакета>",
      "folderId": "<идентификатор_каталога>",
      "defaultStorageClass": "STANDARD",
      "maxSize": "53687091200",
      "anonymousAccessFlags": {
        "read": false,
        "list": false,
        "configRead": false
      }
    }' \
    https://storage.{{ api-host }}/storage/v1/buckets
  ```

  Где:

  * `IAM_TOKEN` — IAM-токен.
  * `name` — имя бакета.
  * `folderId` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога.
  * `default_storage_class` — [класс](../../storage/concepts/storage-class.md) хранилища.
  * `maxSize` — размер бакета.
  * `anonymousAccessFlags` — настройки [доступа](../..//storage/concepts/bucket.md#bucket-access) к бакету:
    * `read` — публичный доступ на чтение объектов. 
    * `list` — публичный доступ к списку объектов.
    * `configRead` — публичный доступ на чтение настроек.

  Результат:

  ```text
  {
  "done": true,
  "metadata": {
    "@type": "type.googleapis.com/{{ at-event-prefix }}.storage.v1.CreateBucketMetadata",
    "name": "<имя_бакета>"
  },
  "response": {
    "@type": "type.googleapis.com/{{ at-event-prefix }}.storage.v1.Bucket",
    "anonymousAccessFlags": {
    "read": false,
    "list": false
    },
    "acl": {},
    "name": "<имя_бакета>",
    "folderId": "b1gmit33ngp3********",
    "defaultStorageClass": "STANDARD",
    "versioning": "VERSIONING_DISABLED",
    "maxSize": "53687091200",
    "createdAt": "2023-08-08T12:54:29.321021Z"
  },
  "id": "e3enrkcct2pt********",
  "description": "create bucket",
  "createdAt": "2023-08-08T12:54:32.111022Z",
  "createdBy": "ajego134p5h1********",
  "modifiedAt": "2023-08-08T12:54:32.111022Z"
  }
  ```

{% endlist %}
