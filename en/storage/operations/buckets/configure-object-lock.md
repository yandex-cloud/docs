# Managing object locks in buckets

You can set up _[object locks](../../concepts/object-lock.md)_ in [versioned](versioning.md) buckets. When object lock is enabled, you can lock an object version so that it would not be deleted or overwritten. You can also set default object locks for a bucket that will apply to all new object versions.

{% note info %}

In buckets with paused versioning, object lock is not available.

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
   * `--object-lock-configuration`: Lock configuration in the bucket. The `ObjectLockEnabled=Enabled` value enables object lock.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- API {#api}

   Use the [putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md) S3 API method, [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, or the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call.

{% endlist %}


## Setting up default object locks {#default}

Default locks are set for all new object versions uploaded to the bucket. These settings don't affect previously uploaded versions.

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
            "Days": <lock_period_in_days>,
            "Years": <lock_period_in_years>
          }       
        }
      }
      ```

      Where:

      * `ObjectLockEnabled` Object lock status: `Enabled`: Object lock is enabled.

         {% note alert %}

         This is a required field. If you omit `Enabled` in this parameter, you'll see the `InvalidRequest` error message, and object lock will not be enabled. See also [Disabling object locks](#disable).

         {% endnote %}

      * `Mode` is the [type](../../concepts/object-lock.md#types) of object lock:

         * `GOVERNANCE`: Object lock with a predefined retention period that can be managed.
         * `COMPLIANCE`: Object lock with a predefined retention period with strict compliance.

      * `Days`: The retention period in days after uploading an object version. It must be a positive integer. You can't set it simultaneously with `Years`.
      * `Years`: The retention period in years after uploading an object version. It must be a positive integer. You can't set it simultaneously with `Days`.

      When you're done, you can save your configuration as a file, like `default-object-lock.json`.

   1. Upload the configuration to the bucket:

      ```bash
      aws s3api put-object-lock-configuration \
        --bucket <bucket_name> \
        --object-lock-configuration file://default-object-lock.json \
        --endpoint-url=https://{{ s3-storage-host }}
      ```

      Where:

      * `--bucket`: Bucket name.
      * `--object-lock-configuration`: Default object lock configuration. In this case, specified in the `default-object-lock.json` file.
      * `--endpoint-url`: {{ objstorage-name }} endpoint.

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
   * `--object-lock-configuration`: Lock configuration in the bucket. The `ObjectLockEnabled=""` value disables object lock.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- API {#api}

   To disable object lock for a bucket, use the[putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md) S3 API method, [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, or the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call.

   In the request body, send the object lock parameter with an empty value:

   * `ObjectLockConfiguration`: For S3 API.
   * `objectLock`: For REST API.
   * `object_lock`: For gRPC API.

   Example of the HTTP request body for S3 API:

   ```xml
   <ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/" />
   ```

{% endlist %}
