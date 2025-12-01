---
title: How to activate a user in {{ org-full-name }}
description: Follow this guide to activate a user in {{ org-name }}.
---

# Activating a user

You can activate previously [deactivated](./deactivate-user.md) users. After activation, users regain access to the organization resources they have [access permissions](../../../iam/concepts/access-control/roles.md) for.

{% include [activate-deactivate-passport-user-notice](../../../_includes/organization/activate-deactivate-passport-user-notice.md) %}

## Activating a federated user {#activate-federated}

To activate a federated user account:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for activating federated users:

     ```bash
     yc organization-manager federation saml reactivate-user-accounts --help
     ```

  1. Get a list of federations in the organization:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <organization_ID>
     ```

     Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of federations for.

  1. Get a list of deactivated federation users:

     ```bash
     yc organization-manager federation saml list-user-accounts <federation_ID> \
       --organization-id <organization_ID> \
       --filter active=false
     ```

     Where:

     * `<federation_ID>`: ID of the federation you need the list of users for.
     * `--organization-id`: ID of the organization the federation belongs to.
     * `--filter active=false`: Filter to get only deactivated users.

  1. To activate users, provide their IDs in this command:

     ```bash
     yc organization-manager federation saml reactivate-user-accounts <federation_ID> \
       --subject-ids <user_1_ID>,<user_2_ID>,...,<user_N_ID> \
       --organization-id <organization_ID>
     ```

     Where:
     
     * `<federation_ID>`: ID of the federation to activate users in.
     * `--subject-ids`: List of user IDs to activate.
     * `--organization-id`: ID of the organization the federation belongs to.

- API {#api}

  Use the [Federation.Reactivate](../../saml/api-ref/Federation/reactivateUserAccounts.md) REST API method for the [Federation](../../saml/api-ref/Federation/index.md) resource or the [FederationService/Reactivate](../../saml/api-ref/grpc/Federation/reactivateUserAccounts.md) gRPC API call.

{% endlist %}


## Activating a local user {#activate-local}


{% include [note-preview](../../../_includes/note-preview.md) %}

To activate a local user account:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to activate a [pool](../../concepts/user-pools.md) user:

     ```bash
     yc organization-manager idp user reactivate --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. To activate a user, provide their ID in this command:

     ```bash
     yc organization-manager idp user reactivate <user_ID>
     ```

- API {#api}

  Use the [User.Reactivate](../../idp/api-ref/User/reactivate.md) REST API method for the [User](../../idp/api-ref/User/index.md) resource or the [UserService/Reactivate](../../idp/api-ref/grpc/User/reactivate.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](deactivate-user.md)