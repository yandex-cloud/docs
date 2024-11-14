---
title: How to set up access to manage a user group in {{ org-full-name }}
description: Follow this guide to set up access to manage a user group in {{ org-name }}.
---

## Configuring group management access {#access-manage-group}

You can grant access to a user group to:

* [Yandex account users](../../iam/concepts/users/accounts.md#passport)
* [Federated users](../../iam/concepts/users/accounts.md#saml-federation)
* [Service accounts](../../iam/concepts/users/service-accounts.md)
* Other [user groups](../../organization/concepts/groups.md)

To do this, assign [roles](../../iam/concepts/access-control/roles.md) for the group. To choose the ones you need, [learn](../security/index.md#roles-list) about the service's roles.

### Assigning a role {#add-access-binding}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-object.md) %}

### Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) with an administrator or organization owner account.

  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** and click the row with the name of the [group](../../organization/concepts/groups.md) you need.
  
  1. Go to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.

  1. Click **{{ ui-key.yacloud_org.entity.group.action_add-acl }}**.
  
  1. Select the user or [service account](../../iam/concepts/users/service-accounts.md) you want to grant access to the group. You may want to use the search feature.
  
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles to assign to the group.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign multiple roles for a user group:

   1. Make sure the resource has no roles assigned that you would not want to lose:

      ```bash
      yc organization-manager group list-access-bindings \
        --id <group_ID>
      ```

   1. See the description of the CLI role assignment command:

      ```bash
      yc organization-manager group set-access-bindings --help
      ```

   1. Get a list of user groups with their IDs:

      ```bash
      yc organization-manager group list
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning roles to.
   1. Using the `yc organization-manager group set-access-bindings` command, assign the following roles:

      * To a Yandex account user:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <group_ID> \
           --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To a federated user:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <group_ID> \
           --access-binding role=<role>,subject=federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <group_ID> \
           --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <group_ID> \
           --access-binding role=<role>,subject=group:<group_ID>
         ```

      Provide a separate `--access-binding` flag for each role, e.g.:

      ```bash
      yc organization-manager group set-access-bindings \
        --id <group_ID> \
        --access-binding role=<role_1>,service-account-id=<service_account_ID> \
        --access-binding role=<role_2>,service-account-id=<service_account_ID> \
        --access-binding role=<role_2>,service-account-id=<service_account_ID>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

   Use the [setAccessBindings](../api-ref/Group/setAccessBindings.md) method for the [Group](../api-ref/Group/index.md) resource or the [GroupService/SetAccessBindings](../api-ref/grpc/Group/setAccessBindings.md) gRPC API call. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

   * Role in the `accessBindings[].roleId` parameter.
   * ID of the subject getting the roles in the `accessBindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

{% endlist %}

### Revoking a role {#remove-access-binding}

{% include [accessbinding-remove](../../_includes/organization/accessbinding-remove.md) %}