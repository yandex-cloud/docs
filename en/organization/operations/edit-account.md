---
title: "Deleting a user account in {{ org-full-name }}"
description: "In this tutorial, you will learn how to delete user accounts in {{ org-name }}."
---

# Deleting a user account

{% note info %}

An account can be deleted by users with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant roles to a user, see [Roles](../security/index.md#admin).

{% endnote %}

1. [Log in]({{link-passport-login}}) as the organization administrator or owner.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{link-org-users}}) ![icon-users](../../_assets/console-icons/person.svg).

1. Select an employee from the list or use the search bar at the top of the page.

1. In the line with the employee name, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.remove }}**.
