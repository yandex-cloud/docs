---
title: How to grant access to a SAML app in {{ org-full-name }}
description: In this article, you will learn how to set up access to a SAML app in {{ org-full-name }}.
---

# Setting up access for SAML app users in {{ org-full-name }}


To grant access to a [SAML app](../../concepts/applications.md#saml), assign [roles](../../../iam/concepts/access-control/roles.md) to subjects. [Learn](../../security/index.md#roles-list) what roles the service has and assign the required ones.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for assigning roles to SAML app users:

      ```bash
      yc organization-manager idp application saml application set-access-bindings --help
      ```

   1. Get a list of SAML apps and their IDs:

      ```bash
      yc organization-manager idp application saml application list --organization-id <organization_ID>
      ```

      Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of SAML apps for.

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../../../iam/operations/sa/get-id.md), or user group you are assigning roles to.

   1. Using the `yc organization-manager idp application saml application set-access-bindings` command, assign the following roles:
      
      * To a Yandex account user or local user:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To all users of a federation:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,federation-users=<federation_ID>
         ```

      * To all users of an organization:
        
         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,organization-users=<organization_ID>
         ```

      * To a service account:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <app_ID> \
           --access-binding role=<role>,group-members=<group_ID>
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

- API {#api}

  Use the [Application.SetAccessBindings](../../idp/application/saml/api-ref/Application/setAccessBindings.md) REST API method for the [Application](../../idp/application/saml/api-ref/Application/index.md) resource or the [ApplicationService/SetAccessBindings](../../idp/application/saml/api-ref/grpc/Application/setAccessBindings.md) gRPC API call.

{% endlist %}