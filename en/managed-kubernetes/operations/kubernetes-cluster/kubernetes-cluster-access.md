---
title: Managing access to a {{ managed-k8s-full-name }} cluster
description: Follow this guide to configure {{ managed-k8s-name }} cluster access permissions.
---

# Managing access to a {{ managed-k8s-name }} cluster

To grant a [subject](../../../iam/concepts/access-control/index.md#subject) access to a [cluster](../../concepts/index.md#kubernetes-cluster), assign them a [role](../../../iam/concepts/access-control/roles.md) for the cluster.

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
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```
      
      Where:

      * `--role`: ID of the [role](../../security/index.md#roles-list) to assign.
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
        role       = "<role_ID>"
        member     = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
      * `role`: ID of the [role](../../security/index.md#roles-list) to assign.
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
      
      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

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
  
  1. See the description of the CLI command for assigning roles for a cluster:
  
      ```bash
      {{ yc-k8s }} cluster set-access-bindings --help
      ```

  1. To assign roles, run this command:

      ```bash
      {{ yc-k8s }} cluster set-access-bindings <cluster_name_or_ID> \
        --access-binding role=<role_1_ID>,subject=<subject_type>:<subject_1_ID> \
        --access-binding role=<role_2_ID>,subject=<subject_type>:<subject_2_ID>
      ```
    
      Where `--access-binding` assigns a role to a subject. You can assign multiple roles at once by describing each of them in a separate `--access-binding` parameter.
      
        * `role`: ID of the [role](../../security/index.md#roles-list) to assign.
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

  1. Open the current {{ TF }} configuration file that defines your infrastructure.
  
      For more information about creating this file, see [Creating clusters](kubernetes-cluster-create.md).

  1. Add resource descriptions:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<resource_1_local_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role_1_ID>"
        member     = "<subject_type>:<subject_ID>"
      }

      resource "yandex_kubernetes_cluster_iam_member" "<resource_2_local_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role_2_ID>"
        member     = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
      * `role`: ID of the [role](../../security/index.md#roles-list) to assign.
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
      
      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

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
  
  1. See the description of the CLI command for revoking a role for a cluster:
  
      ```bash
      {{ yc-k8s }} cluster remove-access-binding --help
      ```
  1. To revoke a role, run this command:

      ```bash
      {{ yc-k8s }} cluster remove-access-binding <cluster_name_or_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: ID of the [role](../../security/index.md#roles-list) to revoke.
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

  1. Open the current {{ TF }} configuration file that defines your infrastructure.
  
      For more information about creating this file, see [Creating clusters](kubernetes-cluster-create.md).

  1. Find the description of the resource with the role you want to revoke and delete this description:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<local_resource_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role_ID>"
        member     = "<subject_type>:<subject_ID>"
      }
      ```

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
      
      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

  1. To view a list of roles assigned for the cluster, run this [CLI](../../../cli/) command:
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <cluster_name_or_ID>
      ```

{% endlist %}