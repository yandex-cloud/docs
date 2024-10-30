---
title: Configuring instance group access permissions
description: Follow this guide to configure instance group access permissions.
---

# Configuring instance group access permissions

To grant a user, group, or [service account](../../../iam/concepts/users/service-accounts.md) access to an [instance group](../../concepts/instance-groups/index.md), assign a [role](../../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the instance group is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Select the group you need.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account to grant access to the instance group.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the CLI command description for assigning a role for an instance group:

     ```bash
     {{ yc-compute-ig }} add-access-binding --help
     ```

  1. Get a list of instance groups in the default folder:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. View the list of roles already assigned for the resource:

     ```bash
     {{ yc-compute-ig }} list-access-bindings <instance_group_name_or_ID>
     ```

  1. Assign the role using the command:

     * To a user:

       ```bash
       {{ yc-compute-ig }} add-access-binding <instance_group_name_or_ID> \
         --user-account-id <user_ID> \
         --role <role>
       ```

       Where:

       * `--user-account-id`: [User ID](../../../iam/operations/users/get.md).
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

     * To a service account:

       ```bash
       {{ yc-compute-ig }} add-access-binding <instance_group_name_or_ID> \
         --service-account-id <service_account_ID> \
         --role <role>
       ```

       Where:

       * `--service-account-id` is the [service account ID](../../../iam/operations/sa/get-id.md).
       * `--role`: Role you want to assign.

- API {#api}

  Use the [updateAccessBindings](../../instancegroup/api-ref/InstanceGroup/updateAccessBindings.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/) resource or the [InstanceGroupService/UpdateAccessBindings](../../instancegroup/api-ref/grpc/InstanceGroup/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID in the `subject` property.

{% endlist %}

## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the instance group is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Select the group you need.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account to grant access to the instance group.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../../security/index.md#roles-list).
  1. To add another role, click **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  You can assign multiple roles using the `set-access-bindings` command.

  {% include [set-access-bindings](../../../_includes/compute/set-access-bindings-note.md) %}

  1. Make sure the resource has no roles assigned that you would not want to lose:

     ```bash
     {{ yc-compute-ig }} list-access-bindings <VM_group_name_or_ID>
     ```

  1. See the CLI command description for assigning roles for an instance group:

     ```bash
     {{ yc-compute-ig }} set-access-bindings --help
     ```

  1. Assign roles:

     ```bash
     {{ yc-compute-ig }} set-access-bindings <instance_group_name_or_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--access-binding`: Role to assign:

       * `role`: ID of the role to assign.
       * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, assign roles to multiple users and a service account:

     ```bash
     {{ yc-compute-ig }} set-access-bindings test-group \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
       --access-binding role=viewer,subject=userAccount:helj89sfj80a******** \
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- API {#api}

  Use the [setAccessBindings](../../instancegroup/api-ref/InstanceGroup/setAccessBindings.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/) resource or the [InstanceGroupService/SetAccessBindings](../../instancegroup/api-ref/grpc/InstanceGroup/setAccessBindings.md) gRPC API call.

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the instance group is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Select the group you need.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. In the line with the user you need, click ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Click ![cross](../../../_assets/console-icons/xmark.svg) next to a role to delete it.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the CLI command description for revoking a role for an instance group:

     ```bash
     {{ yc-compute-ig }} remove-access-binding --help
     ```

  1. View the roles and assignees for the resource:

     ```bash
     {{ yc-compute-ig }} list-access-bindings <instance_group_name_or_ID>
     ```

  1. To revoke access permissions, run this command:

     ```bash
     {{ yc-compute-ig }} remove-access-binding <instance_group_name_or_ID> \
       --role <role_ID> \
       --subject <subject_type>:<subject_ID>
     ```

     Where:

     * `--role`: ID of the role to revoke.
     * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) to revoke the role from.

     For example, to revoke the `{{ roles-viewer }}` role for an instance group from a user with the `ajel6l0jcb9s********` ID:

     ```bash
     {{ yc-compute-ig }} remove-access-binding test-group \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- API {#api}

  To revoke instance roles, use the [updateAccessBindings](../../instancegroup/api-ref/InstanceGroup/updateAccessBindings.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/) resource or the [InstanceGroupService/UpdateAccessBindings](../../instancegroup/api-ref/grpc/InstanceGroup/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID in the `subject` property.

{% endlist %}
