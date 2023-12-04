---
title: "Deleting an organization in {{ org-full-name }}"
description: "In this tutorial, you will learn how to delete an organization in {{ org-name }}."
---

# Deleting an organization

{% note info %}

An organization can be deleted by users with the `organization-manager.admin` or `organization-manager.organizations.owner` role. For information on assigning roles to users, see [Roles](../security/index.md#admin).

{% endnote %}

To delete an organization:

1. Log in to [{{org-full-name}}]({{link-org-main}}) as the organization administrator or owner.

1. In the bottom-left corner, click the profile photo and select the organization to delete.

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.settings }}]({{link-org-settings}}) ![icon-settings](../../_assets/organization/icon-settings.svg).

1. In the top-right corner, click ![image](../../_assets/basket.svg) **{{ ui-key.yacloud.common.delete }}**.

1. Specify when you want the organization to be deleted. Select one of the suggested periods or `Delete now`. The default organization deletion delay is 7 days.

1. Click **{{ ui-key.yacloud.common.delete }}**.
