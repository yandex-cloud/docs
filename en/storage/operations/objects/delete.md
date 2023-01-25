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
   1. Click the name of the desired bucket.
   1. To delete a single object, click ![image](../../../_assets/horizontal-ellipsis.svg) to the right of the object name and click **Delete** in the resulting window.

      To do the same with multiple objects, select them in the list and click **Delete** at the bottom of the screen.

      {% note info %}

      You can delete a folder with objects. This is an asynchronous operation. Once run, objects are gradually deleted from the bucket instead of all at once. During this time, you can perform other operations in the management console, including upload new objects to the folder being deleted. For more information, see [Folder](../../concepts/object.md#folder).

      {% endnote %}

   1. In the window that opens, click **Delete**.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To delete an object created with {{ TF }} from a bucket:
   1. Open the {{ TF }} configuration file and delete the fragment with the object description.

      {% cut "Example object description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_object" "cute-cat-picture" {
        access_key = "YCAJEX9Aw2ge1VKjlYXf-w-lJ"
        secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZMcSJz2N0"
        bucket     = "cat-pictures"
        key        = "cute-cat"
        source     = "/images/cats/cute-cat.jpg"
      }
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Check the configuration using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```text
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

{% endlist %}


## Deleting an object version with an object lock {#w-object-lock}

If [object lock](../buckets/configure-object-lock.md) is enabled in the bucket, some or all users can be forbidden to delete an object version.

To check whether lock has been put and delete the object version when possible:

{% list tabs %}

- AWS CLI

   1. If you don't have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   1. Get information about an object lock:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api head-object \
        --bucket <bucket_name> \
        --key <object_key> \
        --version-id <version_ID>
      ```

      Where:
      * `bucket`: Your bucket's name.
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
         * `GOVERNANCE`: An object lock with a predefined retention period that can be managed. Users with the `storage.admin` role can delete an object version.
         * `COMPLIANCE`: An object lock with a predefined retention period with strict compliance. An object version can't be deleted.

      * `ObjectLockRetainUntilDate`: Date and time until which an object is to be locked, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). For example, `Mon, 12 Dec 2022 09:00:00 GMT`.

      * `ObjectLockLegalHoldStatus`: Status of [legal hold](../../concepts/object-lock.md#types):
         * `ON`: Enabled. An object version can't be deleted. Users with the `storage.uploader` role can [remove a lock](edit-object-lock.md#remove-legal-hold).
         * `OFF`: Disabled.

      If the object version isn't locked, these fields aren't displayed, and you can delete the object version by following the [instructions on deleting an unlocked version](#wo-object-lock).

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
      * `bucket`: Your bucket's name.
      * `key`: Object [key](../../concepts/object.md#key).
      * `version-id`: Object version ID.
      * `bypass-governance-retention`: Flag that shows that a lock is bypassed.

- API

   1. Get details of the lock put on the object version by using the methods [getObjectRetention](../../s3/api-ref/object/getobjectretention.md) (retention) and [getObjectLegalHold](../../s3/api-ref/object/getobjectlegalhold.md) (legal hold).
   1. If you only have governance-mode retention (`GOVERNANCE`) and you have the `storage.admin` role, delete the object version by the [delete](../../s3/api-ref/object/delete.md) method: In your request, specify the version ID and the `X-Amz-Bypass-Governance-Retention` header to confirm lock bypass.

{% endlist %}
