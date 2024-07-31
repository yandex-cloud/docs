---
title: "Editing an object ACL in {{ objstorage-full-name }}"
description: "To control access to an object in an {{ objstorage-name }} bucket, you can use an access control list (ACL)."
---

# Editing an object ACL

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

To control access to an object in an {{ objstorage-name }} bucket, you can use an [ACL](../../concepts/acl.md).

{% note info %}

If an [ACL](../../concepts/acl.md) has been set for an object, it will be completely overwritten once you apply the changes.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the bucket name.
   1. To edit an ACL, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the object name and select **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.

      You can also click the object name, click ![image](../../../_assets/console-icons/ellipsis.svg) on the page that opens, and select **{{ ui-key.yacloud.storage.file.button_permissions }}**.

   1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window that opens, grant or revoke the appropriate permissions.

      {% note info %}

      {% include [console-sa-acl-note](../../../_includes/storage/console-sa-acl-note.md) %}

      {% endnote %}

- AWS CLI {#aws-cli}

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   {% note info %}

   To manage an object ACL, assign the `storage.admin` [role](../../security/index.md#storage-admin) to the service account via which the AWS CLI operates.

   {% endnote %}

   View the current ACL of the object:

   ```bash
   aws s3api get-object-acl \
     --endpoint https://{{ s3-storage-host }} \
     --bucket <bucket_name> \
     --key <object_key>
   ```

   Where:
   * `--endpoint`: {{ objstorage-name }} endpoint.
   * `--bucket`: Bucket name.
   * `--key`: Object key.

   You can apply a [predefined ACL](../../concepts/acl.md#predefined-acls) to an object or configure permissions for individual users, [service accounts](../../../iam/concepts/users/service-accounts.md), [user groups](../../../organization/concepts/groups.md) and [system groups](../../concepts/acl.md#system-groups) (e.g., a group of all internet users or a group of all authenticated {{ yandex-cloud }} users). These settings are not compatible: an object should have either a predefined ACL or a set of individual permissions.

   **Predefined ACL**

   Run this command:

   ```bash
   aws s3api put-object-acl \
     --endpoint https://{{ s3-storage-host }} \
     --bucket <bucket_name> \
     --key <object_key> \
     --acl <predefined_ACL>
   ```

   Where:

   * `--endpoint`: {{ objstorage-name }} endpoint.
   * `--bucket`: Bucket name.
   * `--key`: Object key.
   * `--acl`: Predefined ACL. For a list of values, see [{#T}](../../concepts/acl.md#predefined-acls).

   **Setting up individual permissions**

   1. To grant ACL permissions to a {{ yandex-cloud }} user, service account, or user group, get their ID:

      
      * [User](../../../iam/operations/users/get.md)
      * [Service account](../../../iam/operations/sa/get-id.md)
      * User group: Navigate to the [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-main }}groups) tab in the {{ org-name }} interface.


   1. Run this command:

      ```bash
      aws s3api put-object-acl \
        --endpoint https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --key <object_key> \
        <permission_type> <permission_grantee>
      ```

      Where:
      * `--endpoint`: {{ objstorage-name }} endpoint.
      * `--bucket`: Bucket name.
      * `--key`: Object key.
      * Possible types of ACL permissions:
         * `--grant-read`: Access to read the object.
         * `--grant-full-control`: Full access to the object.
         * `--grant-read-acp`: Access to read the object ACL.
         * `--grant-write-acp`: Access to edit the object ACL.

         You can set multiple permissions within the same command.
      * The possible permission grantees are:
         * `id=<grantee_ID>`: ID of the user, service account, or user group to grant permission to.
         * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: [System group](../../concepts/acl.md#system-groups) of all authenticated {{ yandex-cloud }} users.
         * `uri=http://acs.amazonaws.com/groups/global/AllUsers`: System group of all internet users.

- {{ TF }} {#tf}

   {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   
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
      * `secret_key`: Value of the secret access key.
      * `acl`: [Predefined ACL](../../../storage/concepts/acl.md#predefined-acls) of an object. The default value is `private`: {{ yandex-cloud }} users get permissions based on their roles in {{ iam-short-name }}.

      For more information about the `yandex_storage_object` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_object).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
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

      You can verify the change to a security group in the [management console]({{ link-console-main }}).

- API {#api}

   To edit an ACL object, use the [objectPutAcl](../../s3/api-ref/acl/objectput.md) S3 API method.

   To upload an object with an ACL set, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `X-Amz-Acl`, `X-Amz-Grant-Read`, `X-Amz-Grant-Read-Acp`, `X-Amz-Grant-Write-Acp`, and `X-Amz-Grant-Full-Control` headers.

{% endlist %}
