---
title: Configuring access permissions for a {{ objstorage-full-name }} bucket using {{ iam-name }}
description: Follow this guide to assign a role for a bucket.
---

# Configuring access permissions for a bucket using {{ iam-name }}

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

To configure access to a [bucket](../../concepts/bucket.md) using [{{ iam-name }}](../../security/index.md), assign a user, user group, or service account a [role](../../security/index.md#roles-list) for that bucket:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services.
  1. Click the name of the bucket you want to grant access to.
  1. In the left-hand menu, select **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Select a user from the list or use the user search option.
  1. Click **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Select a role for the user.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

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
      * `role`: [Role](../../security/index.md#roles-list) being assigned.

        {% include [tf-iam-binding-warning](../../../_includes/storage/tf-iam-binding-warning.md) %}

      * `members`: Types and IDs of [entities](../../../iam/concepts/access-control/index.md#subject) assigned the role. Use the following format: `type:<ID>`, e.g., `userAccount:<user_ID>` or `serviceAccount:<service_account_ID`.

      For more information about `yandex_storage_bucket_iam_binding` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket_iam_binding).

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

{% endlist %}

You can also [assign](../../../iam/operations/roles/grant.md) a role for a bucket in {{ iam-name }}.
