---
title: Configuring object version locks in a bucket in {{ objstorage-full-name }}
description: Follow this guide to configure an object version lock in a bucket in {{ objstorage-name }}.
---

# Configuring an object lock

If [versioning](../buckets/versioning.md) and [object version locks](../buckets/configure-object-lock.md) are enabled in the bucket, you can configure locking for a version already uploaded to the bucket.

## Put or configure a retention (governance- or compliance-mode) {#edit-retention}

Minimum required roles:

* `storage.uploader`: To set lock.
* `storage.admin`: To change an existing lock.

You can only extend a compliance-mode retention. You cannot shrink it or replace with a governance-mode retention.

To put or configure a retention:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket for whose objects you want to configure a lock.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To see all versions of objects in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. In the list of objects, select the one you need, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_object-lock }}**.
  1. In the window that opens, enable **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**.
  1. Select **{{ ui-key.yacloud.storage.bucket.object-lock.field_mode }}**:
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-governance }}**: User with the `storage.admin` role can bypass a lock, change its expiration date, or remove it.
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}**: User with the `storage.admin` role can only extend the lock period. You cannot bypass, shorten, or remove such a lock until it expires.
  1. Specify **{{ ui-key.yacloud.storage.bucket.object-lock.field_retention-period }}** in days or years. It starts from the moment you upload the object version to the bucket.
  1. Click **{{ ui-key.yacloud.common.save }}**.

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

       * `RetainUntilDate`: Lock end date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2025-01-01T00:00:00`. The lock end time value is specified in the [UTC±00:00](https://en.wikipedia.org/wiki/UTC%2B00:00) time zone. To use a different time zone, add `+` or `-` and a UTC±00:00 offset to the end of the record. For more information, see [this example](#example-lock). If a version object is already locked in compliance mode, you can only extend it by setting new retain until date and time that are later than the current ones.

     * `--bypass-governance-retention`: Flag that shows that a lock is bypassed. Select it if an object version is already locked in governance mode.

- API {#api}

  Use the [putObjectRetention](../../s3/api-ref/object/putobjectretention.md) S3 API method.

{% endlist %}

## Removing a governance-mode retention {#remove-governance-retention}

The minimum required role is `storage.admin`.

To remove a retention:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To see all versions of objects in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. In the list of objects, select the one you need, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_object-lock }}**.
  1. In the window that opens, disable **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

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

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To see all versions of objects in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. In the list of objects, select the one you need, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_object-lock }}**.
  1. In the window that opens, enable or disable **{{ ui-key.yacloud.storage.field_perm-object-lock-enabled }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

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