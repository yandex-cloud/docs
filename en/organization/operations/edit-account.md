---
title: "Deleting a user account in {{ org-full-name }}"
description: "In this tutorial, you will learn how to delete user accounts in {{ org-name }}."
---

# Deleting a user account

{% note info %}

An account can be deleted by users with the `organization-manager.admin` or `organization-manager.organizations.owner` role. For information on assigning roles to users, see [Roles](../security/index.md#admin).

{% endnote %}

1. [Log in]({{link-passport-login}}) to the organization's administrator or owner account.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{link-org-users}}) ![icon-users](../../_assets/organization/icon-users.svg).

1. Select an employee from the list or use the search bar at the top of the page.

1. In the line with the employee name, click ![icon-context-menu](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.remove }}**.
