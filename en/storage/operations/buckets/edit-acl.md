---
title: "Editing a bucket ACL in {{ objstorage-full-name }}"
description: "To control access to an {{ objstorage-name }} bucket, besides {{ iam-short-name }}, you can also use an access control list (ACL)."
---

# Editing a bucket ACL

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

{% note info %}

If an [ACL](../../concepts/acl.md) was previously set for a [bucket](../../concepts/bucket.md), it will be completely overwritten once you apply the changes.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. To edit an ACL, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the bucket name and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.

      You can also click the bucket name and then click **{{ ui-key.yacloud.storage.buckets.button_permissions }}** on the page that opens.

   1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window that opens, grant or revoke the appropriate permissions.

      {% note info %}

      {% include [console-sa-acl-note](../../../_includes/storage/console-sa-acl-note.md) %}

      {% endnote %}

- {{ yandex-cloud }} CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Before setting up an ACL, view a description of the CLI command to edit a bucket:

   ```bash
   yc storage bucket update --help
   ```

   To view a bucket's current ACL, run this command:

   ```bash
   yc storage bucket get <bucket_name> --with-acl
   ```

   You can apply a [predefined ACL](../../concepts/acl.md#predefined-acls) to a bucket or configure permissions for individual users, [service accounts](../../../iam/concepts/users/service-accounts.md), [user groups](../../../organization/concepts/groups.md) and [system groups](../../concepts/acl.md#system-groups) (e.g., a group including all internet users or a group including all authenticated {{ yandex-cloud }} users). These settings are not compatible: a bucket should have either a predefined ACL or a set of individual permissions.

   Predefined ACL

   : Run this command:

   ```bash
   yc storage bucket update --name <bucket_name> --acl <predefined_ACL>
   ```

   Where:
   * `--name`: Bucket name.
   * `--acl`: Predefined ACL. For a list of values, see [{#T}](../../concepts/acl.md#predefined-acls).

   Result:

   ```bash
   name: my-bucket
   folder_id: csgeoelk7fl1********
   default_storage_class: STANDARD
   versioning: VERSIONING_DISABLED
   max_size: "1073741824"
   acl:
     grants:
       - permission: PERMISSION_READ
         grant_type: GRANT_TYPE_ALL_USERS
   created_at: "2022-12-14T19:10:05.957940Z"
   ```

   Setting up individual permissions

   : 1. To grant ACL permissions to a {{ yandex-cloud }} user, service account, or user group, get their ID:

         
         * [User](../../../iam/operations/users/get.md).
         * [Service account](../../../iam/operations/sa/get-id.md).
         * User group: Navigate to the [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-main }}groups) tab in the {{ org-name }} interface.


   1. Run this command:

      ```bash
      yc storage bucket update --name <bucket_name> \
        --grants grant-type=<permission_grantee_type>,grantee-id=<grantee_ID>,permission=<permission_type>
      ```

      Where:
      * `grant-type`: Type of the permission grantee. The possible values include:
         * `grant-type-account`: User, [service account](../../../iam/concepts/users/service-accounts.md), or [user group](../../../organization/concepts/groups.md).
         * `grant-type-all-authenticated-users`: [System group](../../concepts/acl.md#system-groups) of all authenticated {{ yandex-cloud }} users.
         * `grant-type-all-users`: System group of all internet users.
      * `grantee-id`: ID of the user, service account, or user group to grant permission to. It is specified only if `grant-type=grant-type-account`.
      * `permission`: ACL permission type. Possible values are `permission-full-control`, `permission-write`, and `permission-read`. For more information about permissions, see [{#T}](../../concepts/acl.md#permissions-types).

      To configure multiple permissions, specify the `--grants` parameter multiple times.

- AWS CLI {#aws-cli}

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   {% note info %}

   To manage bucket ACLs, assign the `storage.admin` [role](../../security/index.md#storage-admin) to the service account via which the AWS CLI operates.

   {% endnote %}

   View the bucket's current ACL:

   ```bash
   aws s3api get-bucket-acl \
     --endpoint https://{{ s3-storage-host }} \
     --bucket <bucket_name>
   ```

   Where:
   * `--bucket`: Bucket name.
   * `--endpoint`: {{ objstorage-name }} endpoint.

   You can apply a [predefined ACL](../../concepts/acl.md#predefined-acls) to a bucket or configure permissions for individual users, [service accounts](../../../iam/concepts/users/service-accounts.md), [user groups](../../../organization/concepts/groups.md) and [system groups](../../concepts/acl.md#system-groups) (e.g., a group including all internet users or a group including all authenticated {{ yandex-cloud }} users). These settings are not compatible: a bucket should have either a predefined ACL or a set of individual permissions.

   Predefined ACL

   : Run this command:

   ```bash
     aws s3api put-bucket-acl \
       --endpoint https://{{ s3-storage-host }} \
       --bucket <bucket_name> \
       --acl <predefined_ACL>
   ```

   Where:

   * `--endpoint`: {{ objstorage-name }} endpoint.
   * `--bucket`: Bucket name.
   * `--acl`: Predefined ACL. For a list of values, see [{#T}](../../concepts/acl.md#predefined-acls).

   Setting up individual permissions

   : 1. To grant ACL permissions to a {{ yandex-cloud }} user, service account, or user group, get their ID:

         
         * [User](../../../iam/operations/users/get.md).
         * [Service account](../../../iam/operations/sa/get-id.md).
         * User group: Navigate to the [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-main }}groups) tab in the {{ org-name }} interface.


   1. Run this command:

      ```bash
      aws s3api put-bucket-acl \
        --endpoint https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        <permission_type> <permission_grantee>
      ```

      Where:
      * `--bucket`: Bucket name.
      * `--endpoint`: {{ objstorage-name }} endpoint.
      * Possible types of ACL permissions:
         * `--grant-read`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, static hosting), and read all objects in the bucket.
         * `--grant-write`: Permission to write, rewrite, and delete objects in the bucket. It is used only together with `--grant-read`.
         * `--grant-full-control`: Full access to the bucket and the objects in it.

         You can set multiple permissions within the same command.
      * Possible permission grantees:
         * `id=<grantee_ID>`: ID of the user, service account, or user group to grant permission to.
         * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: [System group](../../concepts/acl.md#system-groups) of all authenticated {{ yandex-cloud }} users.
         * `uri=http://acs.amazonaws.com/groups/global/AllUsers`: System group of all internet users.

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Before you start, retrieve the [static access keys](../../../iam/operations/sa/create-access-key.md): a secret key and a key ID used for authentication in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_storage_bucket" "test" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket = "<bucket_name>"
        grant {
          id          = "<user_ID>"
          type        = "CanonicalUser"
          permissions = ["FULL_CONTROL"]
        }

        grant {
          type        = "Group"
          permissions = ["READ", "WRITE"]
          uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
        }
      }
      ```

      Where:

      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `bucket`: Bucket name. This is a required parameter.
      * `grant`: [ACL](../../concepts/acl.md) settings. This is an optional parameter. To manage this parameter, the service account for which the static access keys were obtained must have the `storage.admin` [role](../../security/index.md#roles-list) for a bucket or a folder.
         * `type`: Type of the permission grantee. The possible values include:
            * `CanonicalUser`: For a user, [service account](../../../iam/concepts/users/service-accounts.md), or [user group](../../../organization/concepts/groups.md).
            * `Group`: For a [system group](../../concepts/acl.md#system-groups).
         * `permissions`: Type of ACL [permissions](../../concepts/acl.md#permissions-types).
         * `id`: ID of the user, service account, or user group. It is used with the `CanonicalUser` permission grantee type.

            
            You can get the IDs in any of the following ways:
            * [User](../../../iam/operations/users/get.md)
            * [Service account](../../../iam/operations/sa/get-id.md)
            * User group: Navigate to the [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-main }}groups) tab in the {{ org-name }} interface.


         * `uri`: System group ID. It is used with the `Group` permission grantee type. The possible values include:
            * `http://acs.amazonaws.com/groups/global/AllUsers`: All internet users.
            * `http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: All authenticated {{ yandex-cloud }} users.

      Instead of the `grant` parameter, you can specify the `acl` parameter, which represents the [predefined ACL](../../../storage/concepts/acl.md#predefined-acls) of the bucket. The default value is `private`: {{ yandex-cloud }} users get permissions based on their roles in {{ iam-short-name }}.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

   To edit a bucket's ACL, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) S3 API method.

{% endlist %}
