---
title: "Configuring access permissions for a {{ compute-full-name }} disk snapshot schedule"
description: "Follow this guide to configure access permissions for a {{ compute-full-name }} disk snapshot schedule."
---

# Configuring access permissions for a disk snapshot schedule

To grant a user, group, or [service account](../../../iam/concepts/users/service-accounts.md) access to a [disk snapshot schedule](../../concepts/snapshot-schedule.md), assign a [role](../../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the schedule belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. Go to the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab.
   1. Select a schedule from the list.
   1. Go to ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the window that opens, select a group, user, or service account to be granted access to the schedule.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../../security/index.md#roles-list).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the CLI command description for assigning a role for a disk snapshot schedule:

      ```bash
      yc compute snapshot-schedule add-access-binding --help
      ```

   1. Get a list of schedules in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-snapshot-schedule-list](../../_includes_service/compute-snapshot-schedule-list.md) %}

   1. View the list of roles already assigned for the resource:

      ```bash
      yc compute snapshot-schedule list-access-bindings <schedule_name_or_ID>
      ```

   1. Assign the role using the command:

      * To a user:

         ```bash
         yc compute snapshot-schedule add-access-binding <schedule_name_or_ID> \
           --user-account-id <user_ID> \
           --role <role>
         ```

         Where:

         * `--user-account-id`: [User ID](../../../iam/operations/users/get.md).
         * `--role`: [Role](../../security/index.md#roles-list) being assigned.

      * To a service account:

         ```bash
         yc compute snapshot-schedule add-access-binding <schedule_name_or_ID> \
           --service-account-id <service_account_ID> \
           --role <role>
         ```

         Where:

         * `--service-account-id`: [Service account ID](../../../iam/operations/sa/get-id.md).
         * `--role`: Role being assigned.

- API {#api}

   Use the [updateAccessBindings](../../api-ref/SnapshotSchedule/updateAccessBindings.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/) resource or the [SnapshotSchedule/UpdateAccessBindings](../../api-ref/grpc/snapshot_schedule_service.md#UpdateAccessBindings) gRPC API call. In the request body, specify `ADD` in the `action` property, and user type and ID in the `subject` property.

{% endlist %}

## Assign multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the schedule belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. Go to the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab.
   1. Select a schedule from the list.
   1. Go to ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the window that opens, select a group, user, or service account to be granted access to the schedule.
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../../security/index.md#roles-list).
   1. Use the **{{ ui-key.yacloud_components.acl.button.add-role }}** button to add another role.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   You can assign multiple roles using the `set-access-bindings` command.

   {% include [set-access-bindings](../../../_includes/compute/set-access-bindings-note.md) %}

   1. Make sure the resource has no roles assigned that you would rather not lose:

      ```bash
      yc compute snapshot-schedule list-access-bindings <schedule_name_or_ID>
      ```

   1. See the CLI command description for assigning roles for a disk snapshot schedule:

      ```bash
      yc compute snapshot-schedule set-access-bindings --help
      ```

   1. Assign roles:

      ```bash
      yc compute snapshot-schedule set-access-bindings <schedule_name_or_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `--access-binding`: Assigned role:

         * `role`: Assigned role ID.
         * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

      For example, assign roles to multiple users and a service account:

      ```bash
      yc compute snapshot-schedule set-access-bindings my-schedule \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
        --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
      ```

- API {#api}

   Use the [setAccessBindings](../../api-ref/SnapshotSchedule/setAccessBindings.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/) resource or the [SnapshotSchedule/SetAccessBindings](../../api-ref/grpc/snapshot_schedule_service.md#SetAccessBindings) gRPC API call.

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the schedule belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. Go to the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab.
   1. Select a schedule from the list.
   1. Go to ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
   1. In the line of the required user, click ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
   1. Click ![cross](../../../_assets/console-icons/xmark.svg) next to a role to delete it.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the CLI command description for revoking a role for a disk snapshot schedule:

      ```bash
      yc compute snapshot-schedule remove-access-binding --help
      ```

   1. View the roles and assignees for the resource:

      ```bash
      yc compute snapshot-schedule list-access-bindings <schedule_name_or_ID>
      ```

   1. To delete an access binding, run:

      ```bash
      yc compute snapshot-schedule remove-access-binding <schedule _name_or_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: ID of the role to be revoked.
      * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) to revoke the role from.

      For example, to revoke the `{{ roles-viewer }}` role for a schedule from a user with the `ajel6l0jcb9s********` ID:

      ```bash
      yc compute snapshot-schedule remove-access-binding my-schedule \
        --role viewer \
        --subject userAccount:ajel6l0jcb9s********
      ```

- API {#api}

   To revoke disk snapshot schedule roles, use the [updateAccessBindings](../../api-ref/SnapshotSchedule /updateAccessBindings.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/) resource or the [SnapshotScheduleService/UpdateAccessBindings](../../api-ref/grpc/snapshot_schedule_service.md#UpdateAccessBindings) gRPC API call. In the request body, specify `REMOVE` in the `action` property, and user type and ID in the `subject` property.

{% endlist %}
