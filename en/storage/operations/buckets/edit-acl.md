---
title: "Editing a bucket ACL in {{ objstorage-full-name }}"
description: "To control access to an {{ objstorage-name }} bucket, besides {{ iam-short-name }}, you can also use an access control list (ACL)."
---

# Editing the ACL of a bucket

To control access to an {{ objstorage-name }} bucket, besides [{{ iam-short-name }}](../../../iam/), you can also use an [ACL](../../concepts/acl.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. To edit an ACL, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the bucket name and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.

      You can also click the bucket name and then click **{{ ui-key.yacloud.storage.bucket.button_permissions }}** on the page that opens.

   1. In the **{{ ui-key.yacloud.storage.permissions-dialog.label_title }}** window that opens, grant or revoke the appropriate permissions.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Before setting up an ACL, view a description of the CLI command to edit a bucket:

   ```bash
   yc storage bucket update --help
   ```

   You can apply a [predefined ACL](../../concepts/acl.md#predefined-acls) to a bucket or configure permissions for individual users, [service accounts](../../../iam/concepts/users/service-accounts.md), and [system groups](../../concepts/acl.md#system-groups) (e.g., a group including all internet users or a group including all authenticated {{ yandex-cloud }} users). These settings are not compatible: a bucket should have either a predefined ACL or a set of individual permissions.

   Using a predefined ACL

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

   : 1. To grant a {{ yandex-cloud }} user or service account permissions using an ACL, get their ID. For more information, see [{#T}](../../../iam/operations/users/get.md) and [{#T}](../../../iam/operations/sa/get-id.md).
    1. Run the following command:

       ```bash
       yc storage bucket update --name <bucket_name> \
         --grants grant-type=<permission_grantee_type>,grantee-id=<grantee_ID>,permission=<permission_type>
       ```

       Where:
       * `grant-type`: Type of the permission grantee. The possible values include:
         * `grant-type-account`: User or service account.
         * `grant-type-all-authenticated-users`: [System group](../../concepts/acl.md#system-groups) of all authenticated {{ yandex-cloud }} users.
         * `grant-type-all-users`: System group of all internet users.
       * `grantee-id`: ID of the user or service account to grant permission to. Specified only if `grant-type=grant-type-account`.
       * `permission`: ACL permission type. Possible values are `permission-full-control`, `permission-write`, and `permission-read`. For more information about permissions, see [{#T}](../../concepts/acl.md#permissions-types).

       To configure multiple permissions, specify the `--grants` parameter multiple times.

       Permissions specified in the command override the current ACL settings of the bucket, including its predefined ACL. You can retrieve the current permissions using the `yc storage bucket get <bucket_name> --full` command.

       Result:

       ```bash
       name: my-bucket
       folder_id: csgeoelk7fl1********
       default_storage_class: STANDARD
       versioning: VERSIONING_SUSPENDED
       max_size: "10737418240"
       acl:
         grants:
           - permission: PERMISSION_READ
             grant_type: GRANT_TYPE_ACCOUNT
             grantee_id: ajej2th5699n********
       created_at: "2022-12-14T08:42:16.273717Z"
       ```

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Before you start, retrieve the [static access keys](../../../iam/operations/sa/create-access-key.md): a secret key and a key ID used for authentication in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```
      resource "yandex_storage_bucket" "test" {
        access_key = "<static key ID>"
        secret_key = "<secret key>"
        bucket = "<bucket name>"
        grant {
          id          = "<user ID>"
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
      * `grant`: [ACL](../../concepts/acl.md). This is an optional parameter. For access management, use a service account with administrator rights.
         * `id`: User ID.
         * `type`: System group type.
         * `permissions`: Types of permissions according to the [ACL](../../concepts/acl.md#permissions-types).
         * `uri`: System group ID.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:
         ```
         terraform plan
         ```

      If the configuration is specified correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:
      ```
      terraform apply
      ```

      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API

   To edit a bucket's ACL, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) S3 API method.

{% endlist %}
