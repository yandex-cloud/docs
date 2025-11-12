---
title: How to set or reset a local user password in {{ org-full-name }}
description: Follow this guide to set or reset a local user password in {{ org-full-name }}.
---

# Updating a local user password


{% include [note-preview](../../../_includes/note-preview.md) %}

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

      The user password may include Latin letters, numbers, and special characters.
      
      It must be at least seven characters long and must contain at least one uppercase Latin letter, one lowercase Latin letter, one number, and one special character. 

      {% endnote %}

{% endlist %}