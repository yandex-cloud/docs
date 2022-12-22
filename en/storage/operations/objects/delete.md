# Deleting an object

{% if product == "yandex-cloud" %}

## Deleting an unlocked object {#wo-object-lock}

{% endif %}

{% note info %}

To delete an object with an incomplete [multipart upload](../../concepts/multipart.md), follow these [instructions](deleting-multipart.md).

{% endnote %}

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

   {% if audience != "internal" %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% endif %}

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

{% endlist %}

{% if product == "yandex-cloud" %}

## Deleting an object version with an object lock {#w-object-lock}

{% list tabs %}

- AWS CLI

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
      * `ObjectLockRetainUntilDate`: Date and time until which an object is to be locked, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). For example, `Mon, 12 Dec 2022 09:00:00 GMT`. Can only be set together with the `object-lock-mode` parameter.
      * `ObjectLockLegalHoldStatus`: Status of [legal hold](../../concepts/object-lock.md#types):
         * `ON`: Enabled. An object version can't be deleted. Users with the `storage.uploader` role can [remove a lock](edit-object-lock.md#remove-legal-hold).
         * `OFF`: Disabled.
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

{% endlist %}

{% endif %}