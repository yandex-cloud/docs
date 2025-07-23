---
title: How to delete a domain in a {{ org-full-name }} user pool
description: Follow this guide to delete a domain in an {{ org-name }} user pool.
---

# Deleting a domain


{% include [note-preview](../../../_includes/note-preview.md) %}

You cannot delete the default [domain](../../concepts/domains.md) or a domain with associated users.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. Under **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the domain and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.organization.userpool.action_delete-domain }}**.
  1. In the window that opens, confirm deleting the domain.

{% endlist %}