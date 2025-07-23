---
title: How to verify a domain in a {{ org-full-name }} user pool
description: Follow this guide to verify a domain in an {{ org-name }} user pool.
---

# Verifying a domain


{% include [note-preview](../../../_includes/note-preview.md) %}

You can use only verified [domains](../../concepts/domains.md) to add users.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. Select the domain you need to verify.
  1. In the section that opens, you will see the details you will need to pass the domain rights check.
  1. After completing the verification, click **{{ ui-key.yacloud_org.common.confirm }}**.

{% endlist %}