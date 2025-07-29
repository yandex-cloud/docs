---
title: How to edit a user pool in {{ org-full-name }}
description: Follow this guide to edit a user pool in {{ org-name }}.
---

# Editing a user pool


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. In the line with the [user pool](../../../organization/concepts/user-pools.md), click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **Edit**.
  1. Enter a new name or description for the user pool.

      The name must be unique within the organization and satisfy the relevant requirements:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. Specify a new [domain](../../concepts/domains.md) to use if there are no other domains associated with the pool.
  1. Add or delete labels.
  1. Click **{{ ui-key.yacloud_org.actions.save-changes }}**.

{% endlist %}