---
title: How to deactivate a user in a {{ org-full-name }} pool
description: Follow this guide to deactivate a user in a {{ org-name }} pool.
---

# Deactivating a user


{% include [note-preview](../../../_includes/note-preview.md) %}

Deactivation will terminate all the user's sessions, and the user will lose access to the organization's resources until reactivated.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. In the **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** tab, select the user.
  1. In the top-right corner, click **Make inactive**.

{% endlist %}

#### See also {#see-also}

* [{#T}](activate-user.md)