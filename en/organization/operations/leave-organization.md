---
title: How to leave an organization in {{ org-full-name }}
description: Follow this guide to leave an organization.
---

# Leaving an organization

If you are not a federated user, you can leave an organization on your own. To do this:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. If you are a member of several organizations, [select](./manage-organizations.md#switch-to-another-org) the proper one.

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. Select a user from the list or use the search bar or filter at the top of the page.

  1. In the row with the user, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select ![PersonXmark](../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.entity.user.action.remove }}**.

  1. In the window that opens, confirm excluding yourself from the organization.

{% endlist %}

Please note: You will lose access to all clouds and other resources of the organization. To avoid this, you can [move](../../resource-manager/operations/cloud/change-organization.md) the cloud to another organization. To do this, you need the `{{ roles-cloud-owner }}` [role](../security/index.md#organization-manager-organizations-owner) for the cloud being transferred and the `{{ roles-organization-owner }}` [role](../../resource-manager/security/index.md#resource-manager-clouds-owner) for the organization to transfer the cloud to.

To disable access to the clouds of the organization you are not going to leave, contact the appropriate cloud administrator.

If you have issues excluding a user from an organization, contact [support]({{ link-console-support }}).