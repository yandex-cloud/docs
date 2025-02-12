---
title: Configuring access permissions for a {{ compute-name }} GPU cluster
description: Follow this guide to configure GPU cluster access permissions.
---

# Configuring GPU cluster access permissions


To grant a user, group, or [service account](../../../iam/concepts/users/service-accounts.md) access to a [GPU cluster](../../concepts/gpus.md), assign a [role](../../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#add-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the GPU cluster.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Select the GPU cluster you need.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account you want to grant access to the GPU cluster.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [role](../../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for assigning a role for a GPU cluster:

     ```bash
     yc compute gpu-cluster add-access-binding --help
     ```

  1. Get a list of GPU clusters in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute gpu-cluster list
     ```

  1. View a list of roles already assigned for the resource in question:

     ```bash
     yc compute gpu-cluster list-access-bindings <GPU_cluster_ID>
     ```

  1. Assign the role using this command:

     * To a user:

       ```bash
       yc compute gpu-cluster add-access-binding <GPU_cluster_ID> \
         --user-account-id <user_ID> \
         --role <role>
       ```

       Where:

       * `--user-account-id`: [User ID](../../../iam/operations/users/get.md). To assign a role to all authenticated users, use the `--all-authenticated-users` flag.
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

     * To a service account:

       ```bash
       yc compute gpu-cluster add-access-binding <GPU_cluster_ID> \
         --service-account-id <service_account_ID> \
         --role <role>
       ```

       Where:

       * `--service-account-id`: [Service account ID](../../../iam/operations/sa/get-id.md).
       * `--role`: [Role](../../security/index.md#roles-list) to assign.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign a role to access a GPU cluster using {{ TF }}:

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_gpu_cluster_iam_binding" "sa-access" {
        gpu_cluster_id = "<GPU_cluster_ID>"
        role           = "<role>"
        members        = ["<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `gpu_cluster_id`: GPU cluster ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) getting the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_gpu_cluster_iam_binding` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_gpu_cluster_iam_binding).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

       ```bash
       yc compute gpu-cluster list-access-bindings <GPU_cluster_ID>
       ```


- API {#api}

  To assign a role, use the [updateAccessBindings](../../api-ref/GpuCluster/updateAccessBindings.md) REST API method for the [GpuCluster](../../api-ref/GpuCluster/index.md) resource or the [GpuClusterService/UpdateAccessBindings](../../api-ref/grpc/GpuCluster/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID under `subject`.

{% endlist %}

## Assigning multiple roles {#set-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the GPU cluster.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Select the GPU cluster you need.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the group, user, or service account you want to grant access to the GPU cluster.
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
     yc compute gpu-cluster list-access-bindings <GPU_cluster_ID>
     ```

  1. See the description of the CLI command for assigning roles for a GPU cluster:

     ```bash
     yc compute gpu-cluster set-access-bindings --help
     ```

  1. Assign roles:

     ```bash
     yc compute gpu-cluster set-access-bindings <GPU_cluster_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--access-binding`: Parameters for setting access permissions:

       * `role`: [Role](../../security/index.md#roles-list) to assign.
       * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, this command will assign roles to multiple users and a single service account:

     ```bash
     yc compute gpu-cluster set-access-bindings my-gpu-cluster \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign multiple roles for a file storage using {{ TF }}:

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_gpu_cluster_iam_binding" "role1" {
        gpu_cluster_id = "<GPU_cluster_ID>"
        role           = "<role_1>"
        members        = ["<subject_type>:<subject_ID>"]
      }
      
      resource "yandex_compute_gpu_cluster_iam_binding" "role2" {
        gpu_cluster_id = "<GPU_cluster_ID>"
        role           = "<role_2>"
        members        = ["<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `gpu_cluster_id`: GPU cluster ID.
      * `role`: [Role](../../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../../iam/concepts/access-control/index.md#subject) getting the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_compute_gpu_cluster_iam_binding` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_gpu_cluster_iam_binding).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

       ```bash
       yc compute gpu-cluster list-access-bindings <GPU_cluster_ID>
       ```


- API {#api}

  To assign roles for a GPU cluster, use the [setAccessBindings](../../api-ref/GpuCluster/setAccessBindings.md) REST API method for the [GpuCluster](../../api-ref/GpuCluster/index.md) resource or the [GpuClusterService/SetAccessBindings](../../api-ref/grpc/GpuCluster/setAccessBindings.md) gRPC API call.

  {% note alert %}

  The `set-access-binding` method and the `GpuClusterService/SetAccessBindings` call completely overwrite access permissions for the resource. All current roles for the resource will be deleted.

  {% endnote %}

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the GPU cluster.
  1. Select **{{ ui-key.yacloud.compute.label_service }}**.
  1. In the left-hand panel, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Select the GPU cluster you need.
  1. Go to the ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. In the line with the user in question, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Next to the role, click ![image](../../../_assets/cross.svg).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for revoking a role for a GPU cluster:

     ```bash
     yc compute gpu-cluster remove-access-binding --help
     ```

  1. View the roles and assignees for the resource:

     ```bash
     yc compute gpu-cluster list-access-bindings <GPU_cluster_ID>
     ```

  1. To revoke access permissions, run this command:

     ```bash
     yc compute gpu-cluster remove-access-binding <GPU_cluster_ID> \
       --role=<role> \
       --subject=<subject_type>:<subject_ID> \
     ```

     Where:

     * `--role`: ID of the role to revoke.
     * `--subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) to revoke the role from.

     For example, this command revokes the `{{ roles-viewer }}` role for the GPU cluster from a user with the `ajel6l0jcb9s********` ID:

     ```bash
     yc compute gpu-cluster remove-access-binding my-gpu-cluster \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To revoke a role assigned for a GPU cluster using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section specifying the role:

      ```hcl
      resource "yandex_compute_gpu_cluster_iam_binding" "sa-access" {
        gpu_cluster_id = "<GPU_cluster_ID>"
        role           = "<role>"
        members        = ["<subject_type>:<subject_ID>"]
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

       ```bash
       yc compute gpu-cluster list-access-bindings <GPU_cluster_ID>
       ```

- API {#api}

  To revoke a role, use the [updateAccessBindings](../../api-ref/GpuCluster/updateAccessBindings.md) REST API method for the [GpuCluster](../../api-ref/GpuCluster/index.md) resource or the [GpuClusterService/UpdateAccessBindings](../../api-ref/grpc/GpuCluster/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID under `subject`.

{% endlist %}
