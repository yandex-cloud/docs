# Managing object lock in buckets

You can set up _[object lock](../../concepts/object-lock.md)_ in [versioned](versioning.md) buckets. When object lock is enabled, you can lock an object version so that it can't be deleted or overwritten. You can also set default object locks for a bucket: they will apply to all new object versions.

{% note info %}

To start using locks in your cloud, request this feature from [support](../../../support/overview.md#response-time).

{% endnote %}

## Enabling an object lock {#enable}

When you enable locks, previously uploaded object versions aren't locked (but you can lock them).

The minimum required role is `storage.admin`.

To enable object locks:

{% list tabs %}

- AWS CLI

   If you don't have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   Run the following command:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api put-object-lock-configuration \
     --bucket <bucket_name> \
     --object-lock-configuration ObjectLockEnabled=Enabled
   ```

   Where:

   * `bucket`: Bucket name.
   * `object-lock-configuration`: Lock configuration in the bucket:

      * `ObjectLockEnabled=Enabled`: Object lock is enabled.

- API

   Use the [putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md) method.

{% endlist %}


## Setting up default object locks {#default}

Default locks are set for all new object versions uploaded to the bucket. These settings don't affect previously uploaded versions.

The minimum required role is `storage.admin`.

To set up default object locks:

{% list tabs %}

- AWS CLI

   If you don't have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

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

         This is a required field. If you omit `Enabled` in this parameter, object locks will be disabled.

         {% endnote %}

      * `Mode` is the [type](../../concepts/object-lock.md#types) of object lock:

         * `GOVERNANCE`: An object lock with a predefined retention period that can be managed.
         * `COMPLIANCE`: An object lock with a predefined retention period with strict compliance.

      * `Days`: The retention period in days after uploading an object version. It must be a positive integer. You can't set it simultaneously with `Years`.
      * `Years`: The retention period in years after uploading an object version. It must be a positive integer. You can't set it simultaneously with `Days`.

      When you're done, you can save your configuration as a file, like `default-object-lock.json`.

   1. Upload the configuration to the bucket:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api put-object-lock-configuration \
        --bucket <bucket_name> \
        --object-lock-configuration file://default-object-lock.json
      ```

      Where:

      * `bucket`: Bucket name.
      * `object-lock-configuration`: Default object lock configuration. In this case, specified in the `default-object-lock.json` file.

{% endlist %}

## Disabling object locks {#disable}

If you disable object locks, this doesn't disable the locks put previously. Such locks are still in effect, and you can't remove or change them.

The minimum required role is `storage.admin`.

To disable object locks:

{% list tabs %}

- AWS CLI

   If you don't have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   Run the following command:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api put-object-lock-configuration \
     --bucket <bucket_name> \
     --object-lock-configuration ""
   ```

   Where:

   * `bucket`: Bucket name.
   * `object-lock-configuration`: Lock configuration in the bucket. An empty value disables object locks.

{% endlist %}
