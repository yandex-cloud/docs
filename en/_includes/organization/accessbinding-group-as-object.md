{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** and click the row with the name of the [group](../../organization/concepts/groups.md) you need.
  1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Select the group, user, or [service account](../../iam/concepts/users/service-accounts.md) you need to grant access to the group. Use search, if required.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles that you need to assign to the group.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To grant access permissions for a user group:

    1. View the description of the CLI command for assigning roles:

        ```bash
        yc organization-manager group add-access-binding --help
        ```

    1. Get a list of user groups with their IDs:

        ```bash
        yc organization-manager group list \
          --organization-id <organization_ID>
        ```

    1. Get the [ID of the user](../../organization/operations/users-get.md), [service account](../../iam/operations/sa/get-id.md), or user group you need to grant access to the group.
    1. Use the `yc organization-manager group add-access-binding` command to assign the following role:

        ```bash
        yc organization-manager group add-access-binding \
          --id <group_ID> \
          --role <role> \
          --subject <subject_type>:<subject_ID>
        ```

        Where:

        * `--id`: ID of the user group to grant access to.
        * `--role`: Role ID.
        * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

            {% cut "Subject designations" %}

            {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

            {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Get the [ID of the user](../../organization/operations/users-get.md), [service account](../../iam/operations/sa/get-id.md), or user group you need to grant access to the group.
  1. Describe the parameters of the roles you assign in the configuration file:

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "editor" {
        group_id = "<group_ID>"
        role     = "<role_ID>"
        member   = "<subject>"
      }
      ```

      Where:

      * `group_id`: [User group ID](../../organization/operations/group-get-id.md).
      * `role`: Role. This is a required setting.
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_organizationmanager_group_iam_member` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  With this done, the specified subjects will get their roles for the user group. You can check the role assignment using the [{{ cloud-center }} UI]({{ link-org-cloud-center }}).

- API {#api}

   To assign a role for a user group to a subject, use the [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) REST API method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/Group/updateAccessBindings.md) gRPC API call and provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}
