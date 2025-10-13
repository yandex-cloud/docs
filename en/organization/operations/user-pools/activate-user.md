---
title: How to activate a pool user in {{ org-full-name }}
description: Follow this guide to activate a user in an {{ org-name }} pool.
---

# Activating a user


{% include [note-preview](../../../_includes/note-preview.md) %}

Activated users will gain access to the organization resources.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. In the **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** tab, select the user.
  1. In the top-right corner, click **Make active**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to activate a [pool](../../concepts/user-pools.md) user:

     ```bash
     yc organization-manager idp user reactivate --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp user reactivate <user_ID>
     ```
     
{% endlist %}

#### See also {#see-also}

* [{#T}](deactivate-user.md)