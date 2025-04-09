---
title: Assigning roles
description: Follow this guide to assign a role for a resource.
---

# Assigning roles

To grant access to a resource, assign a [role](../../concepts/access-control/roles.md) for it. You can assign a role to:

* [Yandex account users](../../concepts/users/accounts.md#passport)
* [Federated users](../../concepts/users/accounts.md#saml-federation)
* [Service accounts](../../concepts/users/service-accounts.md)
* [User groups](../../../organization/concepts/groups.md)

You can assign a role not only for the resource itself but also for its parent resource, as the former inherits access permissions from the latter. For example, if a service account gets a role for a cloud, it will also get permissions for all resources across the cloud's folders. To learn more, see [{#T}](../../concepts/access-control/index.md).

[Learn](../../concepts/access-control/resources-with-access-control.md) which resources you can assign a role for.

To select roles, look them up in the [role reference](../../roles-reference.md).

## Assigning a role for a cloud {#cloud-or-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the cloud or folder.
   1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
   1. Select the group, user, or service account you want to grant access to a cloud or folder.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for a cloud or folder:

   1. See the description of the CLI role assignment command:

      ```bash
      yc resource-manager <cloud_or_folder> add-access-binding --help
      ```

      Specify `cloud` for a cloud or `folder` for a folder.

   1. Get a list of available clouds or folders with their IDs:

      ```bash
      yc resource-manager <cloud_or_folder> list
      ```

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.
   1. Use one of these commands to assign a role:

      * To a Yandex account user:

         ```bash
         yc resource-manager <cloud_or_folder> add-access-binding \
            --id <cloud_or_folder_ID> \
            --role <role> \
            --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         yc resource-manager <cloud_or_folder> add-access-binding \
            --id <cloud_or_folder_ID> \
            --role <role> \
            --subject federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc resource-manager <cloud_or_folder> add-access-binding \
            --id <cloud_or_folder_ID> \
            --role <role> \
            --service-account-id <service_account_ID>
         ```

      * To a user group:

         ```bash
         yc resource-manager <cloud_or_folder> add-access-binding \
            --id <cloud_or_folder_ID> \
            --role <role> \
            --subject group:<group_ID>
         ```

      * To all users of an organization:

         ```bash
         yc resource-manager <cloud_or_folder> add-access-binding \
            --id <cloud_or_folder_ID> \
            --role <role> \
            --organization-users <organization_ID>
         ```

      * To all users of an identity federation:

         ```bash
         yc resource-manager <cloud_or_folder> add-access-binding \
            --id <cloud_or_folder_ID> \
            --role <role> \
            --federation-users <federation_ID>
         ```

- API {#api}

   To assign a role for a cloud, use the [updateAccessBindings](../../../resource-manager/api-ref/Cloud/updateAccessBindings.md) REST API method for the [Cloud](../../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Cloud/updateAccessBindings.md) gRPC API call.

   To assign a role for a folder, use the [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

   Provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}

## Assigning a role for an organization {#organization}

To grant access permissions for an organization, you need the `{{ roles-organization-admin }}` role or higher. To learn more about the role sequence, see the [{{ org-full-name }} document](../../../organization/security/index.md#roles-list).

To assign a role for an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![persons-lock](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. If the user, service account, or user group already has at least one role assigned, click ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) in the row with that user, service account, or group and select **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

      If the user, service account, or user group is not on the list, click **{{ ui-key.yacloud_org.entity.user.action.acl }}** in the top-right corner. In the window that opens, select the user, service account, or group from the list. If required, use the search bar.

  1. Click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the [role](../../../iam/concepts/access-control/roles.md) to assign. You can assign multiple roles.

      You can find the description of the available roles in the [{{ yandex-cloud }} role reference](../../../iam/roles-reference.md).

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for an organization:

   1. See the description of the CLI role assignment command:

      ```bash
      yc organization-manager organization add-access-binding --help
      ```

   1. Get a list of available organizations with their IDs:

      ```bash
      yc organization-manager organization list
      ```

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.
   1. Use one of these commands to assign a role:

      * To a Yandex account user:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <organization_ID> \
            --role <role> \
            --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <organization_ID> \
            --role <role> \
            --subject federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <organization_ID> \
            --role <role> \
            --service-account-id <service_account_ID>
         ```

      * To all users of an organization:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <organization_ID> \
            --role <role> \
            --organization-users <organization_ID>
         ```

      * To all users of an identity federation:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <organization_ID> \
            --role <role> \
            --federation-users <federation_ID>
         ```


- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To assign a role for an organization:

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), or user group you are assigning a role to.
   1. Describe the resource with the role for the organization in the configuration file.

      Here is the configuration file example:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "<resource_name>" {
        organization_id = "<organization_ID>"
        role            = "<role>"
        members         = [<users>]
      }
      ```

      Where:

      * `organization_id`: [Organization ID](../../../organization/operations/organization-get-id.md). This is a required parameter.
      * `role`: Role to assign. For each role, you can only use one `yandex_organizationmanager_organization_iam_binding` resource. This is a required parameter.
      * `members`: Users getting the role. Specify the following:

         * `members = ["userAccount:<user_ID>"]`: For a user with a Yandex account.
         * `members = ["federatedUser:<user_ID>"]`: For a federated user.
         * `members = ["serviceAccount:<user_ID>"]`: For a service account.
         * `members = ["group:<user_ID>"]`: For a user group.
         * `members = ["system:group:organization:<organization_ID>:users"]`: For all [organization](../../../organization/quickstart.md) users.
         * `members = ["system:group:federation:<organization_ID>:users"]`: For all [identity federation](../../../organization/concepts/add-federation.md) users.

      For more information, see the [provider documentation]({{ tf-provider-link }}).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Assign the role.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      This will create the necessary resources in the organization. You can check the new resources using the [management console]({{ link-console-main }}) or this CLI command:

      ```bash
      yc organization-manager organization list-access-bindings <organization_name_or_ID>
      ```

- API {#api}

   To assign a role for the organization, use the [updateAccessBindings](../../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UpdateAccessBindings](../../../organization/api-ref/grpc/Organization/updateAccessBindings.md) gRPC API call and provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}

## Assigning a role for a resource {#resource}

You can assign a role not only for an organization, cloud, or folder but their child resources as well. These are listed in [{#T}](../../concepts/access-control/resources-with-access-control.md).

{% list tabs group=instructions %}

- Management console {#console}

   To assign a role for a resource:

   1. In the [management console]({{ link-console-main }}), select the folder the resource resides in.
   1. Open its page.
   1. Go to ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to a resource.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for a resource:

   1. See the description of the CLI role assignment command:

      ```bash
      yc <service_name> <resource> add-access-binding --help
      ```

      Example for a [{{ compute-full-name }} VM](../../../compute/concepts/vm.md):

      ```bash
      {{ yc-compute-instance }} add-access-binding --help
      ```

   1. Get a list of resources with their IDs:

      ```bash
      yc <service_name> <resource> list
      ```

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.
   1. Use one of these commands to assign a role:

      * To a Yandex account user:

         ```bash
         yc <service_name> <resource> add-access-binding \
            --id <resource_ID> \
            --role <role> \
            --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         yc <service_name> <resource> add-access-binding \
            --id <resource_ID> \
            --role <role> \
            --subject federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc <service_name> <resource> add-access-binding \
            --id <resource_ID> \
            --role <role> \
            --service-account-id <service_account_ID>
         ```

      * To a user group:

         ```bash
         yc <service_name> <resource> add-access-binding \
            --id <resource_ID> \
            --role <role> \
            --subject group:<group_ID>
         ```

      * To all users of an organization:

         ```bash
         yc <service_name> <resource> add-access-binding \
            --id <resource_ID> \
            --role <role> \
            --organization-users <organization_ID>
         ```

      * To all users of an identity federation:

         ```bash
         yc <service_name> <resource> add-access-binding \
            --id <resource_ID> \
            --role <role> \
            --federation-users <federation_ID>
         ```

- API {#api}

   To assign a role for a resource, use the `updateAccessBindings` REST API method or gRPC API call for the resource and provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}

## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the resource resides in.
   1. Open its page.
   1. Go to ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to a resource.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign multiple roles for a resource:

   1. Make sure the resource has no roles assigned that you would not want to lose:

      ```bash
      yc <service_name> <resource> list-access-bindings \
         --id <resource_ID>
      ```

      Example for a [{{ compute-full-name }} VM](../../../compute/concepts/vm.md):

      ```bash
      {{ yc-compute-instance }} list-access-bindings \
         --id <VM_ID>
      ```

   1. See the description of the CLI role assignment command:

      ```bash
      yc <service_name> <resource> set-access-bindings --help
      ```

   1. Get a list of resources with their IDs:

      ```bash
      yc <service_name> <resource> list
      ```

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), user group, organization, or identity federation to which or the users of which you are assigning a role.
   1. Use one of the commands below to assign roles:

      * To a Yandex account user:

         ```bash
         yc <service_name> <resource> set-access-bindings \
            --id <resource_ID> \
            --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To a federated user:

         ```bash
         yc <service_name> <resource> set-access-bindings \
            --id <resource_ID> \
            --access-binding role=<role>,subject=federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc <service_name> <resource> set-access-bindings \
            --id <resource_ID> \
            --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc <service_name> <resource> set-access-bindings \
            --id <resource_ID> \
            --access-binding role=<role>,subject=group:<group_ID>
         ```

      * To all users of an organization:

         ```bash
         yc <service_name> <resource> set-access-bindings \
            --id <resource_ID> \
            --access-binding role=<role>,subject=system:group:organization:<organization_ID>:users
         ```

      * To all users of an identity federation:

         ```bash
         yc <service_name> <resource> set-access-bindings \
            --id <resource_ID> \
            --access-binding role=<role>,subject=system:group:federation:<federation_ID>:users
         ```

      Provide a separate `--access-binding` flag for each role. Example:

      ```bash
      yc <service_name> <resource> set-access-bindings \
         --id <resource_ID> \
         --access-binding role=<Role_1>,service-account-id=<service_account_ID> \
         --access-binding role=<Role_2>,service-account-id=<service_account_ID> \
         --access-binding role=<Role_3>,service-account-id=<service_account_ID>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

   To assign multiple roles for a resource, use the `setAccessBindings` REST API method or gRPC API call for the resource. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

   * Role in the `accessBindings[].roleId` parameter.
   * ID of the subject getting the roles in the `accessBindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

{% endlist %}
