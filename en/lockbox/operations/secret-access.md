---
title: Configuring access to a secret
description: Follow this guide to configure access to a secret.
---

# Configuring access to a secret

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click the name of the secret you need.
   1. On the left-hand panel, select ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the window that opens, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
   1. Select the group, user, or [service account](../../iam/concepts/users/service-accounts.md) to be granted access to the secret.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../security/index.md#roles-list).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. {% include [get-secret-id](../../_includes/lockbox/get-secret-id.md) %}

   1. To assign a role for a secret:

      * To a user:

         ```bash
         yc lockbox secret add-access-binding \
           --id <secret_ID> \
           --user-account-id <user_ID> \
           --role <role>
         ```

         Where:
         * `--id`: Secret ID.
         * `--user-account-id`: [User ID](../../iam/operations/users/get.md).
         * `--role`: [Role](../security/index.md#roles-list) being assigned.

      * To a [service account](../../iam/concepts/users/service-accounts.md):

         ```bash
         yc lockbox secret add-access-binding \
           --id <secret_ID> \
           --service-account-id <service_account_ID> \
           --role <role>
         ```

         Where:
         * `--id`: Secret ID.
         * `--service-account-id`: [Service account ID](../../iam/operations/sa/get-id.md).
         * `--role`: [Role](../security/index.md#roles-list) being assigned.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the properties of access to the secret:

      ```hcl
      resource "yandex_lockbox_secret_iam_binding" "secret-viewer" {
        secret_id = "<secret_ID>"
        role      = "<role>"

        members = [
          "serviceAccount:<service_account_1_ID>",
          "serviceAccount:<service_account_2_ID>"
        ]
      }
      ```

      Where:

      * `secret_id`: Secret ID.
      * `role`: [Role](../security/index.md#roles-list) being assigned.
      * `members`: IDs of [users](../../iam/operations/users/get), groups, or [service accounts](../../iam/operations/sa/get-id.md) to be assigned the role.

      For more information about the `yandex_lockbox_secret_iam_binding` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lockbox_secret_iam_binding).

   1. Create resources

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc lockbox secret list-access-binding <secret_ID>
      ```

- API {#api}

   To configure access to a secret, use the [setAccessBindings](../api-ref/Secret/setAccessBindings.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/SetAccessBindings](../api-ref/grpc/Secret/setAccessBindings.md) gRPC API call.

{% endlist %}

{% note warning %}

If you [assign](../../iam/operations/roles/grant.md) a group, user, or service account a role for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) where the secret is stored, all permissions of this role will also apply to the secret.

For more information, see [How access management works](../../iam/concepts/access-control/#inheritance).

{% endnote %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
