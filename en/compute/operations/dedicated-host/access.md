---
title: "Configuring dedicated host group access permissions"
description: "You can assign or revoke access permissions for a group of dedicated {{ compute-name }} hosts."
---

# Configuring dedicated host group access permissions


To grant a user, group, or [service account](../../../iam/concepts/users/service-accounts.md) access to a [dedicated host group](../../concepts/dedicated-host.md), assign a [role](../../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#add-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the dedicated host group.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, select ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.compute.switch_host-groups }}**.
  1. Select a dedicated host group.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account to grant access to the dedicated host group.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [role](../../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the CLI command description for assigning a role for a dedicated host group:

     ```bash
     yc compute host-group add-access-binding --help
     ```

  1. Get a list of dedicated host groups in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute host-group list
     ```

  1. View the list of roles already assigned for the resource:

     ```bash
     yc compute host-group list-access-bindings <dedicated_host_group_name_or_ID>
     ```

  1. Assign the role using the command:

     * To a user:

       ```bash
       yc compute host-group add-access-binding <dedicated_host_group_name_or_ID> \
         --user-account-id <user_ID> \
         --role <role>
       ```

       Where:

       * `--user-account-id`: [User ID](../../../iam/operations/users/get.md). To assign a role to all authenticated users, use the `--all-authenticated-users` flag.
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

     * To a service account:

       ```bash
       yc compute host-group add-access-binding <dedicated_host_group_name_or_ID> \
         --service-account-id <service_account_ID> \
         --role <role>
       ```

       Where:

       * `--service-account-id`: [Service account ID](../../../iam/operations/sa/get-id.md).
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

- API {#api}

  To assign a role, use the [updateAccessBindings](../../api-ref/HostGroup/updateAccessBindings.md) REST API method for the [HostGroup](../../api-ref/HostGroup/index.md) resource or the [HostGroupService/UpdateAccessBindings](../../api-ref/grpc/host_group_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID in the `subject` property.

{% endlist %}

## Assigning multiple roles {#set-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the dedicated host group.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, select ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.compute.switch_host-groups }}**.
  1. Select a dedicated host group.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account to grant access to the dedicated host group.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [role](../../security/index.md#roles-list).
  1. To add another role, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  You can assign multiple roles using the `set-access-bindings` command.

  {% include [set-access-bindings](../../../_includes/compute/set-access-bindings-note.md) %}

  1. Make sure the resource has no roles assigned that you would not want to lose:

     ```bash
     yc compute host-group list-access-bindings <dedicated_host_group_name_or_ID>
     ```

  1. See the CLI command description for assigning roles for a dedicated host group:

     ```bash
     yc compute host-group set-access-bindings --help
     ```

  1. Assign roles:

     ```bash
     yc compute host-group set-access-bindings <dedicated_host_group_name_or_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--access-binding`: Parameters for setting access permissions:

       * `role`: [Role](../../security/index.md#roles-list) to assign.
       * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, assign roles to multiple users and a service account:

     ```bash
     yc compute host-group set-access-bindings my-host-group \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- API {#api}

  To assign roles for a resource, use the [setAccessBindings](../../api-ref/HostGroup/setAccessBindings.md) REST API method for the [HostGroup](../../api-ref/HostGroup/index.md) resource or the [HostGroupService/SetAccessBindings](../../api-ref/grpc/host_group_service.md#SetAccessBindings) gRPC API call.

  {% note alert %}

  The `setAccessBindings` method and the `HostGroupService/SetAccessBindings` call completely rewrite access permissions for the resource. All current resource roles will be deleted.

  {% endnote %}

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the dedicated host group.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, select ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.compute.switch_host-groups }}**.
  1. Select a dedicated host group.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. In the line with the user you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Next to the role, click ![image](../../../_assets/cross.svg).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the CLI command description for revoking a role for a dedicated host group:

     ```bash
     yc compute host-group remove-access-binding --help
     ```

  1. View the roles and assignees for the resource:

     ```bash
     yc compute host-group list-access-bindings <dedicated_host_group_name_or_ID>
     ```

  1. To revoke access permissions, run this command:

     ```bash
     yc compute host-group remove-access-binding <dedicated_host_group_name_or_ID> \
       --role=<role> \
       --subject=<subject_type>:<subject_ID> \
     ```

     Where:

     * `--role`: ID of the role to revoke.
     * `--subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, to revoke the `{{ roles-viewer }}` role for a dedicated host group from a user with the `ajel6l0jcb9s********` ID:

     ```bash
     yc compute host-group remove-access-binding my-host-group \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- API {#api}

  To revoke a role, use the [updateAccessBindings](../../api-ref/HostGroup/updateAccessBindings.md) REST API method for the [HostGroup](../../api-ref/HostGroup/index.md) resource or the [HostGroupService/UpdateAccessBindings](../../api-ref/grpc/host_group_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID under `subject`.

{% endlist %}
