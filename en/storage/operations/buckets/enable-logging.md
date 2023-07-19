# Logging actions with the bucket

To track operations with the [bucket](../../concepts/bucket.md), enable [logging](../../concepts/server-logs.md). Detailed information about requests to the _source_ bucket will be saved in an [object](../../concepts/object.md) in the _target_ bucket. However, {{ objstorage-name }} [does not guarantee](../../concepts/server-logs.md) that the logs are saved in a complete and timely manner.

By default, logging is disabled. After you enable it, {{ objstorage-name }} will save information about actions with the bucket once an hour.

## Enable logging {#enable}

To log requests to the bucket:

1. Use an existing target bucket or create a new target bucket named `bucket-logs`, for example. This is the bucket your logs will be written to.

   {% cut "How to create a bucket" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

1. Enable logging in the source bucket that you want to track.

   {% list tabs %}

   - AWS CLI

      To enable logging via the [AWS CLI](../../tools/aws-cli.md):

      1. Create a file with logging settings in JSON format, e.g.:

         ```json
         {
            "LoggingEnabled": {
               "TargetBucket": "<target_bucket_name>",
               "TargetPrefix": "<key_prefix>"
            }
         }
         ```

         Where:

         * `TargetBucket`: Name of the target bucket to write logs to.
         * `TargetPrefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`.

      1. Enable logging in the bucket:

         ```bash
         aws s3api put-bucket-logging \
           --bucket <source_bucket_name> \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket-logging-status file://<path_to_settings_file>
         ```

         Where:

         * `bucket`: Name of the source bucket to enable action logging for.
         * `bucket-logging-status`: Path to the logging settings file.

   - {{ TF }}

      {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

      
      If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


      To enable logging for a bucket that you wish to monitor:

      1. Open the {{ TF }} configuration file and add a section called `logging` to the fragment describing the bucket.

         ```hcl
         resource "yandex_storage_bucket" "log_bucket" {
           access_key = "<static_key_id>"
           secret_key = "<private_key>"
           bucket     = "my-tf-log-bucket"
         }

         resource "yandex_storage_bucket" "b" {
           access_key = "<static_key_id>"
           secret_key = "<private_key>"
           bucket     = "my-tf-test-bucket"
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
         * `target_bucket`: Target bucket.
         * `target_prefix`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`.

         For more information about `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_bucket#enable-logging).



      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

   - API

      To enable logging for your bucket, use the [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md) S3 API method.

      Example of the HTTP request body:

      ```xml
      <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
        <LoggingEnabled>
          <TargetBucket>bucket-logs</TargetBucket>
          <TargetPrefix>logs/</TargetPrefix>
        </LoggingEnabled>
      </BucketLoggingStatus>
      ```

      Where:

      * `<TargetBucket>`: Target bucket name.
      * `<TargetPrefix>`: [Prefix of the key](../../concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`. This is an optional parameter.

   {% endlist %}

## Get the logging settings {#get-settings}

To get the name of the target bucket and the prefix of the key for the log object, follow these steps:

{% list tabs %}

- AWS CLI

   To retrieve the logging settings via the [AWS CLI](../../tools/aws-cli.md):

   1. Run this command:

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

- API

   Use the [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md) S3 API method.

   Example of the HTTP response body:

   ```xml
   HTTP/1.1 200
   <?xml version="1.0" encoding="UTF-8"?>
   <BucketLoggingStatus>
      <LoggingEnabled>
         <TargetBucket>bucket-logs</TargetBucket>
         <TargetPrefix>logs/</TargetPrefix>
      </LoggingEnabled>
   </BucketLoggingStatus>
   ```

{% endlist %}

## Get the logs {#get-logs}

To get your logs, download the object with the `logs/` prefix from the `bucket-logs` bucket:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the `bucket-logs` bucket is located.
   1. Select **{{ objstorage-name }}**.
   1. Click on the `bucket-logs` bucket name.
   1. Click on the object name with the `logs/` prefix.
   1. Click **{{ ui-key.yacloud.storage.file.button_download }}**.

{% endlist %}

## Disable logging {#stop-logging}

To disable logging, follow these steps:

{% list tabs %}

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To disable the logging mechanism:

   1. Open the {{ TF }} configuration file and delete the `logging` section from the fragment describing the bucket.

      {% cut "Example bucket description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "log_bucket" {
        access_key = "<static_key_id>"
        secret_key = "<private_key>"
        bucket     = "my-tf-log-bucket"
      }

      resource "yandex_storage_bucket" "b" {
        access_key = "<static_key_id>"
        secret_key = "<private_key>"
        bucket     = "my-tf-test-bucket"
        acl        = "private"

        logging {
          target_bucket = yandex_storage_bucket.log_bucket.id
          target_prefix = "log/"
        }
      }
      ...
      ```

      {% endcut %}

   {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   You can verify the changes in the [management console]({{ link-console-main }}).

- API

   Use the [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md) S3 API method. In the request body, send the `<BucketLoggingStatus>` parameter with an empty value.

   Example of the HTTP request body:

   ```xml
   <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
   ```

{% endlist %}
