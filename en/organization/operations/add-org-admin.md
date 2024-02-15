---
title: "How to assign a user as an organization administrator in {{ org-full-name }}"
description: "By following this guide, you can assign a user as an organization administrator."
---

# Making a user an organization administrator

{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

  1. [Log in]({{ link-passport }}) as the organization administrator or owner.

  1. Go to [{{ org-full-name }}]({{ link-org-main }}).

  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).

  1. At the top right, click **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

  1. Select a user from the list or use the search bar.

  1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** and select one of the [roles](../../iam/concepts/access-control/roles.md):

      * `organization-manager.admin`
      * `organization-manager.organizations.owner`

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get the user ID](../operations/users-get.md).

  1. Assign the [role](../../iam/concepts/access-control/roles.md) using this command:

      ```bash
      yc organization-manager organization add-access-binding <organization_name_or_ID> \
        --role <role_ID> \
        --subject userAccount:<user_ID>
      ```

      Where:

      * `--role`: Role ID. Specify one of the roles: `organization-manager.admin` or `organization-manager.organizations.owner`.
      * `--subject`: User ID.

      For example, assign the administrator role for the organization with the `bpf3crucp1v2********` ID:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the parameters of the [roles](../../iam/concepts/access-control/roles.md) you assign in the configuration file:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "org_admin_role" {
        organization_id = "<organization_ID>"
        role = "<role_ID>"
        members = [
          "userAccount:<user_ID>",
        ]
      }
      ```

      Where:

      * `organization_id`: Organization ID.
      * `role`: Specify one of the roles: `organization-manager.admin` or `organization-manager.organizations.owner`. For each role, you can only use one `yandex_organization manager_organization_iam_binding`.
      * `userAccount:<user_ID>`: User's Yandex account ID.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   The user will thus be assigned the organization administrator role. You can check the new role in the [management console]({{ link-console-main }}).

- API {#api}

  Use the REST API method [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) for the [Organization](../api-ref/Organization/index.md) resource or the gRPC API call [OrganizationService/UpdateAccessBindings](../api-ref/grpc/organization_service.md#UpdateAccessBindings) and provide the following in the request:

  * `organization-manager.admin` or `organization-manager.organizations.owner` [role](../../iam/concepts/access-control/roles.md) ID in the `roleId` parameter for the REST API or `role_id` for the gRPC API.
  * User ID and type in the `subject` block.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
