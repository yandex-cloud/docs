---
title: Editing organization data in {{ org-full-name }}
description: In this tutorial, you will learn how to edit organization data in {{ org-name }}.
---

# Editing organization data

{% note info %}

Organization data can be edited by users with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant a role to a user, see the [Roles](../security/index.md#admin) section.

{% endnote %}

To edit your organization data:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}) with an administrator or organization owner account.

      On the {{ cloud-center }} home page that opens, you can view general info about your organization.

      {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

  1. Click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.dashboard.organization.action.edit-button }}** in the organization name section at the center of the screen to edit the name and description of the current organization.

  1. In the window that opens, edit the organization's name, technical name, size, and description.

  1. Click **{{ ui-key.yacloud_org.forms.action.save }}**.

{% endlist %}

{% include [where-change-billing-info](../../_includes/organization/where-change-billing-info.md) %}