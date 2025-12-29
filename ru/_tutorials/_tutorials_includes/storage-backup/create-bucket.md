{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Укажите имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming).
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
        s3 mb s3://<имя_бакета>
      ```

      Результат:

      ```text
      make_bucket: backup-bucket
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../../storage/api-ref/Bucket/create) для ресурса [Bucket](../../../storage/api-ref/Bucket/), вызовом gRPC API [BucketService/Create](../../../storage/api-ref/grpc/Bucket/create) или методом S3 API [create](../../../storage/s3/api-ref/bucket/create).

{% endlist %}