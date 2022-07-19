# Assigning a role for a resource

To provide access to a [resource](../../../iam/concepts/access-control/resources-with-access-control.md), assign a user a [role](../../../iam/concepts/access-control/roles.md) to the resource itself or a resource from which access privileges are inherited, such as a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) or a [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud). For more information, see [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to assign a role for a resource.
   1. In the list of services, select **{{ container-registry-name }}**.
   1. Assign a role for the resource.
      * Assigning roles for a [registry](../../concepts/registry.md):
         1. To the right of the desired registry name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Registry ACL**.
         1. In the resulting window, select a group, a user, or a [service account](../../../iam/concepts/users/service-accounts.md) and click **Add**.
         1. In the **Permissions** drop-down list, select the desired roles.
         1. Click **Save**.
      * Assigning roles for a [repository](../../concepts/repository.md):
         1. Select the desired repository.
         1. To the right of the repository name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Configure ACL**.
         1. In the resulting window, select a group, a user, or a service account and click **Add**.
         1. In the **Permissions** drop-down list, select the desired roles.
         1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Choose a role from the [list](../../security/index.md#service-roles).
   1. Assign the role:
      * To add the role to the existing permissions, run the command:

        {% if product == "yandex-cloud" %}
        
         ```bash
         yc <service name> <resource> add-access-binding <resource name>|<resource id> \
           --role <role id> \
           --subject userAccount:<user id>
         ```
        
        {% endif %}

        {% if product == "cloud-il" %}

         ```bash
         yc <service name> <resource> add-access-binding <resource name>|<resource id> \
           --role <role id> \
           --subject federatedAccount:<user id>
         ```

        {% endif %}

      * To add the role and delete all the existing permissions, run the command:

        {% if product == "yandex-cloud" %}

         ```bash
         yc <service name> <resource> set-access-bindings <resource name>|<resource id> \
           --role <role id> \
           --subject userAccount:<user id>
         ```
        
        {% endif %}

        {% if product == "cloud-il" %}

         ```bash
         yc <service name> <resource> set-access-bindings <resource name>|<resource id> \
           --role <role id> \
           --subject federatedAccount:<user id>
         ```

        {% endif %}
    
      Where:

      * `<service name>`: Name of a `container` service.
      * `<resource>`: Category of the resource (`registry` or `repository`).
      * `<resource name>`: Name of the resource that the role is assigned for. You can specify a resource by its name or ID.
      * `<resource id>`: ID of the resource that the role is assigned for.
      * `<role id>`: ID of the role.
      * `<user id>`: ID of the group, user, or service account that is assigned the role.

      > Example. Add the role `container-registry.admin` for the registry with the ID `crp0pmf1n68dh715tf02` to the user with the ID `kolhpriseeioo9dc3v24`:
      > 
{% if product == "yandex-cloud" %}
      > ```bash
      > yc container registry add-access-binding crp0pmf1n68dh715tf02 \
      >  --role container-registry.admin \
      >  --subject userAccount:kolhpriseeioo9dc3v24
      > ```
{% endif %}
{% if product == "cloud-il" %}
      > ```bash
      > yc container registry add-access-binding crp0pmf1n68dh715tf02 \
      >  --role container-registry.admin \
      >  --subject federatedAccount:kolhpriseeioo9dc3v24
      > ```
{% endif %}

- API

   Use the method `updateAccessBindings` for the resources `registry` and `repository`.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe in a configuration file:
      * The parameters of the `yandex_container_registry_iam_binding` resource to assign a role to the registry:
         * `registry_id`: ID of the registry to which a role is being assigned. You can retrieve the registry ID from the [folder registry list](../registry/registry-list.md#registry-list).
         * `role`: Role ID.
         * `members`: ID of the user, group, or service account the role is being assigned to.

         > Example configuration file structure:
         >
{% if product == "yandex-cloud" %} 
         > ```
         > resource "yandex_container_registry_iam_binding" "puller" {
         >   registry_id = "<registry id>"
         >   role        = "<role id>"
         >
         >   members = [
         >      "userAccount:<user id>",
         >  ]
         > }
         > ```
{% endif %}
{% if product == "cloud-il" %}
         > ```
         > resource "yandex_container_registry_iam_binding" "puller" {
         >   registry_id = "<registry id>"
         >   role        = "<role id>"
         >
         >   members = [
         >      "federatedAccount:<user id>",
         >  ]
         > }
         > ```
{% endif %}

         For more information about the `yandex_container_registry_iam_binding` resource, see the [provider documentation]({{ tf-provider-link }}/container_registry_iam_binding).
      * `yandex_container_repository_iam_binding` resource parameters to assign a role to a repository:
         * `repository_id`: ID of the repository to which a role is being assigned.
         * `role`: Role ID.
         * `members`: ID of the user, group, or service account the role is being assigned to.

         > Example configuration file structure:
         >
{% if product == "yandex-cloud" %}
         > ```
         > resource "yandex_container_repository_iam_binding" "pusher" {
         >   repository_id = "<repository id>"
         >   role          = "<role id>"
         >
         >   members = [
         >      "userAccount:<user id>",
         >  ]
         > }
         > ```
{% endif %}
{% if product == "cloud-il" %}
         > ```
         > resource "yandex_container_repository_iam_binding" "pusher" {
         >   repository_id = "<repository id>"
         >   role          = "<role id>"
         >
         >   members = [
         >      "federatedAccount:<user id>",
         >  ]
         > }
         > ```
{% endif %}  

         For more information about the `yandex_container_repository_iam_binding` resource, see the [provider documentation]({{ tf-provider-link }}/container_repository_iam_binding).

   1. Run the check using the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. This is a test step. No resources are created. If the configuration contain errors, {{ TF }} will point them out.

      {% note alert %}

      You will be charged for all the resources created with {{ TF }}. Check the plan carefully.

      {% endnote %}

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the resource change: enter `yes` in the terminal window and press **Enter**.

      You can check that the role has been assigned using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command:
      * Registry:

         ```bash
         yc container registry list-access-bindings <registry id>/<registry name>
         ```

      * Repository:

         ```
         yc container repository list-access-bindings <repository id>/<repository name>
         ```

{% endlist %}

Read more about role management in the {{ iam-full-name }} [documentation](../../../iam/concepts/index.md).