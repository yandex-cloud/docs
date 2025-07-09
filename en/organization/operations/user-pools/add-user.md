---
title: How to add a user to a {{ org-full-name }} pool
description: Follow this guide to add a user to an {{ org-name }} pool.
---

# Adding a user


{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../../organization/concepts/user-pools.md).  
  1. In the **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** tab, click **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.
  1. Enter the user login and select the [domain](../../concepts/domains.md) from the list. If the domain is not on the list, [add a new one](add-domain.md).
  1. Specify the user's **{{ ui-key.yacloud_org.organization.userpools.field_full-name }}**.  
  1. Optionally, add the user’s email address.
  1. Enter the **{{ ui-key.yacloud_org.organization.userpools.field_password }}** for login or generate a new one. You must change the password after the first login.

     The password may only contain Latin letters, numbers, or the following symbols: `,`, `_`, `.`, `-`.

  1. Optionally, you can add a user profile picture.
  1. Enable the **Active account** option if you need to activate the user as soon as you add them. Activated users gain access to the organization resources.
  1. Optionally, specify the user's first name, last name, and phone number under **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}**.
  1. Click **Add user**.

{% endlist %}