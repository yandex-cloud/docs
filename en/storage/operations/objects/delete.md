---
title: Deleting an object in {{ objstorage-full-name }}
description: Follow this guide to delete an object in a bucket in {{ objstorage-name }}.
---

# Deleting an object

## Deleting an object or object version without a lock {#wo-object-lock}

An object or object version for which the [lock](../../concepts/object-lock.md) has not been set (e.g., because object lock is not enabled in the bucket) can be deleted without any additional confirmation.

{% note info %}

To delete an object with an incomplete [multipart upload](../../concepts/multipart.md), follow these [instructions](deleting-multipart.md).

{% endnote %}

The minimum required role is `storage.editor`.

To delete an object:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket where the object you need to delete is stored.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To see all versions of objects in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. To delete a single object, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_delete }}**.

     To do the same with multiple objects, select them in the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.

     {% note info %}

     You can delete a folder with objects. This is an asynchronous operation. Once run, objects are gradually deleted from the bucket instead of all at once. During this time, you can perform other operations in the management console, including upload new objects to the folder being deleted. For more information, see [Folder](../../concepts/object.md#folder).

     {% endnote %}

  1. In the window that opens, click **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

  In the management console, the information about the number of objects in the bucket and used up space is updated with a few minutes delay.

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

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  In the terminal, run the `aws s3api delete-object` command:

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
  * `<object_1_key>`, `<object_2_key>`, `<object_n_key>`: [Keys](../../concepts/object.md#key) of objects you need to delete.

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

  You can specify objects for deletion using a query template in JMESPath format. To delete objects using a query template, run the following command:

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

      Here is an example of the command that deletes from `sample-bucket` all objects located in the `screenshots` folder whose filenames start with `20231002`:

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
        --query '<query>' `
        --output text)) `
        {aws s3api delete-object --endpoint-url https://{{ s3-storage-host }} --bucket <bucket_name> --key $x}
      ```

      Where:
      * `--bucket`: Bucket name.
      * `--query`: Query in [JMESPath](https://jmespath.org/) format.

      Here is an example of the command that deletes from `sample-bucket` all objects located in the `screenshots` folder whose filenames start with `20231002`:

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
  1. Open the {{ TF }} configuration file and delete the fragment with the object description.

     {% cut "Example object description in a {{ TF }} configuration" %}

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

  1. In the command line, go to the directory with the {{ TF }} configuration file.
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

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the changes in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [delete](../../s3/api-ref/object/delete.md) S3 API method.

  {% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

{% endlist %}

## Deleting an object version with an object lock {#w-object-lock}

If [object lock](../buckets/configure-object-lock.md) is enabled in the bucket, some or all users can be forbidden to delete an object version.

To check whether lock has been put and delete the object version when possible:

{% list tabs group=instructions %}

- Management console {#console}

  1. If possible, [remove the lock](edit-object-lock.md) from the object you want to delete.
  1. [Delete](#object-lock-w-object-lock) the object.
  
  In the management console, the information about the number of objects in the bucket and used up space is updated with a few minutes delay.
  
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
     * `object_lock_mode`: Temporary lock [type](../../concepts/object-lock.md#types):
       * `GOVERNANCE`: Temporary managed lock. A user with the `storage.admin` role can delete an object version.
       * `COMPLIANCE`: Temporary strict lock. You cannot delete an object version.

     * `object_lock_retain_until_date`: Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`.

     * `object_lock_legal_hold_status`: [Legal hold](../../concepts/object-lock.md#types) status:
       * `ON`: Enabled You cannot delete an object version. To [remove a lock](edit-object-lock.md#remove-legal-hold), a user must have the `storage.uploader` role.
       * `OFF`: Disabled.

     If the object version is not locked, these fields will not be displayed, and you can delete the object version just as you would do in case of an unlocked version, following [this guide](#wo-object-lock).

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

  1. If the temporary managed lock (`"object_lock_mode": "GOVERNANCE"`) is set, and you have the `storage.admin` role, delete the object version:

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
      * `--bypass-governance-retention`: Flag that shows that a lock is bypassed.

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

     If an object version is locked, the following command returns the lock details:

     ```json
     {
       ...
       "ObjectLockMode": "<temporary_lock_type>",
       "ObjectLockRetainUntilDate": "<date_and_time>",
       "ObjectLockLegalHoldStatus": "<indefinite_lock_status>",
       ...
     }
     ```

     Where:
     * `ObjectLockMode`: Temporary lock [type](../../concepts/object-lock.md#types):
       * `GOVERNANCE`: Temporary managed lock. A user with the `storage.admin` role can delete an object version.
       * `COMPLIANCE`: Temporary strict lock. You cannot delete an object version.

     * `ObjectLockRetainUntilDate`: Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`.

     * `ObjectLockLegalHoldStatus`: [Legal hold](../../concepts/object-lock.md#types) status:
       * `ON`: Enabled. You cannot delete an object version. To [remove a lock](edit-object-lock.md#remove-legal-hold), a user must have the `storage.uploader` role.
       * `OFF`: Disabled.

     If the object version is not locked, these fields will not be displayed, and you can delete the object version just as you would do in case of an unlocked version, following [this guide](#wo-object-lock).

  1. If the temporary managed lock (`"ObjectLockMode": "GOVERNANCE"`) is set, and you have the `storage.admin` role, delete the object version:

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
     * `--bypass-governance-retention`: Flag that shows that a lock is bypassed.

- API {#api}

  1. To get the details of the lock applied to an object version, use the [getObjectRetention](../../s3/api-ref/object/getobjectretention.md) (retention) and [getObjectLegalHold](../../s3/api-ref/object/getobjectlegalhold.md) (legal hold) S3 API methods.
  1. If you only have the temporary managed lock (`GOVERNANCE`) set, and you have the `storage.admin` role, delete the object version using the [delete](../../s3/api-ref/object/delete.md) S3 API method. In your request, specify the version ID and the `X-Amz-Bypass-Governance-Retention` header to confirm lock bypass.

{% endlist %}