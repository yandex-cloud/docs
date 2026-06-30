---
title: Configuring access permissions for a {{ objstorage-full-name }} bucket using {{ iam-name }}
description: Follow this guide to assign a role for a bucket.
---

# Configuring access permissions for a bucket using {{ iam-name }}

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

To configure access to a [bucket](../../concepts/bucket.md) using [{{ iam-name }}](../../security/index.md), assign a user, user group, or service account a [role](../../security/index.md#roles-list) for that bucket:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the bucket you want to grant access to.
  1. In the left-hand menu, select **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Select a user from the list or use the user search option.
  1. Click **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Select a role for the user.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating bucket settings:

      ```bash
      yc storage bucket update --help
      ```

  1. Assign a role for the bucket:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --grants grantee-id=<account_ID>,grant-type=<subject_type>,permission=<permission>
      ```

      Where: 
      * `--name`: Bucket name.
      * `--grants`: [ACL](../../concepts/acl.md) access permission settings:
        * `grantee-id`: ID of the account the permissions are granted to. Used when the value is `grant-type=grant-type-account`.
        * `grant-type`: Type of entity the permissions are granted to. The possible values are:
          * `grant-type-account`: User or service account.
          * `grant-type-all-authenticated-users`: All authenticated users.
          * `grant-type-all-users`: All users.
        * `permission`: Permission. The possible values are:
          * `permission-full-control`: Full access to the bucket and objects in it.
          * `permission-write`: Writing objects to the bucket.
          * `permission-write-acp`: Editing bucket ACL.
          * `permission-read`: Reading objects in the bucket.
          * `permission-read-acp`: Reading bucket ACL.
  
  If the `yc storage bucket update` command is called, the bucket's assigned ACL roles are overwritten, not appended. To preserve existing permissions settings, they must be re-listed in the `--grants` parameter.

  Learn more about the `yc storage bucket update` command in the [YC CLI reference](../../cli-ref/bucket/update.md).
  
  ## Example {#example}

  To assign a service account full access to a bucket using the CLI:

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```
 
      Result:
 
      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Get a list of service accounts in the default folder:

      ```bash
      yc iam service-account list
      ```
 
      Result:
 
      ```text
      +----------------------+--------------+--------+---------------------+-----------------------+
      |          ID          |     NAME     | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
      +----------------------+--------------+--------+---------------------+-----------------------+
      | ajeg2b2et02f******** | my-robot     |        | 2024-09-08 18:59:45 | 2025-02-18 10:10:00   |
      | ajegtlf2q28a******** | account-name |        | 2023-06-27 16:18:18 | 2025-02-18 10:20:00   |
      +----------------------+--------------+--------+---------------------+-----------------------+
      ```

  1. Assign a role for the bucket:

      ```bash
      yc storage bucket update \
        --name my-bucket \
        --grants grantee-id=ajeg2b2et02f********,grant-type=grant-type-account,permission=permission-full-control
      ```

  Result:
      
  ```text
  name: my-bucket
  folder_id: b1g0ijbfaqsn********
  default_storage_class: STANDARD
  versioning: VERSIONING_DISABLED
  max_size: "53687091200"
  acl:
    grants:
      - permission: PERMISSION_FULL_CONTROL
        grant_type: GRANT_TYPE_ACCOUNT
        grantee_id: ajeg2b2et02f********
  created_at: "2026-04-30T09:48:38.836171Z"
  resource_id: e3ev6mif5rb1********
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign a role for a bucket using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_storage_bucket_iam_binding" "mybucket-viewers" {
        bucket  = "<bucket_name>"
        role    = "<role>"
        members = [
                    "<subject_type>:<subject_ID>",
                    "serviceAccount:<service_account_ID>",
                    "userAccount:<user_ID>"
                  ]
      }

      # Example of assigning the `storage.editor` role to service accounts
      resource "yandex_storage_bucket_iam_binding" "sa-editors" {
        bucket  = "<bucket_name>"
        role    = "storage.editor"
        members = [
                    "serviceAccount:<service_account_1_ID>",
                    "serviceAccount:<service_account_2_ID>"
                  ]
      }

      # Example of assigning the `storage.admin` role to users 
      resource "yandex_storage_bucket_iam_binding" "users-admins" {
        bucket  = "<bucket_name>"
        role    = "storage.admin"
        members = [
                    "userAccount:<user_1_ID>",
                    "userAccount:<user_2_ID>"
                  ]
      }
      ```

      Where:

      * `bucket`: Bucket name.
      * `role`: [Role](../../security/index.md#roles-list) to assign.

        {% include [tf-iam-binding-warning](../../../_includes/storage/tf-iam-binding-warning.md) %}

      * `members`: Types and IDs of [entities](../../../iam/concepts/access-control/index.md#subject) getting the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_storage_bucket_iam_binding` resource properties, see [this provider guide]({{ tf-provider-resources-link }}/storage_bucket_iam_binding).

  1. If you intend to use the [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) resource together with [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) for the same bucket, we recommend creating them sequentially. To do this, add a dependency on the `yandex_storage_bucket_grant` resource to the `yandex_storage_bucket_iam_binding` section.

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

      You can check the resource update using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [updateAccessBindings](../../../storage/api-ref/Bucket/updateAccessBindings.md) REST API method for the [Bucket](../../../storage/api-ref/Bucket/index.md) resource or the [BucketService/UpdateAccessBindings](../../../storage/api-ref/grpc/Bucket/updateAccessBindings.md) gRPC API call.

{% endlist %}

You can also [assign](../../../iam/operations/roles/grant.md) a role for a bucket in {{ iam-name }}.
