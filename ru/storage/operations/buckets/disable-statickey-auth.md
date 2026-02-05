---
title: Запретить доступ в бакет {{ objstorage-full-name }} с помощью статических ключей
description: Следуя данной инструкции, вы сможете запретить доступ к бакету {{ objstorage-name }} с помощью статических ключей доступа.
---

# Запретить доступ в бакет с помощью статических ключей

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

По умолчанию доступ к [бакету](../../concepts/bucket.md) можно получить с помощью [статических ключей доступа](../../../iam/concepts/authorization/access-key.md). Вы можете отключить такой способ доступа и оставить только доступ с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) или анонимно (если опция включена в настройках бакета).

{% note info %}

После запрета, доступ с помощью статических ключей будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Также прекратится доступ с помощью [эфемерных ключей](../../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../../security/sts.md) и [подписанных (pre-signed) URL](../../security/overview.md#pre-signed).

{% endnote %}

Минимально необходимая роль для запрета доступа с помощью статических ключей — `storage.admin`. См. [описание роли](../../security/index.md#storage-admin).

Чтобы запретить доступ в бакет с помощью статических ключей:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 10737418240 | STANDARD              | 2025-11-20 09:45:36 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Сохраните имя бакета (столбец `NAME`), в котором нужно запретить доступ с помощью статических ключей.
  1. Запретите доступ в бакет с помощью статических ключей:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --disable-statickey-auth true
      ```

      Где:
      * `--name` — имя бакета, в котором нужно запретить доступ с помощью статических ключей.
      * `--disable-statickey-auth` — флаг для запрета доступа с помощью статических ключей. Принимает значение `true` или `false`.

      Результат:

      ```text
      name: first-bucket
      folder_id: b1gmit33ngp6********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z"
      disabled_statickey_auth: true
      ```

- API {#api}

  Чтобы запретить доступ в бакет с помощью статических ключей, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md).

  Выполните запрос:

  ```bash
  curl -X PATCH \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
         "updateMask":"disabledStatickeyAuth",
         "disabledStatickeyAuth":true
        }' \
  "https://storage.api.cloud.yandex.net/storage/v1/buckets/first-bucket"
  ```

  Где:
  * `<имя_бакета>` — имя бакета, в котором нужно запретить доступ с помощью статических ключей.
  * `<IAM-токен>` — IAM-токен пользователя с ролью `storage.admin` на бакет.

  Результат:

  ```json
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.storage.v1.UpdateBucketMetadata",
      "name": "first-bucket"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.storage.v1.Bucket",
      "acl": {},
      "disabledStatickeyAuth": true,
      "name": "first-bucket",
      "folderId": "b1g07hj5r6i4********",
      "defaultStorageClass": "STANDARD",
      "versioning": "VERSIONING_DISABLED",
      "maxSize": "53687091200",
      "createdAt": "2025-11-20T09:45:36.230463Z",
      "resourceId": "e3eruofcbqc2********"
    },
    "id": "e3enqoaug76p********",
    "description": "update bucket",
    "createdAt": "2025-12-22T20:47:01.424654Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-22T20:47:01.424654Z"
  }
  ```

  Отслеживайте статус операции по полю `done`.

{% endlist %}