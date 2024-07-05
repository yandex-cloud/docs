{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

   1. [Log in]({{ link-passport-login }}) as the organization administrator.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. In the left-hand panel, select **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg) and click the line with the group name.
   1. Go to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.
   1. Click **{{ ui-key.yacloud_org.entity.group.action_add-acl }}**.
   1. Select the group, user, or service account you want to grant access to the group.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To grant access permissions for a user group:

   1. See the description of the CLI role assignment command:

      ```bash
      yc organization-manager group add-access-binding --help
      ```

   1. Get a list of user groups with their IDs:

      ```bash
      yc organization-manager group list --organization-id <organization_ID>
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning a role to.
   1. Use one of these commands to assign a role:

      * To a Yandex account user:

         ```bash
         yc organization-manager group add-access-binding \
            --id <group_ID> \
            --role <role> \
            --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         yc organization-manager group add-access-binding \
            --id <group_ID> \
            --role <role> \
            --subject federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc organization-manager group add-access-binding \
            --id <group_ID> \
            --role <role> \
            --service-account-id <service_account_ID>
         ```

      * To a user group:

         ```bash
         yc organization-manager group add-access-binding \
            --id <group_ID> \
            --role <role> \
            --subject group:<group_ID>
         ```

- API {#api}

   Use the [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/group_service.md#UpdateAccessBindings) gRPC API call and provide the following in the request:

   * `ADD` in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}
