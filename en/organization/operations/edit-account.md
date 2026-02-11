---
title: Deleting an account from a {{ org-full-name }} organization
description: In this tutorial, you will learn how to delete a user account from a {{ org-full-name }} organization.
---

# Deleting a user account

An account can be deleted from an organization by a user with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant a role to a user, see [{#T}](../security/index.md#add-role).

{% note tip %}

The deletion of a user account from an [organization](../concepts/organization.md) cannot be reversed. To restore a previously deleted user, [add](add-account.md) them to the organization again.

{% endnote %}

## Deleting a Yandex account user or federated user {#yandex-and-federated} 

To delete a [Yandex account](../../iam/concepts/users/accounts.md#passport) user or [federated](../../iam/concepts/users/accounts.md#saml-federation) user from an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

{% endlist %}

{% note info %}

Once you delete a [federated user](../../iam/concepts/users/accounts.md#saml-federation) from the organization, the user gets deleted from the federation and releases used up quotas. If your federation is set up to automatically create users, a deleted user can log in to the [organization](../concepts/organization.md) and [become its member](../concepts/membership.md) again. To prevent this, delete or block the user in your IdP.

{% endnote %}

## Deleting a local user {#local}

To delete a [local](../../iam/concepts/users/accounts.md#local) user from an organization:


{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for removing a user from a [pool](../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user delete --help
     ```
  1. {% include [cli-list-userpools](../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../_includes/organization/cli-userpool-list-users.md) %}
  1. To delete a local user from an organization, provide their ID in this command:

     ```bash
     yc organization-manager idp user delete <user_ID>
     ```

{% endlist %}