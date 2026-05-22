---
title: Получение списка бакетов в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить список бакетов в {{ objstorage-name }}.
---

# Получение списка бакетов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  
  На открывшейся странице отобразится полный список [бакетов](../../concepts/bucket.md).

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка [бакетов](../../concepts/bucket.md):

     ```bash
     yc storage bucket --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Чтобы получить список [бакетов](../../concepts/bucket.md), выполните команду:

      ```bash
      aws s3api list-buckets \
        --endpoint-url=https://{{ s3-storage-host }}
      ```

      Где `--endpoint-url` — эндпоинт {{ objstorage-name }}.

      Результат:

      ```json
      {
          "Buckets": [
              {
                  "Name": "storage-********",
                  "CreationDate": "2026-04-30T09:48:38.836000+00:00"
              },
              {
                  "Name": "storage-********",
                  "CreationDate": "2026-04-30T09:48:45.365000+00:00"
              }
          ],
          "Owner": {
              "DisplayName": "",
              "ID": ""
          },
          "Prefix": null
      }
      ```

- API {#api}

  Чтобы получить список [бакетов](../../concepts/bucket.md), воспользуйтесь методом REST API [list](../../api-ref/Bucket/list.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/List](../../api-ref/grpc/Bucket/list.md) или методом S3 API [listBuckets](../../s3/api-ref/bucket/list.md).

{% endlist %}
