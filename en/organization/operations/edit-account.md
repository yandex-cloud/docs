---
title: Deleting a user account in {{ org-full-name }}
description: In this tutorial, you will learn how to delete user accounts in {{ org-name }}.
---

# Deleting a user account

To delete a user account, [remove](#remove-user) or [delete](#delete-user) the user from the organization. Users with a [Yandex account](../../iam/concepts/users/accounts.md#passport) can only be removed. A [federated user](../../iam/concepts/users/accounts.md#saml-federation) can be removed or deleted from an organization.

{% note info %}

Only users with the `organization-manager.admin` or `organization-manager.organizations.owner` role can delete or remove an account. To learn how to grant roles to a user, see [Roles](../security/index.md#admin).

{% endnote %}

You cannot undo removing or deleting a user from an organization. To restore a user, you need to [add](add-account.md) them back to the organization.

## Removing a user from an organization {#remove-user}

Once removed, a user with a Yandex account will lose access to all the organization's resources and will not be able to log in. Removing a federated user also revokes all their rights in the organization; however, they will remain in the federation, be able log in to the organization, and still count towards the subject [quota](../concepts/limits.md). To prevent a removed federated user from logging in to the organization, delete or block them in your IdP.

To remove a user from an organization:

1. [Log in]({{link-passport-login}}) as the organization administrator or owner.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{link-org-users}}) ![icon-users](../../_assets/console-icons/person.svg).

1. Select an employee from the list or use the search bar at the top of the page.

1. In the line with the employee name, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.remove }}**.

## Deleting a user from an organization {#delete-user}

Only federated users can be deleted from an organization. Once you delete a federated user from the organization, they will also be deleted from the federation and free up the quota. If you enabled your federation to automatically create users, a deleted user can log in to the organization and again [become its member](../concepts/membership.md). To prevent this, delete or block the user in your IdP.

To delete a user from your organization:

1. [Log in]({{link-passport-login}}) as the organization administrator or owner.

1. Go to [{{ org-full-name }}]({{link-org-main}}).

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{link-org-users}}) ![icon-users](../../_assets/console-icons/person.svg).

1. Select an employee from the list or use the search bar at the top of the page.

1. In the line with the employee name, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.delete }}**.
