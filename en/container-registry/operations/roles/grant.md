# Assigning a role for a resource

To provide access to a [resource](../../../iam/concepts/access-control/resources-with-access-control.md), assign a user a [role](../../../iam/concepts/access-control/roles.md) to the resource itself or a resource from which access privileges are inherited, such as a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) or a [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud). For more information, see [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to assign a role for a resource.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Assign a role for the resource.
      * Assigning roles for a [registry](../../concepts/registry.md):
         1. To the right of the registry name, click ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.cr.registry.overview.button_registry-acl }}**.
         1. In the window that opens, select a group, a user, or a [service account](../../../iam/concepts/users/service-accounts.md) and click **{{ ui-key.yacloud.common.add }}**.
         1. In the **{{ ui-key.yacloud.component.acl-dialog.column_permissions }}** drop-down list, select the required roles.
         1. Click **{{ ui-key.yacloud.common.save }}**.
      * Assigning roles for a [repository](../../concepts/repository.md):
         1. Select the repository.
         1. To the right of the repository name, click ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.cr.registry.overview.button_repository-acl }}**.
         1. In the window that opens, select a group, a user, or a service account and click **{{ ui-key.yacloud.common.add }}**.
         1. In the **{{ ui-key.yacloud.component.acl-dialog.column_permissions }}** drop-down list, select the required roles.
         1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Choose a role from the [list](../../security/index.md#service-roles).
   1. Assign the role:
      * To add the role to the existing permissions, run the command:

         
         ```bash
         yc <service_name> <resource> add-access-binding <resource_name_or_ID> \
           --role <role_ID> \
           --subject userAccount:<user_ID>
         ```



      * To add the role and delete all the existing permissions, run the command:

         
         ```bash
         yc <service_name> <resource> set-access-bindings <resource_name_or_ID> \
           --role <role_ID> \
           --subject userAccount:<user_ID>
         ```



      Where:
      * `<service_name>`: `Container` service name.
      * `<resource>`: Category of the resource (`registry` or `repository`).
      * `<resource_name_or_ID>`: Name or ID of the resource the role is assigned for.
      * `--role`: Role ID.
      * `--subject`: ID of the group, user, or service account the role is assigned to.

      > Example. Add the `container-registry.admin` role for the registry with the `crp0pmf1n68d********` ID to the user with the `kolhpriseeio********` ID:
      >

      
      > ```bash
      > yc container registry add-access-binding crp0pmf1n68d******** \
      >   --role container-registry.admin \
      >   --subject userAccount:kolhpriseeio********
      > ```



- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}
   1. Describe the following in a configuration file:
      * Parameters of the `yandex_container_registry_iam_binding` resource to assign a role for a registry:
         * `registry_id`: ID of the registry for which a role is assigned. You can retrieve registry ID from the [folder registry list](../registry/registry-list.md#registry-list).
         * `role`: Role ID.
         * `members`: ID of the user, group, or service account the role is being assigned to.

         > Here is an example of the configuration file structure:
         >

         
         > ```
         > resource "yandex_container_registry_iam_binding" "puller" {
         >  registry_id = "<registry_ID>"
         >  role        = "<role_ID>"
         >
         >  members = [
         >    "userAccount:<user_ID>",
         >  ]
         > }
         > ```



         For more information about the `yandex_container_registry_iam_binding` resource, see the [provider documentation]({{ tf-provider-resources-link }}/container_registry_iam_binding).
      * Parameters of the `yandex_container_repository_iam_binding` resource to assign a role for a repository:
         * `repository_id`: ID of the repository for which a role is assigned.
         * `role`: Role ID.
         * `members`: ID of the user, group, or service account the role is being assigned to.

         > Here is an example of the configuration file structure:
         >

         
         > ```
         > resource "yandex_container_repository_iam_binding" "pusher" {
         >  repository_id = "<repository_ID>"
         >  role          = "<role_ID>"
         >
         >  members = [
         >    "userAccount:<user_ID>",
         >  ]
         > }
         > ```



         For more information about the `yandex_container_repository_iam_binding` resource, see the [provider documentation]({{ tf-provider-resources-link }}/container_repository_iam_binding).
   1. Run a check using this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. This is a test step; no resources will be created. If the configuration contains any errors, {{ TF }} will point them out.

      {% note alert %}

      You will be charged for all the resources created with {{ TF }}. Check the pricing plan carefully.

      {% endnote %}

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm changing the resources: enter `yes` in the terminal window and press **Enter**.

      You can check that the role has been assigned using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command:
      * Registry:

         ```bash
         yc container registry list-access-bindings <registry_name_or_ID>
         ```

      * Repository:

         ```
         yc container repository list-access-bindings <repository_name_or_ID>
         ```

- API {#api}

   To assign a user, service account, or group a role for access to a resource, use the `updateAccessBindings` method for the `registry` and `repository` resources.

{% endlist %}

Read more about role management in the {{ iam-full-name }} [documentation](../../../iam/concepts/index.md).