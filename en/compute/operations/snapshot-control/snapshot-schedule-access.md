---
title: Configuring access permissions for a {{ compute-name }} disk snapshot schedule
description: Follow this guide to configure access permissions for a disk snapshot schedule.
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
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
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
     yc compute snapshot-schedule list-access-bindings <schedule_ID>
     ```

  1. Assign the role using the command:

     * To a user:

       ```bash
       yc compute snapshot-schedule add-access-binding <schedule_ID> \
         --user-account-id <user_ID> \
         --role <role>
       ```

       Where:

       * `--user-account-id`: [User ID](../../../iam/operations/users/get.md).
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

     * To a service account:

       ```bash
       yc compute snapshot-schedule add-access-binding <schedule_ID> \
         --service-account-id <service_account_ID> \
         --role <role>
       ```

       Where:

       * `--service-account-id` is the [service account ID](../../../iam/operations/sa/get-id.md).
       * `--role`: Role you want to assign.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign a role for a schedule using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_snapshot_schedule_iam_binding" "sa-access" {
        snapshot_schedule_id = "<schedule_ID>"
        role                 = "<role>"
        members              = ["<subject_type>:<subject_ID>","<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `snapshot_schedule_id`: Schedule ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) the role is assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_snapshot_schedule_iam_binding` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/compute_snapshot_schedule_iam_binding).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) and this [CLI](../../../cli/) command:

      ```bash
      yc compute snapshot-schedule list-access-bindings <schedule_ID>
      ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/SnapshotSchedule/updateAccessBindings.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/) resource or the [SnapshotSchedule/UpdateAccessBindings](../../api-ref/grpc/snapshot_schedule_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID in the `subject` property.

{% endlist %}

## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the schedule belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Go to the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab.
  1. Select a schedule from the list.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select a group, user, or service account to be granted access to the schedule.
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
     yc compute snapshot-schedule list-access-bindings <schedule_ID>
     ```

  1. See the CLI command description for assigning roles for a disk snapshot schedule:

     ```bash
     yc compute snapshot-schedule set-access-bindings --help
     ```

  1. Assign roles:

     ```bash
     yc compute snapshot-schedule set-access-bindings <schedule_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--access-binding`: Role you want to assign:

       * `role`: ID of the role to assign.
       * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, assign roles to multiple users and a service account:

     ```bash
     yc compute snapshot-schedule set-access-bindings my-schedule \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign multiple roles for a schedule using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_snapshot_schedule_iam_binding" "role-1" {
        snapshot_schedule_id = "<schedule_ID>"
        role                 = "<role_1>"
        members              = ["<subject_type>:<subject_ID>"]
      }

      resource "yandex_compute_snapshot_schedule_iam_binding" "role-2" {
        snapshot_schedule_id = "<schedule_ID>"
        role                 = "<role_2>"
        members              = ["<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `snapshot_schedule_id`: Schedule ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) the role is assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_snapshot_schedule_iam_binding` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/compute_snapshot_schedule_iam_binding).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc compute snapshot-schedule list-access-bindings <schedule_ID>
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
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. In the line with the user you need, click ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
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
     yc compute snapshot-schedule list-access-bindings <schedule_ID>
     ```

  1. To revoke access permissions, run this command:

      ```bash
      yc compute snapshot-schedule remove-access-binding <schedule_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: ID of the role to revoke.
      * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) to revoke the role from.

      For example, this command revokes the `{{ roles-viewer }}` role for a schedule from a user with the `ajel6l0jcb9s********` ID:

      ```bash
      yc compute snapshot-schedule remove-access-binding my-schedule \
        --role viewer \
        --subject userAccount:ajel6l0jcb9s********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To revoke a role assigned for a disk snapshot schedule using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the role description.

      ```hcl
      ...
      resource "yandex_compute_snapshot_schedule_iam_binding" "sa-access" {
        snapshot_schedule_id = "<schedule_ID>"
        role                 = "<role>"
        members              = ["<subject_type>:<subject_ID>"]
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc compute snapshot-schedule list-access-bindings <schedule_ID>
      ```

- API {#api}

  To revoke a role for a disk snapshot schedule, use the [updateAccessBindings](../../api-ref/SnapshotSchedule /updateAccessBindings.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/) resource or the [SnapshotScheduleService/UpdateAccessBindings](../../api-ref/grpc/snapshot_schedule_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID in the `subject` property.

{% endlist %}
