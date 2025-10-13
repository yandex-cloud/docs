---
title: How to update user data in a {{ org-full-name }} pool
description: Follow this guide to update user data in an {{ org-name }} pool.
---

# Updating user data


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. Navigate to the **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** tab.
  1. In the user row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.organization.userpools.action_update-user }}**.
  1. Edit the username, [domain](../../concepts/domains.md), and full name.
  1. Add or update the email address.
  1. Delete the user image or upload a new one.
  1. Update the user's full name and phone number under **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating user data in the [pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user update --help
     ```

  1. Run this command:

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