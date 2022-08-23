# Logging actions with the bucket

To track operations with the [bucket](../../concepts/bucket.md), enable [logging](../../concepts/server-logs.md). Detailed information about requests to the _source_ bucket will be saved in an [object](../../concepts/object.md) in the _target_ bucket. However, {{ objstorage-name }} [doesn't guarantee](../../concepts/server-logs.md) that the logs are saved in a complete and timely manner.

Logging is disabled by default. After you enable it, {{ objstorage-name }} will save information about actions with the bucket once an hour.

## Enable logging {#enable}

To log requests to the bucket:

1. Use an existing target bucket or create a new target bucket named `bucket-logs`, for example. This is the bucket your logs will be written to.

   {% cut "How to create a bucket" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

1. Enable logging in the source bucket that you want to track.

   {% list tabs %}

   - {{ TF }}

      {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

      {% if audience != "internal" %}

      If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

      {% endif %}

      To enable logging for a bucket that you wish to monitor:

      1. Open the {{ TF }} configuration file and add a section called `logging` to the fragment describing the bucket.

         ```hcl
         resource "yandex_storage_bucket" "log_bucket" {
           access_key = "<static_key_ID>"
           secret_key = "<private_key>"
           bucket     = "my-tf-log-bucket"
         }

         resource "yandex_storage_bucket" "b" {
           access_key = "<static_key_ID>"
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
         * `access_key`: The ID of the static access key.
         * `secret_key`: The value of the secret access key.
         * `target_bucket`: Target bucket.
         * `target_prefix`: Key prefix for objects with logs.

         For more information about `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_bucket#enable-logging).

      1. Make sure that the configuration files are correct.

         1. In the command line, go to the directory where you created the configuration file.
         1. Run the check using the command:

            ```
            terraform plan
            ```

         If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

      1. Deploy the cloud resources.

         1. If the configuration doesn't contain any errors, run the command:

            ```
            terraform apply
            ```

         1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

            Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

   - API

      Send the request using the method [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md).

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
      * `<TargetPrefix>`: Prefix to use with all [keys](../../concepts/object.md#key) of objects with logs. Must end with `/`, such as, `logs/`. Optional.

   {% endlist %}

## Get the logging settings {#get-settings}

To get the name of the target bucket and the prefix of the key for the log object, follow these steps:

{% list tabs %}

- API

   Send the request using the method [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md).

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
   1. Click **Download**.

{% endlist %}

## Disable logging {#stop-logging}

To disable logging, follow these steps:

{% list tabs %}

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% if audience != "internal" %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% endif %}

   To disable the logging mechanism:

   1. Open the {{ TF }} configuration file and delete the `logging` section from the fragment describing the bucket.

      {% cut "Example bucket description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "log_bucket" {
        access_key = "FCAJEJj8ZjyMLr3ZNuNEn7jmO"
        secret_key = "FTR_JbXncjTugRfqsWiiW7c7qnldb5ZEdxbpZkma"
        bucket     = "my-tf-log-bucket"
      }

      resource "yandex_storage_bucket" "b" {
        access_key = "YCAJEJh8ZjyMLr3ZNuCOn7hrO"
        secret_key = "YCM_JbXncjTugRfqsWiiW7c7wcbgb5ZEdxbpZkcf"
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

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

- API

   Send the request using the method [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md). In the request body, pass the `<BucketLoggingStatus>` parameter with an empty value.

   Example of the HTTP request body:

   ```xml
   <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
   ```

{% endlist %}
