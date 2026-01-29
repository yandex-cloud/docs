{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Enter a name for the bucket according to the [naming requirements](../../../storage/concepts/bucket.md#naming).
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Create a bucket by entering its name following the [naming requirements](../../../storage/concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
        s3 mb s3://<bucket_name>
      ```

      Result:

      ```text
      make_bucket: backup-bucket
      ```

- API {#api}

  Use the [create](../../../storage/api-ref/Bucket/create) REST API method for the [Bucket](../../../storage/api-ref/Bucket/) resource, the [BucketService/Create](../../../storage/api-ref/grpc/Bucket/create) gRPC API call, or the [create](../../../storage/s3/api-ref/bucket/create) S3 API method.

{% endlist %}