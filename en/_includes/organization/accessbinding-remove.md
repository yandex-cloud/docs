
{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) with an administrator or organization owner account.

  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** and click the row with the [group](../../organization/concepts/groups.md) name.
  
  1. Go to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.

  1. To revoke roles:

      1. In the row with the user, service account, or group, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.group.action_update-acl }}**.

      1. Click ![image](../../_assets/console-icons/xmark.svg) next to the roles you want to revoke.

      1. Click **{{ ui-key.yacloud.common.save }}**.

  1. To revoke all roles, in the row with the user, service account, or group, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![TrashBin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.entity.group.action_remove-acl }}**. Confirm the action.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command to revoke a role:

       ```bash
       yc organization-manager group remove-access-binding --help
       ```

   1. Get a list of user groups with their IDs:

       ```bash
       yc organization-manager group list \
         --organization-id <organization_ID>
       ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are revoking a role from.
   1. Use the `yc organization-manager group remove-access-binding` command to revoke a role from an object:

         ```bash
         yc organization-manager group remove-access-binding \
           --id <group_ID> \
           --role <role> \
           --user-account-id <user_ID> \
           --federation-users <user_ID> \
           --service-account-id <service_account_ID> \
           --subject group:<group_ID>
         ```

         Where:

         * `--id`: User group ID.
         * `--role`: Role ID.
         
         ID of the object to revoke a role from:
         
         * `--user-account-id`: Yandex account ID.
         * `--federation-users`: Federated user ID.
         * `--service-account-id`: Service account ID.
         * `--subject group`: Group ID.

- API {#api}

   Use the [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/Group/updateAccessBindings.md) gRPC API call and provide the following in the request:

   * `REMOVE` in the `accessBindingDeltas[].action` parameter to revoke the role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject to revoke the role from in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject to revoke the role from in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}
