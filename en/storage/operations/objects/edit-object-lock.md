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
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}**: User with the `storage.admin` role can only extend the retention period. Such locks cannot be bypassed, shortened, or removed until they expire.
  1. Specify **{{ ui-key.yacloud.storage.bucket.object-lock.field_retention-period }}** in days or years. It starts from the moment the object version is uploaded to the bucket.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to set up a temporary lock for an object version:

      ```bash
      yc storage s3api put-object-retention --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Set up a temporary lock for an object version:

      ```bash
      yc storage s3api put-object-retention \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID> \
        --retention Mode=<lock_type>,RetainUntilDate="<retention_end_date>" \
        --bypass-governance-retention
      ```

      {% include [object-lock-retention-cli-legend](../../../_includes/storage/object-lock-retention-cli-legend.md) %}

      Result:

      ```bash
      request_id: c5984d03********
      ```

  1. {% include [get-object-retention-cli-command](../../../_includes/storage/get-object-retention-cli-command.md) %}

      Result:

      ```text
      request_id: 077b184e********
      retention:
        mode: GOVERNANCE
        retain_until_date: "2024-12-01T10:49:08.363Z"
      ```

      The `mode` field states the lock [type](../../concepts/object-lock.md#types), while the `retain_until_date` field states its end date.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-retention \
       --bucket <bucket_name> \
       --key <object_key> \
       --version-id <version_ID> \
       --retention Mode=<lock_type>,RetainUntilDate="<retention_end_date>" \
       --bypass-governance-retention
     ```

     {% include [object-lock-retention-cli-legend](../../../_includes/storage/object-lock-retention-cli-legend.md) %}

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

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to set up a temporary lock for an object version:

      ```bash
      yc storage s3api put-object-retention --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Set up a temporary lock for an object version:

      ```bash
      yc storage s3api put-object-retention \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID> \
        --retention "{}" \
        --bypass-governance-retention
      ```

      {% include [object-lock-retention-remove-cli-legend](../../../_includes/storage/object-lock-retention-remove-cli-legend.md) %}

      Result:

      ```bash
      request_id: m6384f81********
      ```

  1. {% include [get-object-retention-cli-command](../../../_includes/storage/get-object-retention-cli-command.md) %}

      Running this command will return an error saying there is no lock configured for the object:

      ```text
      The specified object does not have a ObjectLock configuration.
      ```

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-retention \
       --bucket <bucket_name> \
       --key <object_key> \
       --version-id <version_ID> \
       --retention "{}" \
       --bypass-governance-retention
     ```

     {% include [object-lock-retention-remove-cli-legend](../../../_includes/storage/object-lock-retention-remove-cli-legend.md) %}

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

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to set up an indefinite lock for an object version:

      ```bash
      yc storage s3api put-object-legal-hold --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Set up an indefinite lock for an object version:

      ```bash
      yc storage s3api put-object-legal-hold \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID> \
        --legal-hold Status=<lock_status>
      ```

      {% include [legal-hold-cli-legend](../../../_includes/storage/legal-hold-cli-legend.md) %}

      Result:

      ```bash
      request_id: cb262625********
      ```

  1. Make sure the object version lock settings were applied:

      ```bash
      yc storage s3api get-object-legal-hold \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID>
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object key.
      * `--version-id`: Object version ID.

      Result:

      ```text
      request_id: 0bef4a0b********
      legal_hold:
        status: ON
      ```

- AWS CLI {#aws-cli}

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

     {% include [legal-hold-cli-legend](../../../_includes/storage/legal-hold-cli-legend.md) %}

- API {#api}

  Use the [putObjectLegalHold](../../s3/api-ref/object/putobjectlegalhold.md) S3 API method.

{% endlist %}

## Examples {#examples}

### Setting up a governance-mode retention with the Moscow time offset (UTC+3) {#example-lock}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  > ```bash
  > yc storage s3api put-object-retention \
  >   --bucket test-bucket \
  >   --key object-key/ \
  >   --version-id 0005FA15******** \
  >   --retention Mode=GOVERNANCE,RetainUntilDate=2025-01-01T00:00:00+03:00 \
  > ```

- AWS CLI {#aws-cli}

  > ```bash
  > aws --endpoint-url=https://{{ s3-storage-host }}/ \
  >   s3api put-object-retention \
  >   --bucket test-bucket \
  >   --key object-key/ \
  >   --version-id 0005FA15******** \
  >   --retention Mode=GOVERNANCE,RetainUntilDate="2025-01-01T00:00:00+03:00" \
  > ```

{% endlist %}