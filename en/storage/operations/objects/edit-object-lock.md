---
title: Configuring object locks in a bucket in {{ objstorage-full-name }}
description: Follow this guide to configure an object version lock in a bucket in {{ objstorage-name }}.
---

# Configuring an object lock

With [versioning](../buckets/versioning.md) and [object lock](../buckets/configure-object-lock.md) enabled in your bucket, you can configure an object lock for a version already uploaded to the bucket.

## Setting or configuring retention (governance- or compliance-mode) {#edit-retention}

The minimum required roles are as follows:

* `storage.uploader`: To set an object lock.
* `storage.admin`: To change an existing lock.

In compliance mode, you can only extend the retention period. You cannot shorten the retention period or change the retention mode to governance.

To set or configure an object lock:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket containing the objects you want to configure a lock for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To show all object versions in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. In the list of objects, select the one you need, click ![image](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.storage.file.button_object-lock }}**.
  1. In the window that opens, enable **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**.
  1. Select **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_mode_61kxf }}**:
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-governance }}**: User with the `storage.admin` role can bypass a lock, change its expiration date, or remove it.
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}**: User with the `storage.admin` role can only extend the retention period. Such locks cannot be bypassed, shortened, or removed until they expire.
  1. Specify **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_retention-period_jJYhy }}** in days or years. It starts from the moment the object version is uploaded to the bucket.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for configuring retention for an object version:

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

  1. Set up retention for an object version:

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

## Removing governance-mode retention {#remove-governance-retention}

The minimum required role is `storage.admin`.

To remove retention:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To show all object versions in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. In the list of objects, select the one you need, click ![image](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.storage.file.button_object-lock }}**.
  1. In the window that opens, disable **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for configuring retention for an object version:

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

  1. Set up retention for an object version:

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

  Use the [putObjectRetention](../../s3/api-ref/object/putobjectretention.md) S3 API method with the `X-Amz-Bypass-Governance-Retention: true` header and empty `Retention` element.

{% endlist %}


## Setting or removing legal hold {#edit-legal-hold}

The minimum required role is `storage.uploader`.

To set or remove legal hold:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To show all object versions in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. In the list of objects, select the one you need, click ![image](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.storage.file.button_object-lock }}**.
  1. In the window that opens, enable or disable **{{ ui-key.yacloud.storage.field_perm-object-lock-enabled }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for setting up legal hold for an object version:

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

  1. Set up legal hold for an object version:

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

  1. Make sure the object lock settings were applied:

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

### Setting governance-mode retention with Moscow time offset (UTC+3) {#example-lock}

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