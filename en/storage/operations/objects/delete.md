---
title: Deleting an object in {{ objstorage-full-name }}
description: Follow this guide to delete an object from a bucket in {{ objstorage-name }}.
---

# Deleting an object

{% include [restore-only-versioning](../../../_includes/storage/restore-only-versioning.md) %}

## Deleting an object or object version without a lock {#wo-object-lock}

Any object or object version without a [lock](../../concepts/object-lock.md) (with no locks enabled in the bucket) can be deleted without further confirmation.

{% note info %}

To delete an object with an incomplete [multipart upload](../../concepts/multipart.md), follow [this guide](deleting-multipart.md).

{% endnote %}

The minimum required role is `storage.editor`.

To delete an object:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket storing the object you want to delete.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To see all versions of objects in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. To delete a single object, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.storage.file.button_delete }}**.

     To delete multiple objects, select them from the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.

     {% note info %}

     You can delete a directory with objects. This is an asynchronous operation, so the objects will not disappear from the bucket right away but will be deleted gradually. Meanwhile, you can continue with other operations in the management console, including uploading new objects to the directory which is being deleted. You can learn more [here](../../concepts/object.md#folder).

     {% endnote %}

  1. In the window that opens, click **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

  In the management console, the information about the number of objects and storage space used in the bucket is updated with a few minutes' delay.

  {% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting an object from a bucket:

      ```bash
      yc storage s3api delete-object --help
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

  1. Run this command:

      ```bash
      yc storage s3api put-object \
        --bucket <bucket_name> \
        --key <object_key>
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object [key](../../concepts/object.md#key).

      Result:

      ```bash
      request_id: 0311ec7********
      ```

      Alternative command:

      ```bash
      yc storage s3 rm \
        s3://<bucket_name>/<object_key>
      ```

      Result:

      ```text
      delete: s3://my-bucket/object.txt
      ```

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  In the terminal, run `aws s3api delete-object`:

  ```bash
  aws s3api delete-object \
    --endpoint-url https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    --key <object_key>
  ```

  Where:
  * `--bucket`: Name of your bucket.
  * `--key`: Object [key](../../concepts/object.md#key).

  To delete multiple objects at once, provide the keys of these objects in the `--delete` parameter:

  * **Bash**:

      ```bash
      aws s3api delete-objects \
        --endpoint-url=https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --delete '{"Objects":[{"Key":"<object_1_key>"},{"Key":"<object_2_key>"},...,{"Key":"<object_n_key>"}]}'
      ```

  * **PowerShell**:

      ```powershell
      aws s3api delete-objects `
        --endpoint-url=https://{{ s3-storage-host }} `
        --bucket <bucket_name> `
        --delete '{\"Objects\":[{\"Key\":\"<object_1_key>\"},{\"Key\":\"<object_2_key>\"},...,{\"Key\":\"<object_n_key>\"}]}'
      ```

  Where:
  * `--bucket`: Bucket name.
  * `<object_1_key>`, `<object_2_key>`, `<object_n_key>`: [Keys](../../concepts/object.md#key) of objects to delete.

  Result:

  ```text
  {
    "Deleted": [
        {
            "Key": "<object_1_key>",
            "VersionId": "null"
        },
        {
            "Key": "<object_2_key>",
            "VersionId": "null"
        }
        ...
        {
            "Key": "<object_n_key>",
            "VersionId": "null"
        }
    ]
  }
  ```

  You can use a JMESPath query template to specify objects you want to delete. To delete objects using a query template, run this command:

  * **Bash**:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --query '<query>' \
        --output text | xargs -I {} aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket <bucket_name> --key {}
      ```

      Where:
      * `--bucket`: Bucket name.
      * `--query`: Query in [JMESPath](https://jmespath.org/) format.

      Here is an example of the command that deletes all objects with filenames starting with `20231002` from `sample-bucket` from in the `screenshots` directory:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket sample-bucket \
        --query 'Contents[?starts_with(Key, `screenshots/20231002`) == `true`].[Key]' \
        --output text | xargs -I {} aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key {}
      ```

  * **PowerShell**:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket <bucket_name> `
        --query '<request>' `
        --output text)) `
        {aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket <bucket_name> --key $x}
      ```

      Where:
      * `--bucket`: Bucket name.
      * `--query`: Query in [JMESPath](https://jmespath.org/) format.

      Here is an example of the command that deletes all objects with filenames starting with `20231002` from `sample-bucket` from in the `screenshots` directory:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket sample-bucket `
        --query 'Contents[?starts_with(Key, `screenshots/20231002`) == `true`].[Key]' `
        --output text)) `
        {aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key $x}
      ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  To delete an object created with {{ TF }} from a bucket:
  1. Open the {{ TF }} configuration file and delete the section specifying the object.

     {% cut "Example of specifying an object in {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_storage_object" "cute-cat-picture" {
       access_key = "YCAJEX9Aw2ge********-w-lJ"
       secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZ********"
       bucket     = "cat-pictures"
       key        = "cute-cat"
       source     = "/images/cats/cute-cat.jpg"
     }
     ...
     ```

     {% endcut %}

  1. In the command line, navigate to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the update using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [delete](../../s3/api-ref/object/delete.md) S3 API method.

  {% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

{% endlist %}

## Deleting an object version with an object lock {#w-object-lock}

If the bucket is configured with [object version locks](../buckets/configure-object-lock.md), some or all users might be unable to delete object versions.

To check for a lock and delete the object version where possible:

{% list tabs group=instructions %}

- Management console {#console}

  1. If possible, [remove the lock](edit-object-lock.md) from the object you want to delete.
  1. [Delete](#object-lock-w-object-lock) the object.
  
  In the management console, the information about the number of objects and storage space used in the bucket is updated with a few minutes' delay.
  
  {% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get information about an object version lock:

      ```bash
      yc storage s3api head-object \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID>
      ```

     Where:
     * `--bucket`: Name of your bucket.
     * `--key`: Object [key](../../concepts/object.md#key).
     * `--version-id`: Object version ID.

     If there is a lock for the version, you will see the following:

     ```text
     object_lock_mode: GOVERNANCE
     object_lock_retain_until_date: "2024-10-11T10:23:12Z"
     ```

     Or:

     ```text
     object_lock_legal_hold_status: ON
     ```

     Where:
     * `object_lock_mode`: [Type](../../concepts/object-lock.md#types) of retention:
       * `GOVERNANCE`: Governance-mode retention. To delete the object version, you need the `storage.admin` role.
       * `COMPLIANCE`: Compliance-mode retention. You cannot delete the object version.

     * `object_lock_retain_until_date`: Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`.

     * `object_lock_legal_hold_status`: [Legal hold](../../concepts/object-lock.md#types) status:
       * `ON`: Enabled. You cannot delete the object version. To [remove the lock](edit-object-lock.md#remove-legal-hold), you need the `storage.uploader` role.
       * `OFF`: Disabled.

     If the object version is not locked, these fields will not appear, and you can delete the object version by following [this guide](#wo-object-lock).

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

  1. If the governance-mode retention (`"object_lock_mode": "GOVERNANCE"`) is set, and you have the `storage.admin` role, delete the object version:

      ```bash
      yc storage s3api delete-object \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID> \
        --bypass-governance-retention
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object [key](../../concepts/object.md#key).
      * `--version-id`: Object version ID.
      * `--bypass-governance-retention`: Lock bypass flag.

      Result:

      ```bash
      request_id: a58bf215********
      version_id: "null"
      ```

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  1. Get information about an object lock:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api head-object \
       --bucket <bucket_name> \
       --key <object_key> \
       --version-id <version_ID>
     ```

     Where:
     * `--bucket`: Name of your bucket.
     * `--key`: Object [key](../../concepts/object.md#key).
     * `--version-id`: Object version ID.

     If your object version is locked, you can find the lock details in the command output:

     ```json
     {
       ...
       "ObjectLockMode": "<retention_type>",
       "ObjectLockRetainUntilDate": "<date_and_time>",
       "ObjectLockLegalHoldStatus": "<legal_hold_status>",
       ...
     }
     ```

     Where:
     * `ObjectLockMode`: [Type](../../concepts/object-lock.md#types) of retention:
       * `GOVERNANCE`: Temporary managed lock. To delete the object version, you need the `storage.admin` role.
       * `COMPLIANCE`: Compliance-mode retention. You cannot delete the object version.

     * `ObjectLockRetainUntilDate`: Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`.

     * `ObjectLockLegalHoldStatus`: [Legal hold](../../concepts/object-lock.md#types) status:
       * `ON`: Enabled. You cannot delete the object version. To [remove the lock](edit-object-lock.md#remove-legal-hold), you need the `storage.uploader` role.
       * `OFF`: Disabled.

     If the object version is not locked, these fields will not appear, and you can delete the object version by following [this guide](#wo-object-lock).

  1. If the governance-mode retention (`"ObjectLockMode": "GOVERNANCE"`) is set, and you have the `storage.admin` role, delete the object version:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api delete-object \
       --bucket <bucket_name> \
       --key <object_key> \
       --version-id <version_ID> \
       --bypass-governance-retention
     ```

     Where:
     * `--bucket`: Name of your bucket.
     * `--key`: Object [key](../../concepts/object.md#key).
     * `--version-id`: Object version ID.
     * `--bypass-governance-retention`: Lock bypass flag.

- API {#api}

  1. To get info on a lock applied to an object version, use the [getObjectRetention](../../s3/api-ref/object/getobjectretention.md) and [getObjectLegalHold](../../s3/api-ref/object/getobjectlegalhold.md) S3 API methods.
  1. If the governance-mode retention (`GOVERNANCE`) is only set, and you have the `storage.admin` role, delete the object version using the [delete](../../s3/api-ref/object/delete.md) S3 API method. In your request, specify the version ID and the `X-Amz-Bypass-Governance-Retention` header to confirm bypassing the lock.

{% endlist %}