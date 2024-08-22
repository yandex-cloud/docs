# Revoking a role for a resource

You can prevent a [subject](../../../iam/concepts/access-control/index.md#subject) from accessing a resource. To do this, revoke the subject's [roles](../../../iam/concepts/access-control/roles.md) for that resource or the resources that the access rights are inherited from. For more information, see [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to revoke a role for a resource.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Select a [registry](../../concepts/registry.md) or [repository](../../concepts/repository.md) in it.
   1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Select a user from the list and click ![image](../../../_assets/console-icons/ellipsis.svg) next to the username.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
   1. Click ![image](../../../_assets/console-icons/xmark.svg) next to the role you wish to revoke.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View assigned roles:

      ```bash
      yc container <resource> list-access-bindings <resource_name_or_ID>
      ```

      Where:
      * `<resource>`: Resource type (`registry` or `repository`).
      * `<resource_name_or_ID>`: Name or ID of the resource the role is assigned for.

   1. Revoke a role:

      * User:

         ```bash
         yc container <resource> remove-access-binding <resource_name_or_ID> \
           --role <role> \
           --user-account-id <user_ID>
         ```

      * [Service account](../../../iam/concepts/users/service-accounts.md):

         ```bash
         yc container <resource> remove-access-binding <resource_name_or_ID> \
           --role <role> \
           --service-account-id <service_account_ID>
         ```

      * All authorized users (`allAuthenticatedUsers` system group):

         ```bash
         yc container <resource> remove-access-binding <resource_name_or_ID> \
           --role <role> \
           --all-authenticated-users
         ```

         Where:
         * `<resource>`: Resource type (`registry` or `repository`).
         * `<resource_name_or_ID>`: Name or ID of the resource you want to revoke the role for.
         * `<role_ID>`: [Role](../../security/index.md#service-roles) you want to revoke.

      **Example**

      The example below revokes the `container-registry.admin` role for `my-first-registry` from a user.

      ```bash
      yc container registry remove-access-binding my-first-registry \
        --role container-registry.admin \
        --user-account-id ajeugsk5ubk6********
      ```

      Result:

      ```bash
      done (9s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the fragment with the role assignment description.

     Example role assignment description in the {{ TF }} configuration:

       ```
       resource "yandex_container_registry_iam_binding" "registry_name" {
         registry_id = "<registry_ID>"
         role        = "<role>"

         members = [
           "userAccount:<user_ID>",
         ]
       }
       ```

     For more information about the `yandex_container_registry_iam_binding` resource, see the [provider documentation]({{ tf-provider-resources-link }}/container_registry_iam_binding).

  1. {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check that the role is revoked using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command:

     * Registry:

       ```bash
       yc container registry list-access-bindings <registry_name_or_ID>
       ```

     * Repository:

       ```bash
       yc container repository list-access-bindings <repository_name_or_ID>
       ```

- API {#api}

  [View](get-assigned-roles.md#cli) the roles assigned for resources.

  To revoke registry roles, use the [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateAccessBindings](../../api-ref/grpc/registry_service.md#UpdateAccessBindings) gRPC API call.

  To revoke repository roles, use the [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) REST API method for the [Repository](../../api-ref/Repository/index.md) resource or the [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/repository_service.md#UpdateAccessBindings) gRPC API call.

{% endlist %}

You can read more about role management in the {{ iam-full-name }} [documentation](../../../iam/concepts/index.md).
