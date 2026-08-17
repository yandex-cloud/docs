{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. At the top right, click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Go to the **{{ ui-key.yacloud_org.pages.groups }}** tab and select the [group](../../organization/concepts/groups.md) you need or search by group name.

      You can also assign a role to one of the [system](../../iam/concepts/access-control/system-group.md) groups:

      * `All users in organization X`: The group includes all users in organization `X`.
      * `All users in federation N`: The group includes all users in federation `N`.

  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the [role](../../iam/concepts/access-control/roles.md) for the organization you want to assign to the group. You can assign multiple roles.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Assign a [role](../../iam/concepts/access-control/roles.md) for an organization to a [group](../../organization/concepts/groups.md):

      ```bash
      yc organization-manager organization add-access-binding \
        --id <organization_ID> \
        --role <role_ID> \
        --subject group:<group_ID>
      ```

      Where:

      * `--id`: ID of the organization you are assigning a role for.
      * `--role`: ID of the role you need to assign.
      * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

          {% endcut %}

  1. Make sure the requested permissions are granted:

      ```bash
      yc organization-manager organization list-access-bindings <organization_ID>
      ```

      A response contains a list of all roles assigned to users and groups in the organization:

      ```text
      +------------------------------------------+--------------+----------------------+
      |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
      +------------------------------------------+--------------+----------------------+
      | organization-manager.admin               | userAccount  | ajev1p2345lj******** |
      | organization-manager.organizations.owner | userAccount  | ajev1p2345lj******** |
      | editor                                   | group        | ajev1p2345lj******** |
      | viewer                                   | group        | ajev1p2345lj******** |
      +------------------------------------------+--------------+----------------------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Add the resource parameters to the configuration file and specify the required [role](../../iam/concepts/access-control/roles.md) and [group](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_organization_iam_member" "users-editors" {
       organization_id = "<organization_ID>"
       role            = "<role_ID>"
       member          = "group:<group_ID>"
     }
     ```

     Where:
     
     * `organization_id`: [Organization ID](../../organization/operations/organization-get-id.md). This is a required setting.
     * `role`: Role being assigned. This is a required setting.
     * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

     For more on the properties of the `yandex_organizationmanager_organization_iam_member` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     With this done, the specified access permissions will be assigned. You can check the role assignment using the [{{ cloud-center }} UI]({{ link-org-cloud-center }}) or this [CLI](../../cli/) command:

     ```bash
     yc organization-manager organization list-access-bindings <organization_ID>
     ```

- API {#api}

  To assign a role for an organization to a user group, use the [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UpdateAccessBindings](../../organization/api-ref/grpc/Organization/updateAccessBindings.md) gRPC API call and provide the following in the request:

  * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
  * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
  * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
  * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}