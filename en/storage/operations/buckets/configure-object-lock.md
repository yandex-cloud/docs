# Managing object locks in buckets

You can set up _[object locks](../../concepts/object-lock.md)_ in [versioned](versioning.md) buckets. When object lock is enabled, you can lock an object version so that it would not be deleted or overwritten. You can also set default object locks for a bucket that will apply to all new object versions.

{% note info %}

In buckets with paused versioning, object locks are not available.

{% endnote %}

## Enabling an object lock {#enable}

Enabling locks does not mean locking previously uploaded object versions. If required, you can lock them manually.

The minimum required role is `storage.admin`.

To enable object locks:

{% list tabs group=instructions %}

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  Run the following command:

  ```bash
  aws s3api put-object-lock-configuration \
    --bucket <bucket_name> \
    --object-lock-configuration ObjectLockEnabled=Enabled \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Where:

  * `--bucket`: Bucket name.
  * `--object-lock-configuration`: Bucket lock settings. The `ObjectLockEnabled=Enabled` value enables object lock.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `object_lock_configuration` section to the bucket description:

      ```hcl
      resource "yandex_storage_bucket" "b" {
        ...
        object_lock_configuration {
          object_lock_enabled = "Enabled"
        }
      }
      ```

      Where:

      * `object_lock_configuration`: Object lock settings:
        * `object_lock_enabled`: Enables object locks. Requires enabled bucket versioning. This is an optional parameter.

      For more information about the bucket parameters you can specify using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_bucket).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  With that done, an object lock for the bucket will be created in the specified folder. You can check that the object lock is there using this [CLI](../../../cli/quickstart.md) command:

    ```bash
    yc storage bucket get <bucket_name>
    ```

    Result:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld*********
    ...
    object_lock:
      status: OBJECT_LOCK_STATUS_ENABLED
    ```

- API {#api}

  Use the [putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md) S3 API method, [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}

## Setting up default object locks {#default}

Default locks are set for all new object versions uploaded to the bucket. These settings do not affect the previously uploaded versions.

The minimum required role is `storage.admin`.

To set up default object locks:

{% list tabs group=instructions %}

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  1. Specify a configuration for default object locks in JSON format:
 
     ```json
     {
       "ObjectLockEnabled": "Enabled",
       "Rule": {
         "DefaultRetention": {
           "Mode": "<lock_type>",
           "Days": <retention_period_in_days>,
           "Years": <retention_period_in_years>
         }
       }
     }
     ```

     Where:

     * `ObjectLockEnabled`: Object lock status, `Enabled`, which means it is on.

       {% note alert %}

       This is a required field. If you do not specify `Enabled` in this parameter, you will get the `InvalidRequest` error message, and the object lock will not be enabled. See also [Disabling object locks](#disable) for details.

       {% endnote %}

     * `Mode`: Lock [type](../../concepts/object-lock.md#types):

       * `GOVERNANCE`: Temporary managed lock.
       * `COMPLIANCE`: Temporary strict lock.

     * `Days`: Retention period in days after uploading an object version. It must be a positive integer. You cannot use it together with `Years`.
     * `Years`: Retention period in years after uploading an object version. It must be a positive integer. You cannot use it together with `Days`.

     When ready, you can save your configuration into a file, e.g., `default-object-lock.json`.

  1. Upload the configuration to the bucket:

     ```bash
     aws s3api put-object-lock-configuration \
       --bucket <bucket_name> \
       --object-lock-configuration file://default-object-lock.json \
       --endpoint-url=https://{{ s3-storage-host }}
     ```

     Where:

     * `--bucket`: Bucket name.
     * `--object-lock-configuration`: Default lock settings. In our case, they are specified in the `default-object-lock.json` file.
     * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the default lock settings to the `object_lock_configuration` section:

      ```
      ...
      rule {
        default_retention {
          mode = "GOVERNANCE"
          years = 1
        }
      }
      ...
      ```

      Where:

      * `rule`: Object lock rule. It contains the `default_retention` parameter with retention settings:
        * `mode`: Lock type. Its possible values are `GOVERNANCE` or `COMPLIANCE`. This is an optional parameter.
        * `years` or `days`: Object lock duration (retention period). It is specified as a number. This is an optional parameter.

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check that the object lock is there using this [CLI](../../../cli/quickstart.md) command:

    ```bash
    yc storage bucket get <bucket_name>
    ```

    Result:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld********
    ...
    object_lock:
    status: OBJECT_LOCK_STATUS_ENABLED
    default_retention:
      mode: MODE_GOVERNANCE
      years: "1"
    ```

{% endlist %}

## Disabling object locks {#disable}

If you disable the object lock feature, this will not disable existing locks. They will still be there, and you will not be able to remove or change them.

The minimum required role is `storage.admin`.

To disable object locks:

{% list tabs group=instructions %}

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  Run the following command:

  ```bash
  aws s3api put-object-lock-configuration \
    --bucket <bucket_name> \
    --object-lock-configuration ObjectLockEnabled="" \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Where:

  * `--bucket`: Bucket name.
  * `--object-lock-configuration`: Bucket lock settings. The `ObjectLockEnabled=""` value disables object lock.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the `object_lock_configuration` section.

      {% cut "Example of an object lock description in a {{ TF }} configuration" %}

        ```
        ...
        object_lock_configuration {
          object_lock_enabled = "Enabled"
          rule {
            default_retention {
              mode = "GOVERNANCE"
              years = 1
            }
          }
        }
        ...
        ```

      {% endcut %}

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the object lock deletion using this [CLI](../../../cli/quickstart.md) command:

    ```bash
    yc storage bucket get <bucket_name>
    ```

    Result:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld********
    ...
    object_lock:
      status: OBJECT_LOCK_STATUS_DISABLED
    ```

- API {#api}

  To disable object lock for a bucket, use the[putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md) S3 API method, [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

  In the request body, send the object lock parameter with an empty value:

  * `ObjectLockConfiguration`: For S3 API.
  * `objectLock`: For REST API.
  * `object_lock`: For gRPC API.

  Example of the HTTP request body for S3 API:

  ```xml
  <ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/" />
  ```

{% endlist %}
