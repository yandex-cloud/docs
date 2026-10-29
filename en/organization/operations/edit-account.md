---
title: Deleting an account from a {{ org-full-name }} organization
description: In this tutorial, you will learn how to delete a user account from a {{ org-full-name }} organization.
---

# Deleting a user account

An account can be deleted from an organization by a user with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant a role to a user, see [{#T}](../security/index.md#add-role).

{% note tip %}

The deletion of a user account from an [organization](../concepts/organization.md) cannot be reversed. To restore a previously deleted user, [add](add-account.md) them to the organization again.

{% endnote %}

## Deleting a user with a Yandex account {#yandex-and-federated}

To delete a [Yandex account](../../iam/concepts/users/accounts.md#passport) user from an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the command description:

      ```bash
      yc organization-manager user remove --help
      ```

  1. Delete the user's membership in the organization:

      ```bash
      yc organization-manager user remove \
        --organization-id <organization_ID> \
        --subject-id <user_ID>
      ```

      Specify the [organization ID](organization-get-id.md) and [user ID](users-get.md). Both parameters are required for this example.

- API {#api}

    Use the [deleteMembership](../api-ref/User/deleteMembership.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/DeleteMembership](../api-ref/grpc/User/deleteMembership.md) gRPC API call.

{% endlist %}

## Deleting a federated user {#federated}

To delete a [federated user](../../iam/concepts/users/accounts.md#saml-federation) from the organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the command description:

      ```bash
      yc organization-manager user remove --help
      ```

  1. Delete the user's membership in the organization:

      ```bash
      yc organization-manager user remove \
        --organization-id <organization_ID> \
        --subject-id <user_ID>
      ```

      Specify the [organization ID](organization-get-id.md) and [user ID](users-get.md). Both parameters are required for this example.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In a configuration that controls the federated user, delete that user's `yandex_organizationmanager_saml_federation_user_account` section and links to it. This deletes the user's membership in the organization but not their account with the identity provider.

     For more information on the `yandex_organizationmanager_saml_federation_user_account` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account).

  1. Apply the changes after reviewing the list of resources you want to delete in the plan:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Use the [deleteMembership](../api-ref/User/deleteMembership.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/DeleteMembership](../api-ref/grpc/User/deleteMembership.md) gRPC API call.

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In a configuration that controls the local user, delete that user's `yandex_organizationmanager_idp_user` section and links to it. This deletes the user from the pool, not just their membership in the organization.
  1. Apply the changes after reviewing the list of resources you want to delete in the plan:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Use the [delete](../idp/api-ref/User/delete.md) REST API method for the [User](../idp/api-ref/User/index.md) resource or the [UserService/Delete](../idp/api-ref/grpc/User/delete.md) gRPC API call.

{% endlist %}