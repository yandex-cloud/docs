---
title: Editing an object ACL in a {{ objstorage-full-name }} bucket
description: Follow this guide to edit an object ACL in an {{ objstorage-name }} bucket.
---

# Editing an object ACL

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

To manage access to an object in an {{ objstorage-name }} bucket, you can use an [ACL](../../concepts/acl.md).

{% note info %}

If your object already has a configured [ACL](../../concepts/acl.md), it will be completely overwritten once you apply the changes.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** and find the object in the list.
    1. To edit the ACL, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the object and select **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.

        Alternatively, you can click the object name, then, on the page that opens, click ![image](../../../_assets/console-icons/ellipsis.svg) at the top right and select **{{ ui-key.yacloud.storage.file.button_permissions }}**.

        {% include [acl-edit-console](../../../_includes/storage/acl-edit-console.md) %}

        {% note info %}
  
        {% include [console-sa-acl-note](../../../_includes/storage/console-sa-acl-note.md) %}
  
        {% endnote %}

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  {% note info %}

  To manage bucket ACL settings, assign the `storage.admin` [role](../../security/index.md#storage-admin) to the service account used by the AWS CLI.

  {% endnote %}



  View the object's current ACL:

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

  You can apply a [predefined ACL](../../concepts/acl.md#predefined-acls) to an object or configure permissions for individual users, [service accounts](../../../iam/concepts/users/service-accounts.md), [user groups](../../../organization/concepts/groups.md), and [public groups](../../concepts/acl.md#public-groups), such as a group of all internet users or a group of all authenticated {{ yandex-cloud }} users. These settings cannot be used together: an object can have either a predefined ACL or individual permissions.

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
  * `--acl`: Predefined ACL. To view a list of values, see [{#T}](../../concepts/acl.md#predefined-acls).

  **Setting up individual permissions**

  1. To grant ACL permissions to a {{ yandex-cloud }} user, service account, or user group, get their IDs:

      
      * [User](../../../iam/operations/users/get.md).
      * [Service account](../../../iam/operations/sa/get-id.md).
      * User group: Navigate to the [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-cloud-center }}/groups) tab in the {{ cloud-center }} interface.


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
        * The possible types of ACL permissions are as follows:
          * `--grant-read`: Read access to the object.
          * `--grant-full-control`: Full access to the object.
          * `--grant-read-acp`: Read access to the object ACL.
          * `--grant-write-acp`: Edit access to the object ACL.

          You can specify multiple permissions in a single command.
        * The possible permission grantees are as follows:
          * `id=<grantee_ID>`: ID of the user, service account, or user group you need to grant a permission to.
          * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: [Public group](../../concepts/acl.md#public-groups) that includes all authenticated {{ yandex-cloud }} users.
          * `uri=http://acs.amazonaws.com/groups/global/AllUsers`: Public group that includes all internet users.

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}


  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  To edit an object ACL:

  1. Open the {{ TF }} configuration file and add the `acl` parameter to the object description:

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
     * `access_key`: Static access key ID.

        {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

     * `secret_key`: Secret access key value.
     * `acl`: Object's [predefined ACL](../../../storage/concepts/acl.md#predefined-acls). The default value is `private`: {{ yandex-cloud }} users get permissions according to their roles in {{ iam-short-name }}.

     For more information about the `yandex_storage_object` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/storage_object).

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

     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the security group update using the [management console]({{ link-console-main }}).

- API {#api}

  To edit an object ACL, use the [objectPutAcl](../../s3/api-ref/acl/objectput.md) S3 API method.

  To upload an object an install an ACL, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `X-Amz-Acl`, `X-Amz-Grant-Read`, `X-Amz-Grant-Read-Acp`, `X-Amz-Grant-Write-Acp`, and `X-Amz-Grant-Full-Control` headers.

{% endlist %}
