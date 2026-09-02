---
title: Получение информации о бакете и статистики бакета в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о бакете и статистику бакета в {{ objstorage-name }}.
---

# Получение информации о бакете и статистики бакета

## Получить информацию о бакете {#get-information}

Для просмотра полной информации о [бакете](../../concepts/bucket.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите нужный бакет из списка.
  1. На панели слева выберите нужный раздел с информацией о бакете:
     * ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** — список объектов, хранящихся в бакете.
     * ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** — основные параметры бакета, информация о хостинге сайта в бакете, версионировании, логировании, жизненном цикле объектов в бакете.
     * ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** — описание прав и политики доступа в бакете, сведения о конфигурации HTTPS и CORS, блокировке и шифровании объектов в бакете.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о бакете:

     ```bash
     yc storage bucket get --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Сохраните имя бакета (столбец `NAME`), информацию о котором вы хотите получить.

  1. Получите информацию о бакете:

     ```bash
     yc storage bucket get <имя_бакета> --full
     ```

     Результат:

     ```text
     name: first-bucket
     folder_id: b1gmit33ngp6********
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     default_storage_class: ICE
     versioning: VERSIONING_ENABLED
     max_size: "5368709120"
     acl:
       grants:
         - permission: PERMISSION_READ
           grant_type: GRANT_TYPE_ACCOUNT
           grantee_id: ajep03tkmqqr********
     created_at: "2023-04-10T19:41:30.266075Z"
     website_settings:
       index: index.html
       error: 404.html
       redirect_all_requests: {}
     ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Проверьте, что бакет существует и доступен вам:

      ```bash
      aws s3api head-bucket \
        --bucket <имя_бакета> \
        --endpoint-url=https://{{ s3-storage-host }}
      ```

      Где:

      * `--bucket` — имя бакета.
      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

      Если бакета нет или прав на него не хватает, команда завершится ошибкой. Перечень возможных ответов приведен в разделе [{#T}](../../s3/api-ref/response-codes.md).

  Отдельные настройки бакета возвращают методы S3 API — например, `get-bucket-versioning` для [версионирования](../../concepts/versioning.md) и `get-bucket-encryption` для [шифрования](../../concepts/encryption.md).

- API {#api}

  Чтобы получить информацию о [бакете](../../concepts/bucket.md), воспользуйтесь методом REST API [get](../../api-ref/Bucket/get.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Get](../../api-ref/grpc/Bucket/get.md) или методом S3 API [headBucket](../../s3/api-ref/bucket/getmeta.md).

  Объем возвращаемых данных задается параметром `view`:

  * `VIEW_BASIC` — основные сведения о бакете. В ответе не будет полей `acl`, `cors`, `websiteSettings`, `lifecycleRules` и `tags`.
  * `VIEW_ACL` — основные сведения и [ACL](../../concepts/acl.md) бакета.
  * `VIEW_FULL` — полные сведения о бакете.

  Доступ к каждому из значений определяется [ролями {{ iam-short-name }}](../../security/index.md), а также [ACL](../../concepts/acl.md) и [политикой доступа](../../concepts/policy.md) бакета.

  **Пример вызова REST API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  curl \
    --request GET \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --url 'https://storage.{{ api-host }}/storage/v1/buckets/<имя_бакета>?view=VIEW_FULL'
  ```

  Где `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).

{% endlist %}

## Получить статистику бакета {#get-statistics}

Для просмотра статистики по бакету:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите нужный бакет из списка.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. На открывшейся странице вы можете посмотреть статистику бакета за определенный период времени:
     
     {% include [storage-monitoring-dashboards](../../_includes_service/storage-monitoring-dashboards.md) %}


- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения статистики бакета:

     ```bash
     yc storage bucket stats --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Сохраните имя бакета (столбец `NAME`), статистику которого вы хотите получить.

  1. Получите статистику бакета:

     ```bash
     yc storage bucket stats <имя_бакета>
     ```

     Результат:

     ```text
     name: first-bucket
     max_size: "5368709120"
     used_size: "621552"
     storage_class_used_sizes:
       - storage_class: STANDARD
         class_size: "607467"
       - storage_class: COLD
         class_size: "14085"
     storage_class_counters:
       - storage_class: STANDARD
         counters:
           simple_object_size: "607467"
           simple_object_count: "41"
       - storage_class: COLD
         counters:
           simple_object_size: "14085"
           simple_object_count: "16"
     default_storage_class: ICE
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     created_at: "2023-04-10T19:41:30.266075Z"
     updated_at: "2023-08-02T04:05:44.564924Z"
     ```

- API {#api}

  Чтобы получить статистику бакета, воспользуйтесь методом REST API [getStats](../../api-ref/Bucket/getStats.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/GetStats](../../api-ref/grpc/Bucket/getStats.md).

  **Пример вызова REST API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  curl \
    --request GET \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --url 'https://storage.{{ api-host }}/storage/v1/buckets/<имя_бакета>:getStats'
  ```

  Где `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).

  В ответе возвращается общий занятый объем — поле `usedSize`, распределение объема по [классам хранилища](../../concepts/storage-class.md) — поле `storageClassUsedSizes`, и количество объектов в каждом классе — поле `storageClassCounters`.

{% endlist %}
