---
title: Deleting an organization in {{ org-full-name }}
description: In this tutorial, you will learn how to delete an organization in {{ org-name }}.
---

# Deleting an organization

{% note info %}

An organization can be deleted by users with the `organization-manager.admin` or `organization-manager.organizations.owner` role. For information on assigning roles to users, see [Roles](../security/index.md#admin).

Before deleting an organization, make sure to delete all its [clouds](../../resource-manager/operations/cloud/delete.md) and the [billing account](../../billing/operations/delete-account.md) linked to it.

{% endnote %}

To delete an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}) with an administrator or organization owner account.

      The {{ cloud-center }} home page that opens displays the basic information about your organization.

      If you have more than one organization, you can [switch](./manage-organizations.md#switch-to-another-org) to the one you need. To do this, click ![chevron-down](../../_assets/console-icons/chevron-down.svg) next to the name of the current organization in the top-left corner of the screen and select another one. This will switch you to a different organization.
  
  1. To delete your current organization, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.dashboard.organization.action.delete-button }}** in the box with its name in the center of the screen.

  1. In the window that opens, specify when you want the organization to be deleted. Select one of the suggested periods or `Delete now`. The default organization deletion delay is seven days.

  1. Click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

After deleting an organization, you will no longer be able to use the {{ yandex-cloud }} resources created in that organization.

If you have any issues, please contact [support]({{ link-console-support }}).