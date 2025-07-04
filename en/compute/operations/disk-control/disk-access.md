---
title: Configuring access permissions for a {{ compute-name }} disk
description: Follow this guide to configure disk access permissions.
---

# Configuring disk access permissions

To grant a user, group, or [service account](../../../iam/concepts/users/service-accounts.md) access to a [disk](../../concepts/disk.md), assign a [role](../../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the disk belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Select the disk from the list.
  1. Navigate to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account you want to grant access to the disk.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for assigning a role for a disk:

     ```bash
     yc compute disk add-access-binding --help
     ```

  1. Get a list of disks in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     {% include [compute-disk-list](../../_includes_service/compute-disk-list.md) %}

  1. View a list of roles already assigned for the resource in question:

     ```bash
     yc compute disk list-access-bindings <disk_ID>
     ```

  1. Assign the role using this command:

     * To a user:

       ```bash
       yc compute disk add-access-binding <disk_ID> \
         --user-account-id <user_ID> \
         --role <role>
       ```

       Where:

       * `--user-account-id`: [User ID](../../../iam/operations/users/get.md).
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

     * To a service account:

       ```bash
       yc compute disk add-access-binding <disk_ID> \
         --service-account-id <service_account_ID> \
         --role <role>
       ```

       Where:

       * `--service-account-id`: [Service account ID](../../../iam/operations/sa/get-id.md).
       * `--role`: Role to assign.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign a role for a disk using {{ TF }}:

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "sa-access" {
        disk_id = "<disk_ID>"
        role    = "<role>"
        members = ["<subject_type>:<subject_ID>","<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `disk_id`: Disk ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) getting the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_disk_iam_binding` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_disk_iam_binding).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc compute disk list-access-bindings <disk_ID>
      ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/Disk/updateAccessBindings.md) REST API method for the [Disk](../../api-ref/Disk/) resource or the [DiskService/UpdateAccessBindings](../../api-ref/grpc/Disk/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID under `subject`.

{% endlist %}

## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the disk belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Select the disk from the list.
  1. Navigate to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account you want to grant access to the disk.
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
     yc compute disk list-access-bindings <disk_ID>
     ```

  1. See the description of the CLI command for assigning roles for a disk:

     ```bash
     yc compute disk set-access-bindings --help
     ```

  1. Assign roles:

     ```bash
     yc compute disk set-access-bindings <disk_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--access-binding`: Role to assign:

       * `role`: ID of the role to assign.
       * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) you are assigning the role to.

     For example, this command will assign roles to multiple users and a single service account:

     ```bash
     yc compute disk set-access-bindings my-disk \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign multiple roles for a disk using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "role1" {
        disk_id = "<disk_ID>"
        role    = "<role_1>"
        members = ["<subject_type>:<subject_ID>"]
      }

      resource "yandex_compute_disk_iam_binding" "role2" {
        disk_id = "<disk_ID>"
        role    = "<role_2>"
        members = ["<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `disk_id`: Disk ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) getting the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_disk_iam_binding` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_disk_iam_binding).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc compute disk list-access-bindings <disk_ID>
      ```

- API {#api}

  Use the [setAccessBindings](../../api-ref/Disk/setAccessBindings.md) REST API method for the [Disk](../../api-ref/Disk/) resource or the [DiskService/SetAccessBindings](../../api-ref/grpc/Disk/setAccessBindings.md) gRPC API call.

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the disk belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Select the disk from the list.
  1. Navigate to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the line with the user in question, click ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Click ![cross](../../../_assets/console-icons/xmark.svg) next to a role to delete it.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for revoking a role for a disk:

     ```bash
     yc compute disk remove-access-binding --help
     ```

  1. View the roles and assignees for the resource:

     ```bash
     yc compute disk list-access-bindings <disk_ID>
     ```

  1. To revoke access permissions, run this command:

     ```bash
     yc compute disk remove-access-binding <disk_ID> \
       --role <role_ID> \
       --subject <subject_type>:<subject_ID>
     ```

     Where:

     * `--role`: ID of the role you want to revoke.
     * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) to revoke the role from.

     For example, this command revokes the `{{ roles-viewer }}` role for the disk from a user with the `ajel6l0jcb9s********` ID:

     ```bash
     yc compute disk remove-access-binding my-disk \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To revoke a role assigned for a disk using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section specifying the role:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "sa-access" {
        disk_id = "<disk_ID>"
        role    = "<role>"
        members = ["<subject_type>:<subject_ID>"]
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/) command:

      ```bash
      yc compute disk list-access-bindings <disk_ID>
      ```

- API {#api}

  To revoke roles for a disk, use the [updateAccessBindings](../../api-ref/Disk/updateAccessBindings.md) REST API method for the [Disk](../../api-ref/Disk/) resource or the [DiskService/UpdateAccessBindings](../../api-ref/grpc/Disk/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID under `subject`.

{% endlist %}
