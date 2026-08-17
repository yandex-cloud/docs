---
title: How to set up access to manage a user group in {{ org-full-name }}
description: Follow this guide to set up access to manage a user group in {{ org-full-name }}.
---

# Configuring group management access

You can grant access to a user group to:

* [Yandex account users](../../iam/concepts/users/accounts.md#passport)
* [Federated users](../../iam/concepts/users/accounts.md#saml-federation)
* [Local users](../../iam/concepts/users/accounts.md#local)
* [Service accounts](../../iam/concepts/users/service-accounts.md)
* Other [user groups](../../organization/concepts/groups.md)

To do this, assign [roles](../../iam/concepts/access-control/roles.md) for the group. To choose the ones you need, [learn](../security/index.md#roles-list) about the service's roles.

## Assigning a role {#add-access-binding}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-object.md) %}

## Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) as the organization administrator or owner.
  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** and click the line with the [group](../../organization/concepts/groups.md) name.
  1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Select the user, group, or [service account](../../iam/concepts/users/service-accounts.md) you need to grant access to the group. Use search, if required.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles that you need to assign to the group.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign multiple roles for a user group:

  1. Make sure the resource has no important roles assigned before proceeding:

      ```bash
      yc organization-manager group list-access-bindings \
        --id <group_ID>
      ```

  1. View the description of the CLI command for assigning roles:

      ```bash
      yc organization-manager group set-access-bindings --help
      ```

  1. Get a list of user groups with their IDs:

      ```bash
      yc organization-manager group list
      ```

  1. Get the [ID of the user](../../organization/operations/users-get.md), [service account](../../iam/operations/sa/get-id.md), or [user group](group-get-id.md) you need to grant access to the group.
  1. Use the `yc organization-manager group set-access-bindings` command to assign the following roles:

      ```bash
      yc organization-manager group set-access-bindings \
        --id <group_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the user group to grant access to.
      * `role`: ID of the role you need to assign.
      * `subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc organization-manager group set-access-bindings \
        --id ins672qpemb4******** \
        --access-binding role=<role1>,subject=serviceAccount:<service_account_ID> \
        --access-binding role=<role2>,subject=serviceAccount:<service_account_ID> \
        --access-binding role=<role3>,subject=serviceAccount:<service_account_ID>
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign multiple roles for a user group:

  1. Describe the parameters of the roles you assign in the configuration file:

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "role1" {
        group_id = "<group_ID>"
        role     = "<role1>"
        member   = "<subject_type>:<subject_ID>"
      }

      resource "yandex_organizationmanager_group_iam_member" "role2" {
        group_id = "<group_ID>"
        role     = "<role2>"
        member   = "<subject_type>:<subject_ID>"
      }

      resource "yandex_organizationmanager_group_iam_member" "role3" {
        group_id = "<group_ID>"
        role     = "<role3>"
        member   = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `group_id`: [User group ID](group-get-id.md).
      * `role`: Role you want to assign.
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_organizationmanager_group_iam_member` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  With this done, the specified subject will get several roles for the user group. You can check role assignments using the [{{ cloud-center }} UI]({{ link-org-cloud-center }}).

- API {#api}

  {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

  To assign several roles for a user group to a subject, use the [setAccessBindings](../api-ref/Group/setAccessBindings.md) REST API method for the [Group](../api-ref/Group/index.md) resource or the [GroupService/SetAccessBindings](../api-ref/grpc/Group/setAccessBindings.md) gRPC API call. In your request, provide an array of objects, each one matching a particular role and containing the following data:

  * Role in the `accessBindings[].roleId` parameter.
  * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the roles in the `accessBindings[].subject.id` parameter.
  * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}


{% endlist %}

## Revoking a role {#remove-access-binding}

{% include [accessbinding-remove](../../_includes/organization/accessbinding-remove.md) %}