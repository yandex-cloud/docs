---
title: Managing bucket labels in {{ objstorage-full-name }}
description: Follow this guide to manage bucket labels in {{ objstorage-name }}.
---

# Managing bucket labels

A [bucket label](../../concepts/tags.md) is a key-value pair used for logical bucket labeling.

{% include [labels-tags](../../../_includes/storage/labels-tags.md) %}

## Adding or updating labels {#add-edit-tag}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket where you need to add or edit labels.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}** tab.
  1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Enter a label in `key: value` format. To update an existing label, enter its key and a new value.
  1. Press **Enter**.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [tags-update-notice](../../../_includes/storage/tags-update-notice.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating bucket settings:

       ```bash
       yc storage bucket update --help
       ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Add labels, specifying the name of the bucket in question:

      ```bash
      yc storage bucket update <bucket_name> \
        --tags <label_1_key>=<label_1_value>,<label_2_key>=<label_2_value>,...,<label_n_key>=<label_n_value>
      ```

      Where `--tags` is a parameter to list bucket labels in `key=value` format.

      Result:

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

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  In the terminal, run this command:

  ```bash
  aws s3api put-bucket-tagging \
    --bucket <bucket_name> \
    --tagging 'TagSet=[{Key=<label_key>,Value=<label_value>},{Key=<label_key>,Value=<label_value>}]' \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Where:
  * `--bucket`: Bucket name.
  * `--tagging`: Array of bucket labels, where:
    * `Key`: Label key, the `string` type.
    * `Value`: Label value, the `string` type.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }} {#tf}

  {% include [tags-update-notice](../../../_includes/storage/tags-update-notice.md) %}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `tags` section to the bucket description:

      ```hcl
      resource "yandex_storage_bucket" "test-bucket" {
        bucket           = "<bucket_name>"
        ...
        tags             = {
          <label_1_key> = "<label_1_value>"
          <label_2_key> = "<label_2_value>"
        }
        ...
      }
      ```

      Where `tags` is the array of bucket labels in `<key> = "<value>"` format.

      For more information about the `yandex_storage_bucket` resource in Terraform, see [this TF provider article]({{ tf-provider-resources-link }}/storage_bucket).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will add the specified labels to your bucket. You can check the new labels and the bucket settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc storage bucket get <bucket_name> --full
  ```

- API {#api}

  {% include [tags-update-notice](../../../_includes/storage/tags-update-notice.md) %}

  To add or update bucket labels, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [putBucketTagging](../../s3/api-ref/bucket/putbuckettagging.md) S3 API method.

  **Example of a gRPC API call**

  ```bash
  export IAM_TOKEN="<IAM_token>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": [{"key": "test-key", "value": "test-value"}]}' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Update 
  ```

  Where:
  * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
  * `name`: Bucket name.
  * `update_mask`: List of bucket parameters you want to update.
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

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}** tab.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting bucket information:

      ```bash
      yc storage bucket get --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
       +------------------+----------------------+----------+-----------------------+---------------------+
       |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
       +------------------+----------------------+----------+-----------------------+---------------------+
       | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
       +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Get information about the labels, specifying the name of the bucket in question:

      ```bash
      yc storage bucket get <bucket_name> --full
      ```

      Result:

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

- API {#api}

  To view bucket labels, use the [get](../../api-ref/Bucket/get.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Get](../../api-ref/grpc/Bucket/get.md) gRPC API call, or the [getBucketTagging](../../s3/api-ref/bucket/getbuckettagging.md) S3 API method.

  **Example of a gRPC API call**

  ```bash
  export IAM_TOKEN="<IAM_token>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "view": "VIEW_FULL"}' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Get 
  ```

  Where:
  * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
  * `name`: Bucket name.
  * `view`: Scope of information provided (`VIEW_FULL` means full information about the bucket).
 
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

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}** tab.
  1. Click ![image](../../../_assets/console-icons/xmark.svg) next to the label.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating bucket settings:

      ```bash
      yc storage bucket update --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Delete labels, specifying the name of the bucket in question:

      ```bash
      yc storage bucket update <bucket_name> \
        --remove-tags
      ```

      Result:

      ```text
      name: my-bucket
      folder_id: b1gmit33ngp3********
      default_storage_class: STANDARD
      versioning: VERSIONING_ENABLED
      acl: {}
      created_at: "2023-04-24T14:15:28.240705Z"
      ```

- AWS CLI {#aws-cli}

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

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the `tags` section from the bucket description.

     {% cut "Example of a bucket label description in {{ TF }} configuration" %}

      ```hcl
      resource "yandex_storage_bucket" "test-bucket" {
        bucket           = "<bucket_name>"
        ...
        tags             = {
          <label_1_key> = "<label_1_value>"
          <label_2_key> = "<label_2_value>"
        }
        ...
      }
      ```

     {% endcut %}

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will delete the bucket labels. You can check the label deletion and the bucket settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc storage bucket get <bucket_name> --full
  ```

- API {#api}

  To delete bucket labels, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [deleteBucketTagging](../../s3/api-ref/bucket/deletebuckettagging.md) S3 API method.

  **Example of a gRPC API call**

  ```bash
  export IAM_TOKEN="<IAM_token>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": []}' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Update
  ```

  Where:
  * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
  * `name`: Bucket name.
  * `update_mask`: List of bucket parameters you want to update.
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
