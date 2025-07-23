---
title: Deleting a user account in {{ org-full-name }}
description: In this tutorial, you will learn how to delete a user account in {{ org-name }}.
---

# Deleting a user account

To delete a user account, [remove](#remove-user) or [delete](#delete-user) the user from the organization. Users with a [Yandex account](../../iam/concepts/users/accounts.md#passport) can only be removed. A [federated user](../../iam/concepts/users/accounts.md#saml-federation) can be removed or deleted from an organization.

{% note info %}

Only users with the `organization-manager.admin` or `organization-manager.organizations.owner` role can delete or remove an account. To learn how to grant a role to a user, see the [Roles](../security/index.md#add-role) section.

{% endnote %}

You cannot undo removing or deleting a user from an organization. To restore a user, [add](add-account.md) them to the organization again.

## Removing a user from an organization {#remove-user}

Once removed, a user with a Yandex account will lose access to all the organization's resources and will not be able to log in. Removing a federated user also revokes all their rights in the organization; however, they will remain in the federation, be able to log in to the organization, and still count towards the subject [quota](../concepts/limits.md). To prevent a removed federated user from logging in to the organization, delete or block them in your IdP.

To remove a user from an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Navigate to [{{ org-full-name }}]({{ link-org-cloud-center }}) and log in using an administrator or organization owner account.

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. Select a user from the list or use the search bar or filter at the top of the page.

  1. In the row with the user, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select ![PersonXmark](../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud.common.delete }}**.

  1. In the window that opens, confirm user removal from the organization.

{% endlist %}

## Deleting a user from an organization {#delete-user}

Only federated users can be deleted from an organization. Once you delete a federated user from the organization, they will also be deleted from the federation and free up the quota. If you enabled your federation to automatically create users, a deleted user can log in to the [organization](../concepts/organization.md) and again [become its member](../concepts/membership.md). To prevent this, delete or block the user in your IdP.

To delete a user from your organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Navigate to [{{ org-full-name }}]({{ link-org-cloud-center }}) and log in using an administrator or organization owner account.

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. Select a user from the list or use the search bar or filter at the top of the page.

  1. In the row with the user, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select ![TrashBin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.entity.user.action.delete }}**.

  1. In the window that opens, confirm user deletion from the organization.

{% endlist %}
