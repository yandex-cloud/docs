---
title: How to assign roles for a resource in {{ container-registry-full-name }}
description: Follow this guide to assign roles for a resource.
---

# Assigning a role for a resource

{% include [sunset](../../../_includes/container-registry/sunset.md) %}

To grant access to a [resource](../../../iam/concepts/access-control/resources-with-access-control.md), assign a [role](../../../iam/concepts/access-control/roles.md) to a subject for the resource itself or for a resource from which access permissions are inherited, such as a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud). For the current list of resources you can assign roles for, see [{#T}](../../security/index.md#resources).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to assign a role for a resource.
  1. [Navigate]({{ link-console-main }}/link/container-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select a [registry](../../concepts/registry.md) or [repository](../../concepts/repository.md) in it.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. In the window that opens, select a group, user, or [service account](../../../iam/concepts/users/service-accounts.md).
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select role from the list.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run this command to assign a role for a resource:

  ```bash
  yc container <resource> add-access-binding <resource_name_or_ID> \
    --role <role> \
    --subject <subject_type>:<subject_ID>
  ```

  Where:

  * `<resource>`: `registry` or `repository` resource type.
  * `<resource_name_or_ID>`: Name or ID of the resource to assign the role for.
  * `--role`: [Role](../../security/index.md#service-roles) you want to assign.
  * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

      {% cut "Subject designations" %}

      {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}
  
  **Example**

  In the example below, we are assigning the `container-registry.admin` role for `my-first-registry` to a user.

  ```bash
  yc container registry add-access-binding my-first-registry \
    --role container-registry.admin \
    --subject userAccount:ajeugsk5ubk6********
  ```

  Result:

  ```text
  done (4s)
  ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the following in the configuration file:
     * The `yandex_container_registry_iam_binding` resource parameters to assign the role for the [registry](../../concepts/registry.md):

       ```
       resource "yandex_container_registry_iam_binding" "registry_name" {
         registry_id = "<registry_ID>"
         role        = "<role>"
       
         members = [
           "<subject_type>:<subject_ID>",
         ]
       }
       ```

       Where:
       * `registry_id`: ID of the registry for which the role is being assigned. To find out the registry ID, [get a list of registries in the folder](../registry/registry-list.md#registry-list).
       * `role`: [Role](../../security/index.md#service-roles) you want to assign.
       * `members`: List of designations of [subjects](../../../iam/concepts/access-control/index.md#subject) the role is assigned to.

           {% cut "Subject designations" %}

           {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

           {% endcut %}
     
     * The `yandex_container_repository_iam_binding` resource parameters to assign the role for the [repository](../../concepts/repository.md):

       ```
       resource "yandex_container_repository_iam_binding" "repository_name" {
         repository_id = "<repository_ID>"
         role          = "<role>"
       
         members = [
           "<subject_type>:<subject_ID>",
         ]
       }
       ```

       Where:
       * `repository_id`: ID of the repository for which you are assigning the role. To find out the repository ID, [get a list of repositories in the folder](../repository/repository-list.md#repository-list).
       * `role`: Role you want to assign.
       * `members`: List of designations of subjects getting the role.

           {% cut "Subject designations" %}

           {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

           {% endcut %}

     For more on the properties of the `yandex_container_repository_iam_binding` resource, see [this provider guide]({{ tf-provider-resources-link }}/container_repository_iam_binding).
  
  1. {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the role assignment using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     * Registry:

       ```bash
       yc container registry list-access-bindings <registry_name_or_ID>
       ```

     * Repository:

       ```bash
       yc container repository list-access-bindings <repository_name_or_ID>
       ```

- API {#api}

  To assign a role for a registry, use the [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md) gRPC API call.

  To assign a role for a repository, use the [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) REST API method for the [Repository](../../api-ref/Repository/index.md) resource or the [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/Repository/updateAccessBindings.md) gRPC API call.

  In the request body, set the `action` property to `ADD` and specify [subject](../../../iam/concepts/access-control/index.md#subject) type and ID in the `subject` property.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
