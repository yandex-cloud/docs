# Assigning roles

To grant access to a resource, assign a [role](../../concepts/access-control/roles.md) for it. You can assign a role to:

* [Yandex account users](../../concepts/users/accounts.md#passport)
* [Federated users](../../concepts/users/accounts.md#saml-federation)
* [Service accounts](../../concepts/users/service-accounts.md)
* [User groups](../../../organization/concepts/groups.md)

You can assign a role not only for the resource itself but also for its parent resource, as the former inherits access permissions from the latter. For example, if a service account gets a role for a cloud, it will also get permissions for all resources across the cloud's folders. For more information, see [{#T}](../../concepts/access-control/index.md).

[Learn](../../concepts/access-control/resources-with-access-control.md) which resources you can assign a role for.

To select roles, look them up in the [role reference](../../roles-reference.md).

## Assigning a role for a cloud {#cloud-or-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate cloud or folder.
   1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to a cloud or folder.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for a cloud or folder:

   1. See the description of the CLI role assignment command:

      ```bash
      yc resource-manager <cloud_or_folder> add-access-binding --help
      ```

      Specify `cloud` or `folder` as needed.

   1. Get a list of available clouds or folders with their IDs:

      ```bash
      yc resource-manager <cloud_or_folder> list
      ```

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), or user group you are assigning a role to.
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

- API {#api}

   To assign a role for a cloud, use the [updateAccessBindings](../../../resource-manager/api-ref/Cloud/updateAccessBindings.md) REST API method for the [Cloud](../../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/cloud_service.md#UpdateAccessBindings) gRPC API call.

   To assign a role for a folder, use the [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/folder_service.md#UpdateAccessBindings) gRPC API call.

   Provide the following in the request:

   * `ADD` in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}

## Assigning a role for an organization {#organization}

To grant access permissions for an organization, you need the `{{ roles-organization-admin }}` role or higher. To learn more about the role sequence, see the [{{ org-full-name }} document](../../../organization/security/index.md#roles-list).

{% list tabs group=instructions %}

- {{ org-name }} {#cloud-org}

   To assign a role for an organization:

   1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. In the left-hand panel, select ![icon-acl](../../../_assets/console-icons/persons-lock.svg) [**{{ ui-key.yacloud_org.pages.acl }}**]({{ link-org-acl }}).
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to an organization.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

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

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), or user group you are assigning a role to.
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

      * To a user group:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <organization_ID> \
            --role <role> \
            --subject group:<group_ID>
         ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To assign a role for an organization:

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), or user group you are assigning a role to.
   1. Describe the resource with the role for the organization in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "<resource_name>" {
        organization_id = "<organization_ID>"
        role            = "<role>"
        members         = [<users>]
      }
      ```

      Where:

      * `organization_id`: Organization ID. This is a required parameter.
      * `role`: Role being assigned. For each role, you can only use one `yandex_organizationmanager_organization_iam_binding` resource. This is a required parameter.
      * `members`: Users getting the role. Specify the following:

         * `members = ["userAccount:<user_ID>"]` for a Yandex account user.
         * `members = ["federatedUser:<user_ID>"]` for a federated user.
         * `members = ["serviceAccount:<user_ID>"]` for a service account.
         * `members = ["group:<user_ID>"]` for a user group.

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

   To assign a role for the organization, use the [updateAccessBindings](../../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UpdateAccessBindings](../../../organization/api-ref/grpc/organization_service.md#UpdateAccessBindings) gRPC API call and provide the following in the request:

   * `ADD` in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}

## Assigning a role for a resource {#resource}

You can assign a role not only for a cloud or folder but also their child resources. These are listed in [{#T}](../../concepts/access-control/resources-with-access-control.md).

{% list tabs group=instructions %}

- Management console {#console}

   To assign a role for a resource:

   1. In the [management console]({{ link-console-main }}), select the folder containing the resource.
   1. Open its page.
   1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to a resource.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
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

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), or user group you are assigning a role to.
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

- API {#api}

   To assign a role for a resource, use the `updateAccessBindings` REST API method or gRPC API call for the resource and provide the following in the request:

   * `ADD` in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}

## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing the resource.
   1. Open its page.
   1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to a resource.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign multiple roles for a resource:

   1. Make sure the resource has no roles assigned that you would rather not lose:

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

   1. Get the [ID of the user](../users/get.md), [service account](../sa/get-id.md), or user group you are assigning roles to.
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

      Provide a separate `--access-binding` flag for each role. Example:

      ```bash
      yc <service_name> <resource> set-access-bindings \
         --id <resource_ID> \
         --access-binding role=<role_1>,service-account-id=<service_account_ID> \
         --access-binding role=<role_2>,service-account-id=<service_account_ID> \
         --access-binding role=<role_3>,service-account-id=<service_account_ID>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

   To assign multiple roles for a resource, use the `setAccessBindings` REST API method or gRPC API call for the resource. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

   * Role in the `accessBindings[].roleId` parameter.
   * ID of the subject getting the roles in the `accessBindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

{% endlist %}
