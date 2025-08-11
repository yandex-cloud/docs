---
title: Editing a bucket ACL in {{ objstorage-full-name }}
description: Follow this guide to edit a bucket access control list (ACL) in {{ objstorage-name }}.
---

# Editing a bucket ACL

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

{% note info %}

If your [bucket](../../concepts/bucket.md) already has a configured [ACL](../../concepts/acl.md), it will be completely overwritten once you apply the changes.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services.
  1. In the bucket row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.

      Alternatively, you can click the bucket name, then, on the page that opens, click ![image](../../../_assets/console-icons/ellipsis.svg) at the top right and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.

      {% include [acl-edit-console](../../../_includes/storage/acl-edit-console.md) %}

      {% note info %}
  
      {% include [console-sa-acl-note](../../../_includes/storage/console-sa-acl-note.md) %}
  
      {% endnote %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}


  {% include [acl-for-buckets](../../../_includes/storage/acl-for-buckets.md) %}

  You can edit a bucket's ACL using the following commands:
  * [yc storage bucket update](#yc-storage-bucket-update)
  * [yc storage s3api put-bucket-acl](#yc-storage-s3api-put-bucket-acl)

  **yc storage bucket update** {#yc-storage-bucket-update}

  Before configuring an ACL, see the description of the CLI command for editing a bucket:

  ```bash
  yc storage bucket update --help
  ```

  To view the current ACL of a bucket, run this command:

  ```bash
  yc storage bucket get <bucket_name> --with-acl
  ```

  _Predefined ACL_

  Run this command:

  ```bash
  yc storage bucket update \
    --name <bucket_name> \
    --acl <predefined_ACL>
  ```

  Where:
  * `--name`: Bucket name.
  * `--acl`: Predefined ACL. To view a list of values, see [{#T}](../../concepts/acl.md#predefined-acls).

  Result:

  ```text
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

  _Setting up individual permissions_

  1. To grant ACL permissions to a {{ yandex-cloud }} user, service account, or user group, get their IDs:

      {% include [acl-grantee](../../../_includes/storage/acl-grantee.md) %}

  1. Run this command:

      ```bash
      yc storage bucket update --name <bucket_name> \
        --grants grant-type=<permission_grantee_type>,grantee-id=<grantee_ID>,permission=<permission_type>
      ```

      Where:
      * `grant-type`: Permission grantee type. The possible values are as follows:
        * `grant-type-account`: User, [service account](../../../iam/concepts/users/service-accounts.md), or [user group](../../../organization/concepts/groups.md).
        * `grant-type-all-authenticated-users`: [Public group](../../concepts/acl.md#public-groups) that includes all authenticated {{ yandex-cloud }} users.
        * `grant-type-all-users`: Public group that includes all internet users.
      * `grantee-id`: ID of the user, service account, or user group you need to grant a permission to. It is specified only if `grant-type=grant-type-account`.
      * `permission`: ACL permission type. The possible values are:
        * `permission-read`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, and static hosting), and read all objects in the bucket.
        * `permission-write`: Permission to write, overwrite, and delete objects in the bucket. It can only be used together with `permission-read`.
        * `permission-full-control`: Full access to the bucket and objects in it.
      
        For more information about permissions, see [{#T}](../../concepts/acl.md#permissions-types).

      To configure multiple permissions, specify the `--grants` parameter multiple times. For example, to grant a write permission for a bucket, run this command:

      ```bash
      yc storage bucket update --name <bucket_name> \
        --grants grant-type=<permission_grantee_type>,grantee-id=<grantee_ID>,permission=permission-read \
        --grants grant-type=<permission_grantee_type>,grantee-id=<grantee_ID>,permission=permission-write
      ```

  **yc storage s3api put-bucket-acl** {#yc-storage-s3api-put-bucket-acl}

  View the bucket's current ACL:

  ```bash
  yc storage s3api get-bucket-acl \
    --bucket <bucket_name>
  ```

  Where `--bucket` is the bucket name.

  _Predefined ACL_

  Run this command:

  ```bash
  yc storage s3api put-bucket-acl \
    --bucket <bucket_name> \
    --acl <predefined_ACL>
  ```

  Where:
  * `--name`: Bucket name.
  * `--acl`: Predefined ACL. For the list of values, see [{#T}](../../concepts/acl.md#predefined-acls).

  _Setting up individual permissions_

  1. To grant ACL permissions to a {{ yandex-cloud }} user, service account, or user group, get their IDs:

      {% include [acl-grantee](../../../_includes/storage/acl-grantee.md) %}

  1. Run this command:

      ```bash
      yc storage s3api put-bucket-acl \
        --bucket <bucket_name> \
        <permission_type> <permission_grantee>
      ```

      Where:
      * `--bucket`: Bucket name.
      * The possible types of ACL permissions are as follows:

        * `--grant-read`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, and static hosting), and read all objects in the bucket.
        * `--grant-write`: Permission to write, overwrite, and delete objects in the bucket. It can only be used together with `--grant-read`.
        * `--grant-full-control`: Full access to the bucket and objects in it.

        For more information about permissions, see [{#T}](../../concepts/acl.md#permissions-types).

      * The possible permission grantees are as follows:

        * `id=<grantee_ID>`: ID of the user, service account, or user group you need to grant a permission to.
        * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: [Public group](../../concepts/acl.md#public-groups) that includes all authenticated {{ yandex-cloud }} users.
        * `uri=http://acs.amazonaws.com/groups/global/AllUsers`: Public group that includes all internet users.

      To configure multiple permissions, specify the relevant settings, permission type, and permission grantee multiple times. For example, to grant a write permission for a bucket, run this command:

      ```bash
      yc storage s3api put-bucket-acl \
        --bucket <bucket_name> \
        --grant-read id=<grantee_ID> \
        --grant-write id=<grantee_ID>
      ```

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  {% note info %}

  To manage bucket ACL settings, assign the `storage.admin` [role](../../security/index.md#storage-admin) to the service account used by the AWS CLI.

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

  {% include [acl-for-buckets](../../../_includes/storage/acl-for-buckets.md) %}

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
    * `--acl`: Predefined ACL. For the list of values, see [{#T}](../../concepts/acl.md#predefined-acls).

  Setting up individual permissions

  : 1. To grant ACL permissions to a {{ yandex-cloud }} user, service account, or user group, get their IDs:

        {% include [acl-grantee](../../../_includes/storage/acl-grantee.md) %}

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
        * The possible types of ACL permissions are as follows:
          * `--grant-read`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, and static hosting), and read all objects in the bucket.
          * `--grant-write`: Permission to write, overwrite, and delete objects in the bucket. It can only be used together with `--grant-read`.
          * `--grant-full-control`: Full access to the bucket and objects in it.

          For more information about permissions, see [{#T}](../../concepts/acl.md#permissions-types).

        * The possible permission grantees are as follows:
          * `id=<grantee_ID>`: ID of the user, service account, or user group you need to grant a permission to.
          * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: [Public group](../../concepts/acl.md#public-groups) that includes all authenticated {{ yandex-cloud }} users.
          * `uri=http://acs.amazonaws.com/groups/global/AllUsers`: Public group that includes all internet users.

        To configure multiple permissions, specify the relevant settings, permission type, and permission grantee multiple times. For example, to grant a write permission for a bucket, run this command:

        ```bash
        aws s3api put-bucket-acl \
          --endpoint https://storage.yandexcloud.net \
          --bucket <bucket_name> \
          --grant-read id=<grantee_ID> \
          --grant-write id=<grantee_ID>
        ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}


  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Before you start, retrieve the [static access keys](../../../iam/operations/authentication/manage-access-keys.md#create-access-key): a secret key and key ID used for {{ objstorage-short-name }} authentication.

  {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

  To edit a bucket ACL, you can use these resources:
  * [yandex_storage_bucket_grant](#tf-storage-bucket-grant)
  * [yandex_storage_bucket](#tf-yandex_storage_bucket) (obsolete)

  {% include [tf-iam-binding-warning](../../../_includes/storage/tf-bucket-grant-warning.md) %}

  **yandex_storage_bucket_grant** {#tf-storage-bucket-grant}

  1. In the configuration file, describe the parameters of resources you want to create:

     ```hcl
     resource "yandex_storage_bucket_grant" "my_bucket_grant" {
       bucket = "<existing_bucket_name>"
       grant {
         id          = "<user_1_ID>"
         permissions = ["READ", "WRITE"]
         type        = "CanonicalUser"
       }
       grant {
         id          = "<user_2_ID>"
         permissions = ["FULL_CONTROL"]
         type        = "CanonicalUser"
       }
       grant {
         uri         = "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
         permissions = ["READ"]
         type        = "Group"
       }
     }
     ```

     Where:

     * `bucket`: Existing bucket’s name.
     * `grant`: [ACL](../../concepts/acl.md) settings. To manage it, the service account with static access keys must have the `storage.admin` [role](../../security/index.md#roles-list) for the bucket or folder.
       * `type`: Permission grantee type. The possible values are:
         * `CanonicalUser`: For a user, [service account](../../../iam/concepts/users/service-accounts.md), or [user group](../../../organization/concepts/groups.md).
         * `Group`: For a [public group](../../concepts/acl.md#public-groups).
       * `permissions`: Type of ACL [permissions](../../concepts/acl.md#permissions-types). It can take the following values:
         * `READ`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, and static hosting), and read all objects in the bucket.
         * `WRITE`: Permission to write, overwrite, and delete objects in the bucket. It can only be used together with `READ`, e.g., `permissions = ["READ", "WRITE"]`.
         * `FULL_CONTROL`: Full access to the bucket and objects in it.

         For more information about permissions, see [{#T}](../../concepts/acl.md#permissions-types).

       * `id`: ID of the user, service account, or user group:

         {% include [acl-grantee](../../../_includes/storage/acl-grantee.md) %}

         It is used with the `CanonicalUser` type of permission grantee.

       * `uri`: Public group ID. It is used with the `Group` type of permission grantee. The possible values are:
         * `http://acs.amazonaws.com/groups/global/AllUsers`: All internet users.
         * `http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: All authenticated {{ yandex-cloud }} users.

     Instead of `grant`, you can specify `acl`, i.e., the [predefined ACL](../../../storage/concepts/acl.md#predefined-acls) of the bucket. The default value is `private`: {{ yandex-cloud }} users get permissions according to their roles in {{ iam-short-name }}.

     For more information about `yandex_storage_bucket_grant` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/storage_bucket_grant).

  1. If you plan to use the [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) resource together with [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) for the same bucket, we recommend creating them sequentially. To do this, add a dependency on the `yandex_storage_bucket_grant` resource to the `yandex_storage_bucket_iam_binding` section.

      ```hcl
      resource "yandex_storage_bucket_iam_binding" "mybucket-viewers" {
        ...
      
        depends_on = [
          yandex_storage_bucket_grant.my_bucket_grant
        ]
      }
      ```

  1. Apply the configuration:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the resource updates in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/) command:

     ```bash
     yc storage bucket get <bucket_name> --full
     ```

  **yandex_storage_bucket (obsolete)** {#tf-yandex_storage_bucket}

  1. In the configuration file, describe the parameters of resources you want to create:

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

     * `access_key`: Static access key ID.
     * `secret_key`: Secret access key value.
     * `bucket`: Bucket name. This is a required parameter.
     * `grant`: [ACL](../../concepts/acl.md) settings. This is an optional parameter. To manage it, the service account with static access keys must have the `storage.admin` [role](../../security/index.md#roles-list) for the bucket or folder.
       * `type`: Permission grantee type. The possible values are:
         * `CanonicalUser`: For a user, [service account](../../../iam/concepts/users/service-accounts.md), or [user group](../../../organization/concepts/groups.md).
         * `Group`: For a [public group](../../concepts/acl.md#public-groups).
       * `permissions`: Type of ACL [permissions](../../concepts/acl.md#permissions-types). It can take the following values:
         * `READ`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, and static hosting), and read all objects in the bucket.
         * `WRITE`: Permission to write, overwrite, and delete objects in the bucket. It can only be used together with `READ`, e.g., `permissions = ["READ", "WRITE"]`.
         * `FULL_CONTROL`: Full access to the bucket and objects in it.

         For more information about permissions, see [{#T}](../../concepts/acl.md#permissions-types).

       * `id`: ID of the user, service account, or user group:

         {% include [acl-grantee](../../../_includes/storage/acl-grantee.md) %}

         It is used with the `CanonicalUser` type of permission grantee.

       * `uri`: Public group ID. It is used with the `Group` type of permission grantee. The possible values are:
         * `http://acs.amazonaws.com/groups/global/AllUsers`: All internet users.
         * `http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: All authenticated {{ yandex-cloud }} users.

     Instead of `grant`, you can specify `acl`, i.e., the [predefined ACL](../../../storage/concepts/acl.md#predefined-acls) of the bucket. The default value is `private`: {{ yandex-cloud }} users get permissions according to their roles in {{ iam-short-name }}.

     For more information about `yandex_storage_bucket` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/storage_bucket).

  1. Apply the configuration:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the resource updates in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/) command:

     ```bash
     yc storage bucket get <bucket_name> --full
     ```

- API {#api}

  To edit a bucket ACL, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) S3 API method.

{% endlist %}
