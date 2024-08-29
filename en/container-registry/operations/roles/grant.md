---
title: "How to assign roles for a resource in {{ container-registry-full-name }}"
description: "Follow this guide to assign roles for a resource."
---

# Assigning a role for a resource

To grant access to a [resource](../../../iam/concepts/access-control/resources-with-access-control.md), assign the subject a [role](../../../iam/concepts/access-control/roles.md) for the resource itself or a resource from which access permissions are inherited, e.g., a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud). For the current list of resources you can assign roles for, see [{#T}](../../security/index.md#resources).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to assign a role for a resource.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Select a [registry](../../concepts/registry.md) or [repository](../../concepts/repository.md) in it.
   1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the window that opens, select a group, user, or [service account](../../../iam/concepts/users/service-accounts.md).
   1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the role from the list.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a role for a resource, run the following command:

   * User:

      ```bash
      yc container <resource> add-access-binding <resource_name_or_ID> \
        --role <role> \
        --user-account-id <user_ID>
      ```

   * [Service account](../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc container <resource> add-access-binding <resource_name_or_ID> \
        --role <role> \
        --service-account-id <service_account_ID>
      ```

   * All authorized users (the `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md)):

      ```bash
      yc container <resource> add-access-binding <resource_name_or_ID> \
        --role <role> \
        --all-authenticated-users
      ```

      Where:
      * `<resource>`: Resource type (`registry` or `repository`).
      * `<resource_name_or_ID>`: Name or ID of the resource to assign the role for.
      * `<role>`: [Role](../../security/index.md#service-roles) you want to assign.

   **Example**

   In the example below, a user is assigned the `container-registry.admin` role for `my-first-registry`.

   ```bash
   yc container registry add-access-binding my-first-registry \
     --role container-registry.admin \
     --user-account-id ajeugsk5ubk6********
   ```

   Result:

   ```bash
   done (4s)
   ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Describe the following in a configuration file:
      * Parameters of the `yandex_container_registry_iam_binding` resource to assign a role for a [registry](../../concepts/registry.md):

         ```
         resource "yandex_container_registry_iam_binding" "registry_name" {
           registry_id = "<registry_ID>"
           role        = "<role>"

           members = [
             "userAccount:<user_ID>",
           ]
         }
         ```

         Where:
         * `registry_id`: ID of the registry for which a role is assigned. To find out the registry ID, [get a list of registries in the folder](../registry/registry-list.md#registry-list).
         * `role`: [Role](../../security/index.md#service-roles) you want to assign.
         * `members`: ID of the user, group, or service account the role is being assigned to.

      * Parameters of the `yandex_container_repository_iam_binding` resource to assign a role for a [repository](../../concepts/repository.md):

         ```
         resource "yandex_container_repository_iam_binding" "repository_name" {
           repository_id = "<repository_ID>"
           role          = "<role>"

           members = [
             "serviceAccount:<service_account_ID>",
           ]
         }
         ```

         Where:
         * `repository_id`: ID of the repository for which a role is assigned. To find out the ID of a repository, [get a list of repositories in the folder](../repository/repository-list.md#repository-list).
         * `role`: Role you want to assign.
         * `members`: ID of the user, group, or service account the role is being assigned to.

      For more information about the `yandex_container_repository_iam_binding` resource, see the [provider documentation]({{ tf-provider-resources-link }}/container_repository_iam_binding).

   1. {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   You can check that the role has been assigned using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command:

   * Registry:

      ```bash
      yc container registry list-access-bindings <registry_name_or_ID>
      ```

   * Repository:

      ```bash
      yc container repository list-access-bindings <repository_name_or_ID>
      ```

- API {#api}

   Use the [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateAccessBindings](../../api-ref/grpc/registry_service.md#UpdateAccessBindings) gRPC API call.

   Use the [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) REST API method for the [Repository](../../api-ref/Repository/index.md) resource or the [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/repository_service.md#UpdateAccessBindings) gRPC API call.

{% endlist %}
