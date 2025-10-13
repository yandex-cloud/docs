---
title: How to get pool user info in {{ org-full-name }}
description: Follow this guide to get pool user info in {{ org-name }}.
---

# Getting pool user info


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. Select the pool from the [user pool](../../concepts/user-pools.md) list.
  1. Navigate to the **Participants** tab and select the user of interest.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting [pool user](../../concepts/user-pools.md) info:

     ```bash
     yc organization-manager idp user get --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager idp user get <user_ID>
      ```

{% endlist %}