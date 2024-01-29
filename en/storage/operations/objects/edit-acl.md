---
title: "Editing an object ACL in {{ objstorage-full-name }}"
description: "To control access to an object in an {{ objstorage-name }}, you can use an access control list (ACL)."
---

# Editing an object ACL

To control access to an object in an {{ objstorage-name }} bucket, you can use an [ACL](../../concepts/acl.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the bucket name.
   1. To edit an ACL, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the object name and select **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.

      You can also click the object name, click ![image](../../../_assets/console-icons/ellipsis.svg) on the resulting page, and select **{{ ui-key.yacloud.storage.file.button_permissions }}**.

   1. In the **{{ ui-key.yacloud.storage.permissions-dialog.label_title }}** window that opens, grant or revoke the appropriate permissions.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   {% include [terraform-install](../../../_includes/terraform-install.md) %}


   To edit an object ACL:

   1. Open the {{ TF }} configuration file and add the `acl` parameter to the object description.

      ```hcl
      ...
      resource "yandex_storage_object" "cute-cat-picture" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "cat-pictures"
        key        = "cute-cat"
        source     = "/images/cats/cute-cat.jpg"
        acl        = "public-read"
      }
      ...
      ```

      Where:
      * `access_key`: ID of the static access key.
      * `secret_key`: Secret access key value.
      * `acl`: [Predefined ACL](../../../storage/concepts/acl.md#predefined-acls) of an object. `private` (default): {{ yandex-cloud }} users are authorized based on their roles in {{ iam-short-name }}.

      For more information about the `yandex_storage_object` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_object).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to a security group in the [management console]({{ link-console-main }}).

- API {#api}

   To edit an ACL object, use the [objectPutAcl](../../s3/api-ref/acl/objectput.md) S3 API method.

   To upload an object with an ACL set, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `X-Amz-Acl`, `X-Amz-Grant-Read`, `X-Amz-Grant-Read-Acp`, `X-Amz-Grant-Write-Acp`, and `X-Amz-Grant-Full-Control` headers.

{% endlist %}
