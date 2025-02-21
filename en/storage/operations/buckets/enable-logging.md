---
title: Managing bucket action logging in {{ objstorage-full-name }}
description: Follow this guide to manage bucket action logging in {{ objstorage-full-name }}.
---

# Managing bucket logging


To monitor [bucket](../../concepts/bucket.md) operations, enable [logging](../../concepts/server-logs.md).

Detailed information about requests to the _source_ bucket will be saved in an [object](../../concepts/object.md) in the _target_ bucket. The source and target buckets must be different.

{{ objstorage-name }} [does not guarantee](../../concepts/server-logs.md) complete and timely logging.

By default, logging is disabled. After you enable it, {{ objstorage-name }} will log info about bucket operations once an hour.

## Enabling logging {#enable}

To log bucket access:

1. Use an existing target bucket or create a new one. This bucket will store logs.

   {% cut "How to create a bucket" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

   {% include [target-bucket-note](../../../_includes/storage/target-bucket-note.md) %}

1. Enable logging for the source bucket you want to monitor.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure logging for.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Select the **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}** tab.
      1. Enable **{{ ui-key.yacloud.storage.server-logs.label_server-logs }}**.
      1. Select **{{ ui-key.yacloud.storage.server-logs.label_target-bucket }}**.
      1. In the **{{ ui-key.yacloud.storage.server-logs.label_prefix }}** field, specify the prefix for log storage.
      1. Click **{{ ui-key.yacloud.common.save }}**.

   - AWS CLI {#cli}

     To enable logging via the [AWS CLI](../../tools/aws-cli.md):

     1. Create a file with logging settings in JSON format. Here is an example:

         ```json
         {
            "LoggingEnabled": {
               "TargetBucket": "<target_bucket_name>",
               "TargetPrefix": "<key_prefix>"
            }
         }
         ```

         Where:

         * `TargetBucket`: Name of the target bucket for the logs.
         * `TargetPrefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for objects with logs, e.g., `logs/`.

     1. Enable logging in the bucket:

         ```bash
         aws s3api put-bucket-logging \
           --bucket <source_bucket_name> \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket-logging-status file://<path_to_configuration_file>
         ```

         Where:

         * `--bucket`: Name of the source bucket to enable logging for.
         * `--bucket-logging-status`: Path to the logging settings file.

   - {{ TF }} {#tf}

     {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

     {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

     
     {% include [terraform-install](../../../_includes/terraform-install.md) %}


     To enable logging for the bucket you want to monitor:

     1. Open the {{ TF }} configuration file and add the `logging` section to the bucket description.

        ```hcl
        resource "yandex_storage_bucket" "log_bucket" {
          access_key = "<static_key_ID>"
          secret_key = "<secret_key>"
          bucket     = "<name_of_bucket_for_storing_logs>"
        }

        resource "yandex_storage_bucket" "bucket" {
          access_key = "<static_key_ID>"
          secret_key = "<secret_key>"
          bucket     = "<source_bucket_name>"
          acl        = "private"

          logging {
            target_bucket = yandex_storage_bucket.log_bucket.id
            target_prefix = "log/"
          }
        }
        ```

        Where:
        * `access_key`: Static access key ID.
        * `secret_key`: Secret access key value.
        * `target_bucket`: Reference to the log storage bucket.
        * `target_prefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for objects with logs, e.g., `logs/`.

        For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/storage_bucket#enable-logging).

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

        This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

   - API {#api}

     To enable logging for a bucket, use the [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md) S3 API method.

     Here is an example of an HTTP request body:

     ```xml
     <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
       <LoggingEnabled>
         <TargetBucket>target_bucket_name</TargetBucket>
         <TargetPrefix>key_prefix</TargetPrefix>
       </LoggingEnabled>
     </BucketLoggingStatus>
     ```

     Where:

     * `TargetBucket`: Target bucket name.
     * `TargetPrefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for objects with logs, e.g., `logs/`.

   {% endlist %}

If you want to delete the target bucket, first [disable logging](#stop-logging) or select another target bucket for storing logs. You can only [delete](delete.md) an empty bucket.

## Getting logging settings {#get-settings}

To get the target bucket name and the log object key prefix, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the source bucket.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
   1. Select the **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}** tab.
   1. The **{{ ui-key.yacloud.storage.server-logs.label_target-bucket }}** list contains the name of the target bucket.
   1. The **{{ ui-key.yacloud.storage.server-logs.label_prefix }}** field contains the prefix used for log storage.

- AWS CLI {#cli}

   To get the logging settings via the [AWS CLI](../../tools/aws-cli.md):

   Run this command:

   ```bash
   aws s3api get-bucket-logging \
     --bucket <bucket_name> \
     --output json \
     --endpoint-url https://{{ s3-storage-host }}
   ```

   Result:

   ```json
   {
       "LoggingEnabled": {
         "TargetBucket": "<bucket_name>",
         "TargetPrefix": "<key_prefix>"
       }
   }
   ```

- {{ TF }} {#tf}

  To get the logging settings for the bucket you want to monitor:

     1. Open the {{ TF }} configuration file and find the `logging` section in the bucket description.

        ```hcl
        resource "yandex_storage_bucket" "log_bucket" {
          access_key = "<static_key_ID>"
          secret_key = "<secret_key>"
          bucket     = "<name_of_bucket_for_storing_logs>"
        }

        resource "yandex_storage_bucket" "bucket" {
          access_key = "<static_key_ID>"
          secret_key = "<secret_key>"
          bucket     = "<source_bucket_name>"
          acl        = "private"

          logging {
            target_bucket = yandex_storage_bucket.log_bucket.id
            target_prefix = "log/"
          }
        }
        ```

        Where:
        * `access_key`: Static access key ID.
        * `secret_key`: Secret access key value.
        * `target_bucket`: Reference to the log storage bucket.
        * `target_prefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for objects with logs, e.g., `logs/`.

        For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/storage_bucket#enable-logging).

- API {#api}

  Use the [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md) S3 API method.

  Here is an example of an HTTP response body:

  ```xml
  HTTP/1.1 200
  <?xml version="1.0" encoding="UTF-8"?>
  <BucketLoggingStatus>
     <LoggingEnabled>
        <TargetBucket>target_bucket_name</TargetBucket>
        <TargetPrefix>logs/</TargetPrefix>
     </LoggingEnabled>
  </BucketLoggingStatus>
  ```

{% endlist %}

## Getting logs {#get-logs}

To get logs, download the object prefixed with `logs/` from the target bucket:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services.
  1. Select the target bucket with logs.
  1. Go to the `logs/` directory.
  1. Next to the log object you want to download, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.storage.file.button_download }}**.

  {% note info %}

  You can also use [CyberDuck](../../tools/cyberduck.md) or [WinSCP](../../tools/winscp.md) to download objects using the GUI.

  {% endnote %}

- AWS CLI {#cli}

  To get logs using the [AWS CLI](../../tools/aws-cli.md), download the objects prefixed with `logs/` by following [this guide](../objects/download.md#cli).

- API {#api}

  Use the Object [get](../../s3/api-ref/object/get.md) S3 API method.

{% endlist %}

## Disabling logging {#stop-logging}

To disable logging, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to disable logging for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}** tab.
  1. Disable **{{ ui-key.yacloud.storage.server-logs.label_server-logs }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  To disable logging using the [AWS CLI](../../tools/aws-cli.md), use this command:

     ```bash
     aws s3api put-bucket-logging \
         --bucket <bucket_name> \
         --endpoint-url https://{{ s3-storage-host }} \
         --bucket-logging-status {}
     ```

     Where `--bucket` is the name of the source bucket to disable logging for.

- {{ TF }} {#tf}

  To disable logging:

  1. In the {{ TF }} configuration file, delete the `logging` section from the bucket description.

      {% cut "Example of a bucket description in {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "log_bucket" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "<name_of_bucket_for_storing_logs>"
      }

      resource "yandex_storage_bucket" "bucket" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "<source_bucket_name>"
        acl        = "private"

        logging {
          target_bucket = yandex_storage_bucket.log_bucket.id
          target_prefix = "log/"
        }
      }
      ...
      ```

      {% endcut %}

  1. Apply the configuration changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the update using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md) S3 API method. In the request body, provide the `<BucketLoggingStatus>` parameter with an empty value.

  Here is an example of an HTTP request body:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
  ```

{% endlist %}
