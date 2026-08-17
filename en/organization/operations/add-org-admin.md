---
title: How to assign a user as an organization administrator in {{ org-full-name }}
description: Follow this guide to assign a user as an organization administrator in {{ org-full-name }}.
---

# Assigning a user as an organization administrator

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. At the top right, click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Select the user you want to assign as an administrator. If required, use the search bar.
  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select [`organization-manager.admin`](../../iam/roles-reference.md#organization-manager-admin).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get the user ID](users-get.md).
  1. Assign a [role](../../iam/concepts/access-control/roles.md) using this command:

      ```bash
      yc organization-manager organization add-access-binding <organization_name_or_ID> \
        --role <role_ID> \
        --user-account-id <user_ID>
      ```

      Where:

      * `--role`: Role ID. Specify the `organization-manager.admin` role.
      * `--user-account-id`: User ID. You can also use the `--user-yandex-login` parameter and specify the username instead of the ID.

      For example, this command assigns the administrator role for the organization with the `bpf3crucp1v2********` ID:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --user-account-id aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the parameters of the [roles](../../iam/concepts/access-control/roles.md) you assign in the configuration file:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "org_admin_role" {
        organization_id = "<organization_ID>"
        role            = "organization-manager.admin"
        member          = "userAccount:<user_ID>"
      }
      ```

      Where:

      * `organization_id`: [Organization ID](./organization-get-id.md).
      * `role`: Specify the `organization-manager.admin` role. For each role, you can only use one `yandex_organizationmanager_organization_iam_binding` resource.
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_organizationmanager_organization_iam_binding` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  The user will thus be assigned the organization administrator role. You can check the role assignment using the [{{ cloud-center }} UI]({{ link-org-cloud-center }}).

- API {#api}

   To assign a user the organization administrator role, use the [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UpdateAccessBindings](../../organization/api-ref/grpc/Organization/updateAccessBindings.md) gRPC API call and provide the following in the request:

   * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
