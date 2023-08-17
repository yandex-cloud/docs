# Deleting an object


## Deleting an object or object version without a lock {#wo-object-lock}

An object or object version for which the [lock](../../concepts/object-lock.md) has not been set (for example because object lock hasn't been enabled in the bucket) can be deleted without any additional confirmation.

{% note info %}

To delete an object with an incomplete [multipart upload](../../concepts/multipart.md), follow these [instructions](deleting-multipart.md).

{% endnote %}

The minimum required role is `storage.editor`.

To delete an object:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket you need.
   1. To delete a single object, click ![image](../../../_assets/horizontal-ellipsis.svg) to the right of the object name; in the menu that opens, click **{{ ui-key.yacloud.storage.file.button_delete }}**.

      To do the same with multiple objects, select them in the list and click **{{ ui-key.yacloud.storage.bucket.button_gr-delete }}** at the bottom of the screen.

      {% note info %}

      You can delete a folder with objects. This is an asynchronous operation. Once run, objects are gradually deleted from the bucket instead of all at once. During this time, you can perform other operations in the management console, including upload new objects to the folder being deleted. For more information, see [Folder](../../concepts/object.md#folder).

      {% endnote %}

   1. In the window that opens, click **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

   In the management console, information about the number of objects in a bucket and the used space is updated with a few minutes' delay.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

- API

   Use the [delete](../../s3/api-ref/object/delete.md) S3 API method.

{% endlist %}


## Deleting an object version with an object lock {#w-object-lock}

If [object lock](../buckets/configure-object-lock.md) is enabled in the bucket, some or all users can be forbidden to delete an object version.

To check whether lock has been put and delete the object version when possible:

{% list tabs %}

- AWS CLI

   1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   1. Get information about an object lock:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api head-object \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID>
      ```

      Where:
      * `bucket`: Name of your bucket.
      * `key`: Object [key](../../concepts/object.md#key).
      * `version-id`: Object version ID.

      If an object version is locked, the following command returns the lock details:

      ```json
      {
        ...
        "ObjectLockMode": "<type_of_object_lock_with_retention_period>",
        "ObjectLockRetainUntilDate": "<object_lock_retain_until_date_and_time>",
        "ObjectLockLegalHoldStatus": "<status_of_legal_hold>",
        ...
      }
      ```

      Where:
      * `ObjectLockMode`: [Type](../../concepts/object-lock.md#types) of object lock set for a certain period:
         * `GOVERNANCE`: Object lock with a predefined retention period that can be managed. Users with the `storage.admin` role can delete an object version.
         * `COMPLIANCE`: Object lock with a predefined retention period with strict compliance. You cannot delete an object version.

      * `ObjectLockRetainUntilDate`: Date and time until which the object will be locked, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`.

      * `ObjectLockLegalHoldStatus`: Status of [legal hold](../../concepts/object-lock.md#types):
         * `ON`: Enabled. You cannot delete an object version. To [remove a lock](edit-object-lock.md#remove-legal-hold), a user must have the `storage.uploader` role.
         * `OFF`: Disabled.

      If the object version is not locked, these fields will not be displayed, and you can delete the object version just as you would do in case of an unlocked version, following [this guide](#wo-object-lock).

   1. If you have the `storage.admin` role and `"ObjectLockMode": "GOVERNANCE"` is set, delete an object version:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api delete-object \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID> \
        --bypass-governance-retention
      ```

      Where:
      * `bucket`: Name of your bucket.
      * `key`: Object [key](../../concepts/object.md#key).
      * `version-id`: Object version ID.
      * `bypass-governance-retention`: Flag that shows that a lock is bypassed.

- API

   1. To get the details of the lock applied to an object version, use the [getObjectRetention](../../s3/api-ref/object/getobjectretention.md) (retention) and [getObjectLegalHold](../../s3/api-ref/object/getobjectlegalhold.md) (legal hold) S3 API methods.
   1. If you only have `GOVERNANCE` retention set and you have the `storage.admin` role, delete the object version using the [delete](../../s3/api-ref/object/delete.md) S3 API method. In your request, specify the version ID and the `X-Amz-Bypass-Governance-Retention` header to confirm lock bypass.

{% endlist %}
