
{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) as the organization administrator or owner.
  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** and click the line with the [group](../../organization/concepts/groups.md) name.
  1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.
  1. To revoke roles:

      1. In the row with the user, service account, or group, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. Click ![image](../../_assets/console-icons/xmark.svg) next to the roles you want to revoke.
      1. Click **{{ ui-key.yacloud.common.save }}**.

  1. To revoke all roles, in the row with the user, service account, or group, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![TrashBin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_components.acl.action.revoke-access }}**. Confirm the action.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command to revoke a role:

      ```bash
      yc organization-manager group remove-access-binding --help
      ```

  1. Get a list of user groups with their IDs:

      ```bash
      yc organization-manager group list \
        --organization-id <organization_ID>
      ```

  1. Get the [ID of the user](../../organization/operations/users-get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are revoking a role from.
  1. Use the `yc organization-manager group remove-access-binding` command to revoke the role from the subject:

      ```bash
      yc organization-manager group remove-access-binding \
        --id <group_ID> \
        --role <role> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the user group to which access was granted.
      * `--role`: ID of the role you want to revoke.
      * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

          {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  To revoke a role from a user, service account, or user group:

  1. Open the {{ TF }} configuration file and remove the part containing the `yandex_organizationmanager_group_iam_member` resource for the role you want to revoke.

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "editor" {
        group_id = "<group_ID>"
        role     = "<role_ID>"
        member   = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `group_id`: [User group ID](../../organization/operations/group-get-id.md).
      * `role`: Role being revoked. This is a required setting.
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  The role will be revoked from the subject you indicated. You can check the role is no longer assigned using the [{{ cloud-center }} UI]({{ link-org-cloud-center }}).

- API {#api}

   To revoke a role for a user group from a subject, use the [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) REST API method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/Group/updateAccessBindings.md) gRPC API call and provide the following in the request:

   * `REMOVE` in the `accessBindingDeltas[].action` parameter to revoke the role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the [subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject to revoke the role from in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}
