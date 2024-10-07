---
title: Управление метками бакета в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете управлять метками бакета в {{ objstorage-name }}.
---

# Управление метками бакета

[Метки бакетов](../../concepts/tags.md) — это пары ключ-значение для логической маркировки бакетов.

{% include [labels-tags](../../../_includes/storage/labels-tags.md) %}

## Добавить или изменить метки {#add-edit-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, в котором нужно добавить или изменить меткаи.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Введите метку в формате `ключ: значение`. Чтобы изменить существующую метку, введите ее ключ и новое значение.
  1. Нажмите **Enter**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [tags-update-notice](../../../_includes/storage/tags-update-notice.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения настроек бакета:

       ```bash
       yc storage bucket update --help
       ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Добавьте метки, указав имя нужного бакета:

      ```bash
      yc storage bucket update <имя_бакета> \
        --tags <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n>
      ```

      Где `--tags` — флаг для перечисления меток бакета в формате `ключ=значение`.

      Результат:

      ```text
      name: my-bucket
      folder_id: b1gmit33ngp3********
      default_storage_class: STANDARD
      versioning: VERSIONING_ENABLED
      acl: {}
      created_at: "2023-04-24T14:15:28.240705Z"
      tags:
        - key: key-tag
          value: key-value
      ```

- AWS CLI {#aws-cli}

  {% include [tags-update-notice](../../../_includes/storage/tags-update-notice.md) %}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api put-bucket-tagging \
    --bucket <имя_бакета> \
    --tagging 'TagSet=[{Key=<ключ_метки>,Value=<значение_метки>},{Key=<ключ_метки>,Value=<значение_метки>}]' \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--tagging` — массив меток бакета, где:
    * `Key` — ключ метки, тип: `string`.
    * `Value` — значение метки, тип: `string`.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

- {{ TF }} {#tf}

  {% include [tags-update-notice](../../../_includes/storage/tags-update-notice.md) %}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `tags` во фрагмент с описанием бакета:

      ```hcl
      resource "yandex_storage_bucket" "test-bucket" {
        bucket           = "<имя_бакета>"
        ...
        tags             = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
        }
        ...
      }
      ```

      Где `tags` — массив меток бакета в формате `<ключ> = "<значение>"`.

      Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в Terraform, см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого к бакету будут добавлены метки. Проверить появление меток и настройки бакета можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc storage bucket get <имя_бакета> --full
  ```

- API {#api}

  {% include [tags-update-notice](../../../_includes/storage/tags-update-notice.md) %}

  Чтобы добавить или изменить метки бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) или методом S3 API [putBucketTagging](../../s3/api-ref/bucket/putbuckettagging.md).

  **Пример вызова gRPC API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": [{"key": "test-key", "value": "test-value"}]}' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Update 
  ```

  Где:
  * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
  * `name` — имя бакета.
  * `update_mask` — перечень параметров бакета, которые вы хотите изменить.
  * `tags` — перечень меток бакета.
  * `key` — ключ метки.
  * `value` — значение метки.

  Результат:

  ```json
  {
    "id": "e3e5fsr6076bo*******",
    "description": "update bucket",
    "createdAt": "2023-04-27T12:01:03.636597Z",
    "createdBy": "ajelcjkv67arb*******",
    "modifiedAt": "2023-04-27T12:01:03.636597Z",
    "done": true,
    "metadata": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.UpdateBucketMetadata","name":"test-bucket"},
    "response": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.Bucket","acl":{},"createdAt":"2023-03-27T08:23:26.890770Z","defaultStorageClass":"STANDARD","folderId":"b1gsm0k26v1l2*******","maxSize":"53687091200","name":"test-bucket","tags":[{"key":"test-key","value":"test-value"}],"versioning":"VERSIONING_DISABLED"}
  }
  ```

{% endlist %}

## Посмотреть метки {#get-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о бакете:

      ```bash
      yc storage bucket get --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
       +------------------+----------------------+----------+-----------------------+---------------------+
       |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
       +------------------+----------------------+----------+-----------------------+---------------------+
       | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
       +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Получите информацию о метках, указав имя нужного бакета:

      ```bash
      yc storage bucket get <имя_бакета> --full
      ```

      Результат:

      ```text
      name: my-bucket
      folder_id: b1gmit33ngp3********
      default_storage_class: STANDARD
      ...
      tags:
        - key: key-tag
          value: key-value
      ...
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api get-bucket-tagging \
    --bucket <имя_бакета> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

  Результат:

  ```json
  {
      "TagSet": [
          {
              "Key": "test-key-1",
              "Value": "test-value-1"
          },
          {
              "Key": "test-key-2",
              "Value": "test-value-2"
          }
      ]
  }
  ```  

- API {#api}

  Чтобы посмотреть метки бакета, воспользуйтесь методом REST API [get](../../api-ref/Bucket/get.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Get](../../api-ref/grpc/bucket_service.md#Get) или методом S3 API [getBucketTagging](../../s3/api-ref/bucket/getbuckettagging.md).

  **Пример вызова gRPC API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "view": "VIEW_FULL"}' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Get 
  ```

  Где:
  * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
  * `name` — имя бакета.
  * `view` — объем предоставляемой информации, `VIEW_FULL` — полная информация о бакете.
 
  Результат:

  ```json
  {
    "name": "test-bucket",
    "folderId": "b1gsm0k26v1l2*******",
    "anonymousAccessFlags": {
      "read": true,
      "list": true,
      "configRead": true
    },
    "defaultStorageClass": "STANDARD",
    "versioning": "VERSIONING_DISABLED",
    "maxSize": "53687091200",
    "acl": {

    },
    "createdAt": "2023-03-27T08:23:26.890770Z",
    "websiteSettings": {
      "redirectAllRequests": {

      }
    },
    "tags": [
      {
        "key": "test-key",
        "value": "test-value"
      }
    ]
  }
  ```

{% endlist %}

## Удалить метки {#delete-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}**.
  1. Напротив нужной метки нажмите значок ![image](../../../_assets/console-icons/xmark.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения настроек бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Удалите метки, указав имя нужного бакета:

      ```bash
      yc storage bucket update <имя_бакета> \
        --remove-tags
      ```

      Результат:

      ```text
      name: my-bucket
      folder_id: b1gmit33ngp3********
      default_storage_class: STANDARD
      versioning: VERSIONING_ENABLED
      acl: {}
      created_at: "2023-04-24T14:15:28.240705Z"
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api delete-bucket-tagging \
    --bucket <имя_бакета> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите блок `tags` из фрагмента с описанием бакета.

     {% cut "Пример описания тегов бакета в конфигурации {{ TF }}" %}

      ```hcl
      resource "yandex_storage_bucket" "test-bucket" {
        bucket           = "<имя_бакета>"
        ...
        tags             = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
        }
        ...
      }
      ```

     {% endcut %}

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого метки бакета будут удалены. Проверить удаление меток и настройки бакета можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc storage bucket get <имя_бакета> --full
  ```

- API {#api}

  Чтобы удалить метки бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) или методом S3 API [deleteBucketTagging](../../s3/api-ref/bucket/deletebuckettagging.md).

  **Пример вызова gRPC API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": []}' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Update 
  ```

  Где:
  * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
  * `name` — имя бакета.
  * `update_mask` — перечень параметров бакета, которые вы хотите изменить.
  * `tags` — перечень меток бакета.

  Результат:

  ```json
  {
    "id": "e3epc33apcche*******",
    "description": "update bucket",
    "createdAt": "2023-04-27T12:18:18.885391Z",
    "createdBy": "ajelcjkv67arb*******",
    "modifiedAt": "2023-04-27T12:18:18.885391Z",
    "done": true,
    "metadata": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.UpdateBucketMetadata","name":"test-bucket-777"},
    "response": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.Bucket","acl":{},"createdAt":"2023-03-27T08:23:26.890770Z","defaultStorageClass":"STANDARD","folderId":"b1gsm0k26v1l2*******","maxSize":"53687091200","name":"test-bucket-777","versioning":"VERSIONING_DISABLED"}
  }
  ```

{% endlist %}
