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

{% endlist %}