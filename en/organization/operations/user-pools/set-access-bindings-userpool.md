---
title: How to assign permissions to a user pool in {{ org-full-name }}
description: In this article, you will learn how to set up access for a user pool in {{ org-full-name }}.
---

# Setting up access for pool users


To grant access to a [pool](../../concepts/user-pools.md), assign [roles](../../../iam/concepts/access-control/roles.md) to subjects. [Learn](../../security/index.md#roles-list) what roles the service has and assign the required ones.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select a user pool.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.userpools.UserpoolPageLayout.title_userpool_acl_5rdMM }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. In the window that opens, select the group, user, or service account you need to grant access to the user pool.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select a role. Add other roles as needed.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for assigning roles to [pool](../../concepts/user-pools.md) users:

      ```bash
      yc organization-manager idp userpool set-access-bindings --help
      ```

   1. Get the list of user pools and their IDs:

      ```bash
      yc organization-manager idp userpool list --organization-id <organization_ID>
      ```

      Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of user pools for.

   1. Get the [ID of the user](../../../organization/operations/users-get.md), [service account](../../../iam/operations/sa/get-id.md), or user group you are assigning roles to.
   1. Using the `yc organization-manager idp userpool set-access-bindings` command, assign the following roles:
      
      * To a Yandex account user or local user:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <pool_ID> \
           --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To a federated user:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <pool_ID> \
           --access-binding role=<role>,subject=federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <pool_ID> \
           --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <pool_ID> \
           --access-binding role=<role>,subject=group:<group_ID>
         ```

      * To all authenticated users (the `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md)):

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <pool_ID> \
           --access-binding role=<role>,all-authenticated-users
         ```

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc organization-manager idp userpool set-access-bindings \
        --id <pool_ID> \
        --access-binding role=<role_1>,service-account-id=<service_account_ID> \
        --access-binding role=<role_2>,service-account-id=<service_account_ID> \
        --access-binding role=<role_3>,service-account-id=<service_account_ID>
      ```

- API {#api}

  Use the [Userpool.SetAccessBindings](../../idp/api-ref/Userpool/setAccessBindings.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/SetAccessBindings](../../idp/api-ref/grpc/Userpool/setAccessBindings.md) gRPC API call.

{% endlist %}
