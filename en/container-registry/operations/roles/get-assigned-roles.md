# Viewing roles for a resource

To view assigned [roles](../../../iam/concepts/access-control/roles.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you wish to view resource roles.
  1. In the list of services, select **{{ container-registry-name }}**.
  1. View the roles assigned for a resource:
     * Viewing roles for a [registry](../../concepts/registry.md):
       1. To the right of the desired registry name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Registry ACL**.
       1. In the window that opens, you can see a list of users and their permissions for the registry.
     * Viewing roles for a repository:
       1. Select the desired registry.
       1. To the right of the repository name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Configure ACL**.
       1. In the window that opens, you can see a list of users and their permissions for the repository.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run the command:

  ```bash
  yc <service name> <resource> list-access-bindings <resource name>|<resource ID>
  ```

  Where:
  * `<service name>`: Name of a `container` service.
  * `<resource>`: Category of the resource (`registry` or `repository`).
  * `<resource name>`: Name of the resource that the role is assigned for. You can specify a resource by its name or ID.
  * `<resource id>`: ID of the resource that the role is assigned for.

  > Example. View the roles for the registry with the ID `crp0pmf1n68dh715tf02`:
  >
  > ```bash
  > yc container registry list-access-bindings crp0pmf1n68dh715tf02
  > ```
  >
  > Command result:
  >
  > ```bash
  > +--------------------------+------------------+----------------------+
  > |         ROLE ID          |   SUBJECT TYPE   |      SUBJECT ID      |
  > +--------------------------+------------------+----------------------+
  > | container-registry.admin | federatedAccount | kolhpriseeioo9dc3v24 |
  > +--------------------------+------------------+----------------------+
  > ```

- API

  Use the method `listAccessBindings` for the resources `registry` and `repository`.

{% endlist %}

Read more about role management in the {{ iam-full-name }} [documentation](../../../iam/concepts/index.md).