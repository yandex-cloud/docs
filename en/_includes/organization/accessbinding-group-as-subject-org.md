{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. At the top right, click **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

  1. Go to the **{{ ui-key.yacloud_org.pages.groups }}** tab and select the [group](../../organization/concepts/groups.md) you need or search by group name.

     You can also assign a role to one of the [system](../../iam/concepts/access-control/system-group.md) groups:

     * `All users in organization X`: The group includes all users in organization `X`.
     * `All users in federation N`: The group includes all users in federation `N`.

  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the [role](../../iam/concepts/access-control/roles.md) for the organization you want to assign to the group. You can assign multiple roles.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. Assign the [role](../../iam/concepts/access-control/roles.md) to the [group](../../organization/concepts/groups.md):

     ```bash
     yc organization-manager organization add-access-binding \
       --subject group:<group_ID> \
       --role <role_ID> \
       --organization-users <organization_ID> \
       --federation-users <federation_ID>
     ```

     To assign a role to one of the [system groups](../../iam/concepts/access-control/system-group.md), instead of the `--subject` parameter, use `--organization-users <organization_ID>` or `--federation-users <federation_ID>`. In the parameter, provide the ID of the [organization](../../organization/quickstart.md) or [identity federation](../../organization/concepts/add-federation.md), respectively, to all the users you want to assign the role to.

     You can also assign a role to a system group using the `--subject` parameter. To do this, provide in it the [subject](../../iam/concepts/access-control/index.md#subject) ID matching the selected system group.

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
       organization_id = "<cloud_ID>"
       role            = "<role_ID>"
       member          = "group:<group_ID>"
     }
     ```

     Where:

     * `organization_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md). This is a required parameter.
     * `role`: Role you want to assign. This is a required parameter.
     * `member`: Group the role is assigned to. Use this format: `group:<group_ID>`. This is a required parameter.

         To assign a role to one of the [system groups](../../iam/concepts/access-control/system-group.md), specify the following in the `member` parameter:

         * `system:group:organization:<organization_ID>:users`: To assign a role to the `All users in organization X` system group.
         * `system:group:federation:<federation_ID>:users`: To assign a role to the `All users in federation N` system group.

     For more information about the `yandex_organizationmanager_organization_iam_member` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     All the resources you need will then be created in the specified [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc resource-manager folder list-access-bindings <folder_name_or_ID>
     ```

{% endlist %}