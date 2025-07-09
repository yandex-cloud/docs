---
title: How to remove a user from a pool in {{ org-full-name }}
description: Follow this guide to remove a user from a pool in {{ org-name }}.
---

# Remove user


{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. Navigate to the **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** tab.
  1. In the row with the user, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **Remove user**
  1. In the window that opens, confirm removing the user from the pool.

{% endlist %}