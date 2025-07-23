---
title: How to add a domain to a {{ org-full-name }} user pool
description: Follow this guide to add a domain to an {{ org-name }} user pool.
---

# Adding a domain


{% include [note-preview](../../../_includes/note-preview.md) %}

To add a [domain](../../concepts/domains.md), you must be its owner and have the credentials to modify DNS records in the domain name registrar's system.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. In the top-right corner, click **{{ ui-key.yacloud_org.organization.userpools.action.add_domain }}**.
  1. Enter the domain name. The domain must not be linked to another user pool or [federation](../../concepts/add-federation.md).
  1. Click **{{ ui-key.yacloud.common.add }}**.

  To use the domain for adding new users, [verify](validate-domain.md) it.

{% endlist %}

