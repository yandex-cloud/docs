---
title: "Granting encryption key access rights"
description: "Follow this guide to grant encryption key access rights."
---

# Granting encryption key access rights

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the key is stored.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. In the left-hand panel, select ![image](../../_assets/kms/symmetric-key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
   1. Click the name of the key you need.
   1. Go to the ![image](../../_assets/organization/icon-groups.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the window that opens, click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
   1. Select the group, user, or [service account](../../iam/concepts/users/service-accounts.md) to be granted access to the secret.
   1. Click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../security/index.md#roles-list).
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. To assign a role for a key:

      * To a user:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <key_ID> \
            --user-account-id <user_ID> \
            --role <role>
         ```

         Where:
         * `id`: Key ID.
         * `user-account-id`: [User ID](../../iam/operations/users/get.md).
         * `role`: [Role](../security/index.md#roles-list) being assigned.

      * To a [service account](../../iam/concepts/users/service-accounts.md):

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <key_ID> \
            --service-account-id <service_account_ID> \
            --role <role>
         ```

         Where:
         * `id`: Key ID.
         * `service-account-id`: [ID of your service account](../../iam/operations/sa/get-id.md).
         * `role`: [Role](../security/index.md#roles-list) being assigned.

{% endlist %}

{% note warning %}

If you [assign](../../iam/operations/roles/grant.md) a group, user, or service account a role for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) where the key is stored, all permissions of this role will also apply to the key.

For more information, see [How access management works](../../iam/concepts/access-control/#inheritance).

{% endnote %}
