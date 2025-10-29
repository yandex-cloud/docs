---
title: How to update user data in a {{ org-full-name }} pool
description: Follow this guide to update user data in an {{ org-full-name }} pool.
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
  1. In the row with the user, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![person-pencil](../../../_assets/console-icons/person-pencil.svg) **{{ ui-key.yacloud_org.page.user.action_edit-user }}**. In the window that opens, do the following:

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

{% endlist %}