# Configuring bucket object locks

## Enabling an object lock {#enable}

{% list tabs %}

- AWS CLI

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api put-object-lock-configuration \
     --bucket <bucket_name> \
     --object-lock-configuration ObjectLockEnabled=Enabled
   ```

{% endlist %}

## Setting up default object locks {#default}

{% list tabs %}

- AWS CLI

   1. Specify a configuration for default object locks in JSON format:

      ```json
      {
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