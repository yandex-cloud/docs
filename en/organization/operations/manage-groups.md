# Managing user groups

You can [group](../concepts/groups.md) users by any criteria, e.g., by their duties or department.

## Creating a group {#create-group}

{% include [create-group-org](../../_includes/organization/create-group-org.md) %}

## Adding members {#add-member}

{% include [group-add-member.md](../../_includes/organization/group-add-member.md) %}

## Editing a group {#edit-group}

{% include [group-edit](../../_includes/organization/group-edit.md) %}

## Setting up permissions to manage a group {#access-manage-group}

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

- {{ org-name }} interface {#cloud-org}

   1. [Log in]({{ link-passport-login }}) as the organization administrator.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. In the left-hand panel, select ![icon-services](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** and click the line with the group name.
   1. Go to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.
   1. Click **{{ ui-key.yacloud_org.entity.group.action_add-acl }}**.
   1. Select the user or service account you want to grant access to the group.
   1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** and select the required roles.
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
   1. Use one of the commands below to assign roles:

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

      Provide a separate `--access-binding` flag for each role. Example:

      ```bash
      yc organization-manager group set-access-bindings \
         --id <group_ID> \
         --access-binding role=<role_1>,service-account-id=<service_account_ID> \
         --access-binding role=<role_2>,service-account-id=<service_account_ID> \
         --access-binding role=<role_3>,service-account-id=<service_account_ID>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

   Use the [setAccessBindings](../api-ref/Group/setAccessBindings.md) method for the [Group](../api-ref/Group/index.md) resource or the [GroupService/SetAccessBindings](../api-ref/grpc/group_service.md#SetAccessBindings) gRPC API call. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

   * Role in the `accessBindings[].roleId` parameter.
   * ID of the subject getting the roles in the `accessBindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

{% endlist %}

### Revoking a role {#remove-access-binding}

{% include [accessbinding-remove](../../_includes/organization/accessbinding-remove.md) %}

## Setting up a group's access to use {{ yandex-cloud }}{#access}

To enable group members to work with {{ yandex-cloud }} services, assign the appropriate [roles](../../iam/concepts/access-control/roles.md) to the group.

### Assigning a role for a separate resource {#access-services}

In the management console, you can assign a role for a cloud, folder, and other resources from the [list](../../iam/concepts/access-control/resources-with-access-control.md).

To grant a group access to a resource:

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

### Assigning a role for an entire organization {#access-organization}

A role granted for the entire organization allows group members to manage any {{ yandex-cloud }} resources activated for the organization as per the role's permissions.

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}
