# Configuring an object lock

If [versioning](../buckets/versioning.md) and [object version locks](../buckets/configure-object-lock.md) are enabled in the bucket, you can configure locking for a version already uploaded to the bucket.

## Put or configure a retention (governance- or compliance-mode) {#edit-retention}

Minimum required roles:

* `storage.uploader`: To set lock.
* `storage.admin`: To change an existing lock.

You can only extend a compliance-mode retention. You cannot shrink it or replace with a governance-mode retention.

To put or configure a retention:

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-retention \
       --bucket <bucket_name> \
       --key <object_key> \
       --version-id <version_ID> \
       --retention Mode=<lock_type>,RetainUntilDate="<date_and_time>" \
       --bypass-governance-retention
     ```

     Where:

     * `--bucket`: Name of your bucket.
     * `--key`: Object [key](../../concepts/object.md#key).
     * `--version-id`: Object version ID.
     * `--retention`: Temporary lock settings (both parameters are required):

       * `Mode`: Lock [type](../../concepts/object-lock.md#types):

         * `GOVERNANCE`: Temporary managed lock. You cannot set this type if an object version is already locked in compliance mode.
         * `COMPLIANCE`: Temporary strict lock.

       * `RetainUntilDate`: Lock end date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. For example: `2025-01-01T00:00:00`. The lock end time value is specified in the [UTC±00:00](https://en.wikipedia.org/wiki/UTC%2B00:00) time zone. To use a different time zone, add `+` or `-` and a UTC±00:00 offset to the end of the record. For more information, see [this example](#example-lock). If a version object is already locked in compliance mode, you can only extend it by setting new retain until date and time that are later than the current ones.

     * `--bypass-governance-retention`: Flag that shows that a lock is bypassed. Select it if an object version is already locked in governance mode.

- API {#api}

  Use the [putObjectRetention](../../s3/api-ref/object/putobjectretention.md) S3 API method.

{% endlist %}

## Removing a governance-mode retention {#remove-governance-retention}

The minimum required role is `storage.admin`.

To remove a retention:

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-retention \
       --bucket <bucket_name> \
       --key <object_key> \
       --version-id <version_ID> \
       --retention '{}' \
       --bypass-governance-retention
     ```

     Where:

     * `--bucket`: Name of your bucket.
     * `--key`: Object [key](../../concepts/object.md#key).
     * `--version-id`: Object version ID.
     * `--retention`: Temporary lock settings. In both parameters, empty lines are specified to remove a lock.
     * `--bypass-governance-retention`: Flag that shows that a lock is bypassed.

- API {#api}

  Use the [putObjectRetention](../../s3/api-ref/object/putobjectretention.md) S3 API method with the `X-Amz-Bypass-Governance-Retention: true` header and an empty `Retention` element.

{% endlist %}


## Putting or removing legal holds {#edit-legal-hold}

The minimum required role is `storage.uploader`.

To put or configure a legal hold:

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  1. Run this command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-legal-hold \
       --bucket <bucket_name> \
       --key <object_key> \
       --version-id <version_ID> \
       --legal-hold Status=<lock_status>
     ```

     Where:

     * `--bucket`: Name of your bucket.
     * `--key`: Object [key](../../concepts/object.md#key).
     * `--version-id`: Object version ID.
     * `--legal-hold`: Indefinite lock settings:

       * `Status`: Lock status:

         * `ON`: Enabled.
         * `OFF`: Disabled.

- API {#api}

  Use the [putObjectLegalHold](../../s3/api-ref/object/putobjectlegalhold.md) S3 API method.

{% endlist %}

## Examples {#examples}

### Setting up a governance-mode retention with the Moscow time offset (UTC+3) {#example-lock}

> ```bash
> aws --endpoint-url=https://{{ s3-storage-host }}/ \
>   s3api put-object-retention \
>   --bucket test-bucket \
>   --key object-key/ \
>   --version-id 0005FA15******** \
>   --retention Mode=GOVERNANCE,RetainUntilDate="2025-01-01T00:00:00+03:00" \
> ```