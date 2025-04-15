---
title: Получение списка объектов в бакете в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить список объектов в бакете в {{ objstorage-name }}.
---

# Получение списка объектов в бакете

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**. Отобразится список объектов и папок.

      Чтобы посмотреть список объектов в папке, нажмите на нее.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка объектов в бакете:

      ```bash
      yc storage s3api list-objects --help
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
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Выполните команду:

      ```bash
      yc storage s3api list-objects \
        --bucket <имя_бакета> \
        --prefix <префикс_ключа_объекта>
      ```

      Где:

      * `--bucket` — имя бакета.
      * `--prefix` — [папка](../../concepts/object.md#folder) в бакете. Необязательный параметр.

      Результат:

      ```text
      contents:
        - key: my-folder/
          last_modified: "2025-04-05T09:21:30.870Z"
          etag: '"d41d8cd98f00b204e9800998********"'
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        - key: my-folder/clouds.jpg
          last_modified: "2025-04-05T09:22:00.542Z"
          etag: '"e48cfc54e831ee0b334a00f9********"'
          size: "455747"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        - key: my-folder/nice_text.txt
          last_modified: "2025-04-05T09:21:40.023Z"
          etag: '"379e8ff6a0f89b09534753e3********"'
          size: "64154"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
      name: first-bucket
      prefix: my-folder/
      max_keys: "1000"
      key_count: "3"
      request_id: dc073b86********
      ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Чтобы получить список объектов в бакете, выполните команду:

      ```bash
      aws s3api list-objects \
        --endpoint-url=https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --prefix <префикс_ключа_объекта>
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `--bucket` — имя бакета.
      * `--prefix` — [папка](../../concepts/object.md#folder) в бакете. Необязательный параметр.

      Результат:

      ```json
      {
          "Contents": [
              {
                  "Key": "my-folder/",
                  "LastModified": "2025-04-05T09:21:30.870000+00:00",
                  "ETag": "\"d41d8cd98f00b204e9800998********\"",
                  "Size": 0,
                  "StorageClass": "STANDARD",
                  "Owner": {
                      "DisplayName": "aje9k8luj4qf********",
                      "ID": "aje9k8luj4qf********"
                  }
              },
              {
                  "Key": "my-folder/clouds.jpg",
                  "LastModified": "2025-04-05T09:22:00.542000+00:00",
                  "ETag": "\"e48cfc54e831ee0b334a00f9********\"",
                  "Size": 455747,
                  "StorageClass": "STANDARD",
                  "Owner": {
                      "DisplayName": "aje9k8luj4qf********",
                      "ID": "aje9k8luj4qf********"
                  }
              },
              {
                  "Key": "my-folder/nice_text.txt",
                  "LastModified": "2025-04-05T09:21:40.023000+00:00",
                  "ETag": "\"379e8ff6a0f89b09534753e3********\"",
                  "Size": 64154,
                  "StorageClass": "STANDARD",
                  "Owner": {
                      "DisplayName": "aje9k8luj4qf********",
                      "ID": "aje9k8luj4qf********"
                  }
              },
          ],
          "RequestCharged": null
      }
      ```

- API {#api}

  Чтобы получить список объектов в бакете, воспользуйтесь методом S3 API [listObjects](../../s3/api-ref/bucket/listobjects.md).

{% endlist %}