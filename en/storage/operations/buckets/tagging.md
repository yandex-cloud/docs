# Bucket label management

A [bucket label](../../concepts/tags.md) is a key-value pair used for logical bucket labeling.

{% include [labels-tags](../../../_includes/storage/labels-tags.md) %}

## Adding or updating labels {#add-edit-tag}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the [bucket](../../concepts/bucket.md) is located.
  1. Select **{{ objstorage-name }}**.
  1. Select a bucket from the list.
  1. Click the **{{ ui-key.yacloud.storage.bucket.switch_settings }}** tab in the left-hand menu.
  1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Enter a label in `key: value` format. To edit an existing label, enter its key and a new value.
  1. Click **Enter**.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- AWS CLI

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command that overwrites any existing bucket labels:

   ```bash
   aws s3api put-bucket-tagging \
     --bucket <bucket_name> \
     --tagging 'TagSet=[{Key=<label_key>,Value=<label_value>},{Key=<label_key>,Value=<label_value>}]' \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Bucket name.
   * `--tagging`: Array of bucket labels, where:
      * `Key`: Label key of the `string` type.
      * `Value`: Label value of the `string` type.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }}

  If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Open the {{ TF }} configuration file and add a section called `tags` to the fragment describing the bucket:

      ```hcl
      resource "yandex_storage_bucket" "test-bucket" {
        bucket           = "<bucket_name>"
        ...
        tags             = {
          <key_of_label_1> = "<value_of_label_1>"
          <key_of_label_2> = "<value_of_label_2>"
        }
        ...
      }
      ```

      Where `tags` is an array of bucket labels in `<key> = "<value>"` format.

      For more information about the `yandex_storage_bucket` resource parameters in Terraform, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  That will add the labels to the bucket. You can check the new labels and the bucket's configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc storage bucket get <bucket_name> --full
  ```

- API

   To add or update bucket labels, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [putBucketTagging](../../s3/api-ref/bucket/putbuckettagging.md) S3 API method.

   **Sample gRPC API call**

   ```bash
   export IAM_TOKEN="<IAM token>"
   grpcurl \
     -H "Authorization: Bearer $IAM_TOKEN" \
     -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": [{"key": "test-key", "value": "test-value"}]}' \
     storage.{{ api-host }}:443 \
     {{ at-event-prefix }}.storage.v1.BucketService/Update
   ```

   Where:
   * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `name`: Bucket name.
   * `update_mask`: List of bucket parameters to update.
   * `tags`: List of bucket labels.
   * `key`: Label key.
   * `value`: Label value.

   Result:

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

## Viewing labels {#get-tag}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the [bucket](../../concepts/bucket.md) is located.
  1. Select **{{ objstorage-name }}**.
  1. Select a bucket from the list.
  1. Click the **{{ ui-key.yacloud.storage.bucket.switch_settings }}** tab in the left-hand menu.

- AWS CLI

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command:

   ```bash
   aws s3api get-bucket-tagging \
     --bucket <bucket_name> \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Bucket name.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

   Result:

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

- API

   To view bucket labels, use the [get](../../api-ref/Bucket/get.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Get](../../api-ref/grpc/bucket_service.md#Get) gRPC API call, or the [getBucketTagging](../../s3/api-ref/bucket/getbuckettagging.md) S3 API method.

   **Sample gRPC API call**

   ```bash
   export IAM_TOKEN="<IAM token>"
   grpcurl \
     -H "Authorization: Bearer $IAM_TOKEN" \
     -d '{"name": "test-bucket", "view": "VIEW_FULL"}' \
     storage.{{ api-host }}:443 \
     {{ at-event-prefix }}.storage.v1.BucketService/Get
   ```

   Where:
   * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `name`: Bucket name.
   * `view`: Amount of information being provided (`VIEW_FULL` means full information about the bucket).

   Result:

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

## Deleting labels {#delete-tag}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the [bucket](../../concepts/bucket.md) is located.
  1. Select **{{ objstorage-name }}**.
  1. Select a bucket from the list.
  1. Click the **{{ ui-key.yacloud.storage.bucket.switch_settings }}** tab in the left-hand menu.
  1. Click ![image](../../../_assets/cross.svg) next to the appropriate label.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- AWS CLI

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command:

   ```bash
   aws s3api delete-bucket-tagging \
     --bucket <bucket_name> \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Bucket name.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }}

  If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Open the {{ TF }} configuration file and delete the `tags` section from the fragment describing the bucket.

     {% cut "Example of a bucket tag description in {{ TF }} configuration" %}

     ```hcl
     resource "yandex_storage_bucket" "test-bucket" {
       bucket           = "<bucket_name>"
       ...
       tags             = {
         <key_of_label_1> = "<value_of_label_1>"
         <key_of_label_2> = "<value_of_label_2>"
       }
       ...
     }
     ```

     {% endcut %}

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  That will delete the bucket's labels. You can check the deletion of labels and the bucket's configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc storage bucket get <bucket_name> --full
  ```

- API

   To delete bucket labels, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [deleteBucketTagging](../../s3/api-ref/bucket/deletebuckettagging.md) S3 API method.

   **Sample gRPC API call**

   ```bash
   export IAM_TOKEN="<IAM token>"
   grpcurl \
     -H "Authorization: Bearer $IAM_TOKEN" \
     -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": []}' \
     storage.{{ api-host }}:443 \
     {{ at-event-prefix }}.storage.v1.BucketService/Update
   ```

   Where:
   * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `name`: Bucket name.
   * `update_mask`: List of bucket parameters to update.
   * `tags`: List of bucket labels.

   Result:

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
