---
title: How to deactivate a user in {{ org-full-name }}
description: Follow this guide to deactivate a user in {{ org-name }}.
---

# Deactivating a user

To suspend a user’s access to organization resources, you can deactivate the user. Deactivation will terminate all the user's sessions, and the user will lose access to the organization's resources until [reactivated](activate-user.md).

{% include [activate-deactivate-passport-user-notice](../../../_includes/organization/activate-deactivate-passport-user-notice.md) %}

## Deactivating a federated user {#deactivate-federated}

To deactivate a federated user account:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [deactivate-user-ui](../../../_includes/organization/deactivate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deactivating federated users:

     ```bash
     yc organization-manager federation saml suspend-user-accounts --help
     ```

  1. Get a list of federations in the organization:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <organization_ID>
     ```

     Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of federations for.

  1. Get a list of active federation users:

     ```bash
     yc organization-manager federation saml list-user-accounts <federation_ID> \
       --organization-id <organization_ID> \
       --filter active=true
     ```

     Where:

     * `<federation_ID>`: ID of the federation you need the list of users for.
     * `--organization-id`: ID of the organization the federation belongs to.
     * `--filter active=false`: Only active users filter.

  1. To deactivate users, provide their IDs in this command:

     ```bash
     yc organization-manager federation saml suspend-user-accounts <federation_ID> \
       --subject-ids <user_1_ID>,<user_2_ID>,...,<user_N_ID> \
       --organization-id <organization_ID> \
       --reason <reason_for_deactivation>
     ```

     Where:
     
     * `<federation_ID>`: ID of the federation to deactivate users in.
     * `--subject-ids`: List of user IDs for deactivation.
     * `--organization-id`: ID of the organization the federation belongs to.
     * `--reason`: Reason for deactivation. This is an optional parameter.

{% endlist %}

## Deactivating a local user {#deactivate-local}


{% include [note-preview](../../../_includes/note-preview.md) %}

To deactivate a local user account:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [deactivate-user-ui](../../../_includes/organization/deactivate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to deactivate a [pool](../../concepts/user-pools.md) user:

     ```bash
     yc organization-manager idp user suspend --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. To deactivate a user, provide their ID in this command:

     ```bash
     yc organization-manager idp user suspend <user_ID> \
       --reason <reason_for_deactivation>
     ```

     Where `--reason` is the reason for deactivation. This is an optional parameter.

{% endlist %}

#### See also {#see-also}

* [{#T}](activate-user.md)