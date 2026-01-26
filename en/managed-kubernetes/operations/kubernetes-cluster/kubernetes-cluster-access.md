---
title: Managing access to a {{ managed-k8s-full-name }} cluster
description: Follow this guide to configure {{ managed-k8s-name }} cluster access permissions.
---

# Managing {{ managed-k8s-name }} cluster access

You can assign a user or service account a [role that grants access to the {{ k8s }} API](../../security/index.md#k8s-api) of a specific [cluster](../../concepts/index.md#kubernetes-cluster).

This allows you to issue granular roles to various users and service accounts for access to individual clusters.

{% note warning %}

Note that besides the role that grants access to the cluster's {{ k8s }} API, the user also needs a minimum role for viewing folder resources, e.g., [k8s.viewer](../../security/index.md#k8s-viewer) (to view information about all clusters in the folder) or primitive [viewer](../../../iam/security/index.md#viewer) (to view all resources in the folder). 

For example, you can assign the [k8s.viewer](../../security/index.md#k8s-viewer) role for a folder and the [k8s.cluster-api.editor](../../security/index.md#k8s-cluster-api-editor) role to manage {{ k8s }} resources of a specific cluster. This way, the user can view information about all clusters in the folder but only access the API of a specific cluster.

To manage user view permissions for cluster lists, we recommend using different folders in your cloud.

{% endnote %}

## Getting a list of roles assigned for a cluster {#list-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. To get a list of clusters in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), run this command:

      ```bash
      {{ yc-k8s }} cluster list
      ```
  
  1. To get a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```

{% endlist %}

## Assigning a role {#add-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for assigning a role for a cluster:
  
      ```bash
      {{ yc-k8s }} cluster add-access-binding --help
      ```
  
  1. Use this command to assign a role:

      ```bash
      {{ yc-k8s }} cluster add-access-binding <cluster_name_or_ID> \
        --role <role> \
        --subject <subject_type>:<subject_ID>
      ```
      
      Where:

      * `--role`: [Role](../../security/index.md#roles-list) being assigned, e.g., `k8s.cluster-api.editor`.
      * `--subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) you are assigning the role to, in `<subject_type>:<subject_ID>` format.

        Here is an example: 
        
        * `serviceAccount:aje6p030************`
        * `userAccount:aje8tj79************`
        * `system:allAuthenticatedUsers`

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

  1. To view a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```      

- {{ TF }} {#tf}

  {% note warning %}
    
  Do not use the `yandex_kubernetes_cluster_iam_member` resource to assign roles managed by `yandex_kubernetes_cluster_iam_binding`.
    
  {% endnote %} 
  
  1. Open the current configuration file with the {{ managed-k8s-name }} cluster description.
  
      For more information about creating this file, see [{#T}](kubernetes-cluster-create.md).
  
  1. Add a resource description:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<local_resource_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role>"
        member     = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
      * `role`: [Role](../../security/index.md#roles-list) being assigned, e.g., `k8s.cluster-api.editor`.
      * `member`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) you are assigning the role to, in `<subject_type>:<subject_ID>` format.
    
        Here is an example: 
        
        * `serviceAccount:${yandex_iam_service_account.k8s_sa.id}`
        * `userAccount:ajerq94v************`
        * `system:allAuthenticatedUsers`

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
      
      For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-cluster }}).

  1. To view a list of roles assigned for the cluster, run this [CLI](../../../cli/) command:
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```

{% endlist %}

## Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% note alert %}

  The `set-access-bindings` command deletes all roles assigned for the cluster and assigns new ones.
  
  {% endnote %}  

  1. To view a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```
  
  1. View the description of the CLI command for assigning roles for a cluster:
  
      ```bash
      {{ yc-k8s }} cluster set-access-bindings --help
      ```

  1. To assign roles, run this command:

      ```bash
      {{ yc-k8s }} cluster set-access-bindings <cluster_name_or_ID> \
        --access-binding role=<role_1>,subject=<subject_type>:<subject_1_ID> \
        --access-binding role=<role_2>,subject=<subject_type>:<subject_2_ID>
      ```
    
      Where `--access-binding` assigns a role to a subject. You can assign multiple roles at once by describing each of them in a separate `--access-binding` parameter.
      
        * `role`: [Role](../../security/index.md#roles-list) being assigned, e.g., `k8s.cluster-api.editor`.
        * `subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) you are assigning the role to, in `<subject_type>:<subject_ID>` format.

          Here is an example:
          
          * `serviceAccount:aje6p030************`
          * `userAccount:aje8tj79************`
          * `system:allAuthenticatedUsers`

          {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

- {{ TF }} {#tf}

  {% note warning %}
    
  Do not use the `yandex_kubernetes_cluster_iam_member` resource to assign roles managed by `yandex_kubernetes_cluster_iam_binding`.
    
  {% endnote %} 

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
      For more information about creating this file, see [this guide](kubernetes-cluster-create.md).

  1. Add resource descriptions:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<resource_1_local_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role_1>"
        member     = "<subject_type>:<subject_ID>"
      }

      resource "yandex_kubernetes_cluster_iam_member" "<resource_2_local_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role_2>"
        member     = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
      * `role`: [Role](../../security/index.md#roles-list) being assigned, e.g., `k8s.cluster-api.editor`.
      * `member`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) you are assigning the role to, in `<subject_type>:<subject_ID>` format.
    
        Here is an example:
        
        * `serviceAccount:${yandex_iam_service_account.k8s_sa.id}`
        * `userAccount:ajerq94v************`
        * `system:allAuthenticatedUsers`

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
      
      For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-cluster }}).

  1. To view a list of roles assigned for the cluster, run this [CLI](../../../cli/) command:
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```

{% endlist %}

## Revoking a role {#remove-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. To view a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```
  
  1. View the description of the CLI command for revoking a role for a cluster:
  
      ```bash
      {{ yc-k8s }} cluster remove-access-binding --help
      ```
  1. To revoke a role, run this command:

      ```bash
      {{ yc-k8s }} cluster remove-access-binding <cluster_name_or_ID> \
        --role <role> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: [Role](../../security/index.md#roles-list) being revoked, e.g., `k8s.cluster-api.editor`.
      * `--subject`: Type and ID of the [subject](../../../iam/concepts/access-control/index.md#subject) the role is assigned to, in `<subject_type>:<subject_ID>` format.

        Here is an example:
        
        * `serviceAccount:aje6p030************`
        * `userAccount:aje8tj79************`
        * `system:allAuthenticatedUsers`

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}


- {{ TF }} {#tf}

  {% note warning %}
    
  Do not use the `yandex_kubernetes_cluster_iam_member` resource to assign roles managed by `yandex_kubernetes_cluster_iam_binding`.
    
  {% endnote %} 

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
      For more information about creating this file, see [this guide](kubernetes-cluster-create.md).

  1. Find the description of the resource with the role you want to revoke and delete this description:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<local_resource_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role>"
        member     = "<subject_type>:<subject_ID>"
      }
      ```

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
      
      For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-cluster }}).

  1. To view a list of roles assigned for the cluster, run this [CLI](../../../cli/) command:
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```

{% endlist %}

## Examples {#examples}

### Granting cluster management access to a service account {#sa-cluster-control}

1. To enable a service account to view information about all {{ managed-k8s-name }} clusters in the folder but only modify {{ k8s }} resources in one specific cluster, assign it the `k8s.viewer` role for the folder and the `k8s.cluster-api.editor` role for that cluster:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Assign the role for the folder:
  
          ```bash
          yc resource-manager folder add-access-binding \
            --id <folder_ID> \
            --role k8s.viewer \
            --subject=serviceAccount:<service_account_ID>
          ```

      1. Assign the roles for the cluster:

          ```bash
          {{ yc-k8s }} cluster set-access-bindings <cluster_name_or_ID> \
            --access-binding role=k8s.cluster-api.editor,subject=serviceAccount:<service_account_ID>
          ```

    - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file describing your infrastructure.
  
          For information on how to create this file, see [Creating a cluster](kubernetes-cluster-create.md).

      1. Add resource descriptions:

          ```hcl
          resource "yandex_resourcemanager_folder_iam_member" "k8s-viewer-account-iam" {
            folder_id   = "<folder_ID>"
            role        = "k8s.viewer"
            member      = "serviceAccount:<service_account_ID>"
          }

          resource "yandex_kubernetes_cluster_iam_member" "k8s-cluster-api-editor" {
            cluster_id = "<cluster_ID>"
            role       = "k8s.cluster-api.editor"
            member     = "serviceAccount:<service_account_ID>"
          }
          ```

      1. Make sure the configuration files are correct.

          {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

          {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

1. To view a list of roles assigned for the cluster, run this [CLI](../../../cli/) command:

    ```bash
    {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
    ```
