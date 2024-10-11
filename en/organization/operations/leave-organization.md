---
title: How to leave an organization in {{ org-full-name }}
description: Follow this guide to leave an organization.
---

# Leaving an organization

If you are not a federated user, you can leave an organization on your own. To do this:

1. Go to [{{ org-full-name }}]({{link-org-main}}).

1. If you belong to multiple organizations, click the user profile image in the bottom left corner and select the appropriate organization.

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}).

1. In the employee's line, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.remove }}**.

Please note: You will lose access to all clouds and other resources of the organization. To avoid this, you can [move](../../resource-manager/operations/cloud/change-organization.md) the cloud to another organization. To do this, you need the `{{ roles-cloud-owner }}` [role](../security/index.md#organization-manager-organizations-owner) for the cloud being transferred and the `{{ roles-organization-owner }}` [role](../../resource-manager/security/index.md#resource-manager-clouds-owner) for the organization to transfer the cloud to.

To disable access to the clouds of the organization you are not going to leave, contact the appropriate cloud administrator.

If you have issues excluding a user from an organization, contact [support]({{ link-console-support }}).