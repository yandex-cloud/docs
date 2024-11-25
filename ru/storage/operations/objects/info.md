---
title: Получение информации об объекте в бакете в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию об объекте в бакете в {{ objstorage-name }}.
---

# Получение информации об объекте

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Нажмите на имя нужного объекта.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об объекте:

      ```bash
      yc storage s3api head-object --help
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
      yc storage s3api head-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта>
      ```

      Где:

      * `--bucket` — имя вашего бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта.

      Результат:

      ```bash
      etag: '"d41d8cd98f00b204e9800998********"'
      request_id: 6428ce25********
      accept_ranges: bytes
      content_type: application/octet-stream
      last_modified_at: "2024-10-08T12:36:36Z"
      server_side_encryption: aws:kms
      sse_kms_key_id: abj497vtg3h0********
      ```
  
- API {#api}

  Чтобы получить информацию об объекте, воспользуйтесь методом S3 API [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md).

{% endlist %}
