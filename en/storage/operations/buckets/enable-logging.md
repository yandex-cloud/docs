# Logging actions with the bucket

To track operations with the [bucket](../../concepts/bucket.md), enable [logging](../../concepts/server-logs.md). Detailed information about requests to the _source_ bucket will be saved in an [object](../../concepts/object.md) in the _target_ bucket. However, {{ objstorage-name }} [does not guarantee](../../concepts/server-logs.md) that the logs are saved in a complete and timely manner.

By default, logging is disabled. After you enable it, {{ objstorage-name }} will save information about actions with the bucket once an hour.

## Enable logging {#enable}

To log requests to the bucket:

1. Use an existing target bucket or create a new one. This is the bucket your logs will be written to.

   {% cut "How to create a bucket" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

   {% include [target-backet-note](../../../_includes/storage/target-bucket-note.md) %}

1. Enable logging in the source bucket that you want to track.

   {% list tabs group=instructions %}

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
         * `TargetPrefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`.

      1. Enable logging in the bucket:

         ```bash
         aws s3api put-bucket-logging \
           --bucket <source_bucket_name> \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket-logging-status file://<path_to_settings_file>
         ```

         Where:

         * `--bucket`: Name of the source bucket to enable action logging for.
         * `--bucket-logging-status`: Path to the logging settings file.

   - {{ TF }} {#tf}

      {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

      
      {% include [terraform-install](../../../_includes/terraform-install.md) %}


      To enable logging for a bucket that you wish to monitor:

      1. Open the {{ TF }} configuration file and add a section called `logging` to the fragment describing the bucket.

         ```hcl
         resource "yandex_storage_bucket" "log_bucket" {
           access_key = "<static_key_ID>"
           secret_key = "<private_key>"
           bucket     = "<name_of_bucket_to_store_logs>"
         }

         resource "yandex_storage_bucket" "bucket" {
           access_key = "<static_key_ID>"
           secret_key = "<private_key>"
           bucket     = "<source_bucket_name>"
           acl        = "private"

           logging {
             target_bucket = yandex_storage_bucket.log_bucket.id
             target_prefix = "log/"
           }
         }
         ```

         Where:
         * `access_key`: ID of the static access key.
         * `secret_key`: Value of the secret access key.
         * `target_bucket`: Reference to the bucket that will store logs.
         * `target_prefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`.

         For more information about `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket#enable-logging).



         {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

   - API {#api}

      To enable logging for your bucket, use the [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md) S3 API method.

      Example of the HTTP request body:

      ```xml
      <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
        <LoggingEnabled>
          <TargetBucket>target bucket name</TargetBucket>
          <TargetPrefix>key prefix</TargetPrefix>
        </LoggingEnabled>
      </BucketLoggingStatus>
      ```

      Where:

      * `TargetBucket`: Target bucket name.
      * `TargetPrefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`.

   {% endlist %}

## Get the logging settings {#get-settings}

To get the name of the target bucket and the prefix of the key for the log object, follow these steps:

{% list tabs group=instructions %}

- AWS CLI {#cli}

   To retrieve the logging settings via the [AWS CLI](../../tools/aws-cli.md):

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

- API {#api}

   Use the [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md) S3 API method.

   Example of the HTTP response body:

   ```xml
   HTTP/1.1 200
   <?xml version="1.0" encoding="UTF-8"?>
   <BucketLoggingStatus>
      <LoggingEnabled>
         <TargetBucket>target bucket name</TargetBucket>
         <TargetPrefix>logs/</TargetPrefix>
      </LoggingEnabled>
   </BucketLoggingStatus>
   ```

{% endlist %}

## Get the logs {#get-logs}

To get logs, download the object prefixed with `logs/` from the target bucket:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the target bucket with logs is located.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket with the logs.
   1. Click on the object name with the `logs/` prefix.
   1. Click **{{ ui-key.yacloud.storage.file.button_download }}**.

{% endlist %}

## Disable logging {#stop-logging}

To disable logging, follow these steps:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   
   {% include [terraform-install](../../../_includes/terraform-install.md) %}


   To disable the logging mechanism:

   1. Open the {{ TF }} configuration file and delete the `logging` section from the fragment describing the bucket.

      {% cut "Example bucket description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "log_bucket" {
        access_key = "<static_key_ID>"
        secret_key = "<private_key>"
        bucket     = "<name_of_bucket_to_store_logs>"
      }

      resource "yandex_storage_bucket" "bucket" {
        access_key = "<static_key_ID>"
        secret_key = "<private_key>"
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

   {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   You can check the changes in the [management console]({{ link-console-main }}).

- API {#api}

   Use the [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md) S3 API method. In the request body, send the `<BucketLoggingStatus>` parameter with an empty value.

   Example of the HTTP request body:

   ```xml
   <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
   ```

{% endlist %}
