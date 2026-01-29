---
title: How to update user data in a {{ org-full-name }} pool
description: Follow this guide to update user data in a {{ org-full-name }} pool.
---

# Updating user data


{% include [note-preview](../../../_includes/note-preview.md) %}

You can only update user data for [local](../../../iam/concepts/users/accounts.md#local) users.

To update local user data:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and find the local user in the list that opens.

     Optionally, use the search bar and filters at the top of the screen.
  1. In the row with the user, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![person-pencil](../../../_assets/console-icons/person-pencil.svg) **{{ ui-key.yacloud_org.page.user.action_edit-user }}**. In the window that opens:

      1. Update the username, [domain](../../concepts/domains.md), and full name.
      1. Add or update the email address.
      1. Expand the **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** section and update the user's first name, last name, and phone number.
      1. Click **{{ ui-key.yacloud_org.organization.userpools.action_update-user }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating user data in the [pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user update --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. To update the user, provide their ID and other parameters in this command:

     ```bash
     yc organization-manager idp user update <user_ID> \
       --username <user_login_and_domain> \
       --full-name <user_first_and_last_name> \
       --given-name <username> \
       --family-name <user_last_name> \
       --email <user_email> \
       --phone-number <user_phone_number>
     ```

     Where:     

     * `--username`: New user login and domain in `login@domain` format. The login must be unique for the current user pool.
     * `--full-name`: New user first and last name.
     * `--given-name`: New user name.
     * `--family-name`: New user last name.
     * `--email`: New user email address.
     * `--phone-number`: New user phone number.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update user data in the [pool](../../concepts/user-pools.md):

  1. Open the {{ TF }} configuration file and update the user parameters:

     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id  = <pool_ID>
       username     = "<user_login_and_domain>"
       full_name    = "<user_first_and_last_name>"
       given_name   = "<username>"
       family_name  = "<user_last_name>"
       email        = "<user_email>"
       phone_number = "<user_phone_number>"
     }
     ```

     Where:

     * `username`: New user login and domain in `login@domain` format. The login must be unique within the current [user pool](../../concepts/user-pools.md).
     * `full_name`: User’s new first and last name.
     * `given_name`: New user name.
     * `family_name`: New user last name.
     * `email`: New user email address.
     * `phone_number`: New user phone number.

     For more information about `yandex_organizationmanager_idp_user` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/organizationmanager_idp_user).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will update all the required resources. You can check the changes in [{{ org-full-name }}]({{ link-org-cloud-center }}) or using the [CLI](../../../cli/):

     ```bash
     yc organization-manager idp user get <user_ID>
     ```

- API {#api}

  Use the [User.Update](../../idp/api-ref/User/update.md) REST API method for the [User](../../idp/api-ref/User/index.md) resource or the [UserService/Update](../../idp/api-ref/grpc/User/update.md) gRPC API call.

{% endlist %}