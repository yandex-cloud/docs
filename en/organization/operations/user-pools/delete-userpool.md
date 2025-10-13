---
title: How to delete a user pool in {{ org-full-name }}
description: Follow this guide to delete a user pool in {{ org-name }}.
---

# Deleting a user pool


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. In the [user pool](../../concepts/user-pools.md) row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm deleting the user pool.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for deleting a [user pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool delete --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp userpool delete <pool_ID>
     ```

{% endlist %}