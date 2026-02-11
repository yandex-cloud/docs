---
title: How to set or reset a local user password in {{ org-full-name }}
description: Follow this guide to set or reset a local user password in {{ org-full-name }}.
---

# Updating a local user password


## Resetting a password {#reset}

To reset a [local](../../../iam/concepts/users/accounts.md#local) user password, do the following:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and find the local user.

      Optionally, use the search bar or filter at the top of the page.
  1. In the row with the user, click ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) and select ![key](../../../_assets/console-icons/key.svg) **{{ ui-key.yacloud_org.entity.user.action.reset-password_jk19s }}**.
  1. In the window that opens, confirm resetting the password.

      Save the generated password and communicate it to the user. After closing the window, you will not be able to view the new password.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for resetting a user password in a [pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user reset-password --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Run the command, specifying the user ID:

      ```bash
      yc organization-manager idp user reset-password <user_ID>
      ```

      Result:

      ```text
      generated password for user 'ek0gkfu0jc7v********' is 'rhls-mpvg-****-****'
      ```

      Save the generated password and communicate it to the user. After closing the shell, you will not be able to view the new password.

- API {#api}

  Use the [User.GeneratePassword](../../idp/api-ref/User/generatePassword.md) REST API method for the [User](../../idp/api-ref/User/index.md) resource or the [UserService/GeneratePassword](../../idp/api-ref/grpc/User/generatePassword.md) gRPC API call.

{% endlist %}

The user must change this password on their first login to {{ yandex-cloud }}.

## Setting a password {#set}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  You cannot generate a random password for a local user via the {{ cloud-center }} interface. To change the password to a generated one, follow [this guide](#reset).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for changing a user password in a pool:

     ```bash
     yc organization-manager idp user set-password --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Run this command, specifying the user ID and their new password in the `--password` parameter:

      ```bash
      yc organization-manager idp user set-password <user_ID> \
        --password <new_password>
      ```

      {% note info %}

      The new password must comply with the user pool's [password policy](../../concepts/password-policy.md).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the user parameters in the configuration file:

     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id = "<pool_ID>"
       username    = "<username>"
       full_name   = "<full_username>"
       password_spec = {
         password = "<new_password>"
       }
     }
     ```

     Where:

     * `userpool_id`: ID of the [pool](../../concepts/user-pools.md) the user is in.
     * `username`: Username.
     * `full_name`: User’s full name.
     * `password`: New user password.

     {% note info %}

     The new password must comply with the user pool's [password policy](../../concepts/password-policy.md).

     {% endnote %}

     For more information about `yandex_organizationmanager_idp_user` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/organizationmanager_idp_user).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

  Use the [User.SetOwnPassword](../../idp/api-ref/User/setOwnPassword.md) REST API method for the [User](../../idp/api-ref/User/index.md) resource or the [UserService/SetOwnPassword](../../idp/api-ref/grpc/User/setOwnPassword.md) gRPC API call.

{% endlist %}