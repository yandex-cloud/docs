---
title: How to grant access to an OIDC app in {{ org-full-name }}
description: In this article, you will learn how to set up access to an OIDC app in {{ org-name }}.
---

# Setting up access for OIDC app users in {{ org-full-name }}

To grant access to an [OIDC app](../../concepts/applications.md#oidc), assign [roles](../../../iam/concepts/access-control/roles.md) to subjects. [Learn](../../security/index.md#roles-list) what roles the service has and assign the required ones.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for assigning roles to OIDC app users:

      ```bash
      yc organization-manager idp application oauth application set-access-bindings --help
      ```

   1. Get a list of OIDC apps and their IDs:

      ```bash
      yc organization-manager idp application oauth application list --organization-id <organization_ID>
      ```

      Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of OIDC apps for.

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../../../iam/operations/sa/get-id.md), or user group you are assigning roles to.

   1. Using the `yc organization-manager idp application oauth application set-access-bindings` command, assign the following roles:
      
      * To a Yandex account user:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To a federated user:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,subject=federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,subject=group:<group_ID>
         ```

      * To all authenticated users (the `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md)):

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,all-authenticated-users
         ```

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc organization-manager idp application oauth application set-access-bindings \
        --id <app_ID> \
        --access-binding role=<role1>,service-account-id=<service_account_ID> \
        --access-binding role=<role2>,service-account-id=<service_account_ID> \
        --access-binding role=<role3>,service-account-id=<service_account_ID>
      ```

{% endlist %}