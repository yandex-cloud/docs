---
title: How to grant access to a user pool in {{ org-full-name }}
description: In this article, you will learn how to set up access to a user pool in {{ org-full-name }}.
---

# Setting up access to a user pool


To grant access to a [pool](../../concepts/user-pools.md), assign [roles](../../../iam/concepts/access-control/roles.md) to subjects. [Learn](../../security/index.md#roles-list) what roles the service has and assign the required ones.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select a user pool.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.userpools.UserpoolPageLayout.title_userpool_acl_5rdMM }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. In the window that opens, select the group, user, or service account you need to grant access to the user pool.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select a role. Add other roles as needed.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command for assigning roles for a [user pool](../../concepts/user-pools.md):

      ```bash
      yc organization-manager idp userpool set-access-bindings --help
      ```

   1. Get the list of user pools and their IDs:

      ```bash
      yc organization-manager idp userpool list --organization-id <organization_ID>
      ```

      Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of user pools for.

   1. Get the ID of the [user](../../../organization/operations/users-get.md), [service account](../../../iam/operations/sa/get-id.md), or group to which you are assigning roles for the user pool.
   1. Use the `yc organization-manager idp userpool set-access-bindings` command to assign the following roles:

      ```bash
      yc organization-manager idp userpool set-access-bindings \
        --id <pool_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the user pool to grant access to.
      * `role`: ID of the role you need to assign.
      * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc organization-manager idp userpool set-access-bindings \
        --id <pool_ID> \
        --access-binding role=<role1>,service-account-id=<service_account_ID> \
        --access-binding role=<role2>,service-account-id=<service_account_ID> \
        --access-binding role=<role3>,service-account-id=<service_account_ID>
      ```

- API {#api}

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

  Use the [Userpool.SetAccessBindings](../../idp/api-ref/Userpool/setAccessBindings.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/SetAccessBindings](../../idp/api-ref/grpc/Userpool/setAccessBindings.md) gRPC API call.

  Provide the following in the request:

  * Role in the `accessBindings[].roleId` parameter.
  * ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role for the user pool in the `accessBindings[].subject.id` parameter.
  * Type of the subject getting the role for the user pool in the `accessBindings[].subject.type` parameter.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}
