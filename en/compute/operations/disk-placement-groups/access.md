---
title: "Configuring access permissions for a {{ compute-name }} non-replicated disk placement group"
description: "Follow this guide to configure access permissions for a non-replicated disk placement group."
---

# Configuring access permissions for a non-replicated disk placement group


To grant a user, group, or [service account](../../../iam/concepts/users/service-accounts.md) access to a [non-replicated disk placement group](../../concepts/disk-placement-group.md), assign a [role](../../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#add-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the disk placement group is located.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. On the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab, click the name of the group.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select a group, user, or service account to be granted access to the placement group.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [role](../../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the CLI command description for assigning a role for a disk placement group:

     ```bash
     yc compute disk-placement-group add-access-binding --help
     ```

  1. Get a list of disk placement groups in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute disk-placement-group list
     ```

  1. View the list of roles already assigned for the resource:

     ```bash
     yc compute disk-placement-group list-access-bindings <placement_group_ID>
     ```

  1. Assign the role using the command:

     * To a user:

       ```bash
       yc compute disk-placement-group add-access-binding <placement_group_ID> \
         --user-account-id <user_ID> \
         --role <role>
       ```

       Where:

       * `--user-account-id`: [User ID](../../../iam/operations/users/get.md). To assign a role to all authenticated users, use the `--all-authenticated-users` flag.
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

     * To a service account:

       ```bash
       yc compute disk-placement-group add-access-binding <placement_group_ID> \
         --service-account-id <service_account_ID> \
         --role <role>
       ```

       Where:

       * `--service-account-id`: [Service account ID](../../../iam/operations/sa/get-id.md).
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign a role for a non-replicated disk placement group using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_disk_placement_group_iam_binding" "sa-access" {
        disk_placement_group_id = "<placement_group_ID>"
        role    = "<role>"
        members = ["<subject_type>:<subject_ID>","<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `disk_placement_group_id`: Disk placement group ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) getting the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_disk_placement_group_iam_binding` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/compute_disk_placement_group_iam_binding).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc compute disk-placement-group list-access-bindings <placement_group_ID>
      ```

- API {#api}

  To assign a role, use the [updateAccessBindings](../../api-ref/DiskPlacementGroup/updateAccessBindings.md) REST API method for the [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md) resource or the [DiskPlacementGroupService/UpdateAccessBindings](../../api-ref/grpc/disk_placement_group_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID under `subject`.

{% endlist %}

## Assigning multiple roles {#set-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the disk placement group is located.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. On the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab, click the name of the group.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select a group, user, or service account to be granted access to the placement group.
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
     yc compute disk-placement-group list-access-bindings <placement_group_ID>
     ```

  1. See the CLI command description for assigning roles for a disk placement group:

     ```bash
     yc compute disk-placement-group set-access-bindings --help
     ```

  1. Assign roles:

     ```bash
     yc compute disk-placement-group set-access-bindings <placement_group_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--access-binding`: Parameters for setting access permissions:

       * `role`: [Role](../../security/index.md#roles-list) to assign.
       * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, assign roles to multiple users and a service account:

     ```bash
     yc compute disk-placement-group set-access-bindings my-disk-group \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign multiple roles for a disk placement group using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_disk_placement_group_iam_binding" "role-1" {
        disk_placement_group_id = "<placement_group_ID>"
        role                    = "<role_1>"
        members                 = ["<subject_type>:<subject_ID>"]
      }

      resource "yandex_compute_disk_placement_group_iam_binding" "role-2" {
        disk_placement_group_id = "<placement_group_ID>"
        role                    = "<role_2>"
        members                 = ["<subject_type>:<subject_ID>"]
      }
      ```

     Where:

      * `disk_placement_group_id`: Disk placement group ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) getting the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_disk_placement_group_iam_binding` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/compute_disk_placement_group_iam_binding).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc compute disk-placement-group list-access-bindings <placement_group_ID>
      ```

- API {#api}

  To assign roles for a resource, use the [setAccessBindings](../../api-ref/DiskPlacementGroup/setAccessBindings.md) REST API method for the [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md) resource or the [DiskPlacementGroupService/SetAccessBindings](../../api-ref/grpc/disk_placement_group_service.md#SetAccessBindings) gRPC API call.

  {% note alert %}

  The `setAccessBindings` method and the `DiskPlacementGroupService/SetAccessBindings` call completely rewrite the resource access permissions. All current resource roles will be deleted.

  {% endnote %}

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the disk placement group is located.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. On the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab, click the name of the group.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. In the line with the user you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Next to the role, click ![image](../../../_assets/cross.svg).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the CLI command description for revoking a role for a disk placement group:

     ```bash
     yc compute disk-placement-group remove-access-binding --help
     ```

  1. View the roles and assignees for the resource:

     ```bash
     yc compute disk-placement-group list-access-bindings <placement_group_ID>
     ```

  1. To revoke access permissions, run this command:

     ```bash
     yc compute disk-placement-group remove-access-binding <placement_group_ID> \
       --role=<role> \
       --subject=<subject_type>:<subject_ID> \
     ```

     Where:

     * `--role`: ID of the role to revoke.
     * `--subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, this command revokes the `{{ roles-viewer }}` role for a placement group from a user with the `ajel6l0jcb9s********` ID:

     ```bash
     yc compute disk-placement-group remove-access-binding my-disk-group \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  
  To revoke a role assigned for a non-replicated disk placement group using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the role description.

      ```hcl
      resource "yandex_compute_disk_placement_group_iam_binding" "sa-access" {
        disk_placement_group_id = "<placement_group_ID>"
        role                    = "<role>"
        members                 = ["<subject_type>:<subject_ID>"]
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc compute disk-placement-group list-access-bindings <placement_group_ID>
      ```

- API {#api}

  To revoke a role, use the [updateAccessBindings](../../api-ref/DiskPlacementGroup/updateAccessBindings.md) REST API method for the [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md) resource or the [DiskPlacementGroupService/UpdateAccessBindings](../../api-ref/grpc/disk_placement_group_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID under `subject`.

{% endlist %}
