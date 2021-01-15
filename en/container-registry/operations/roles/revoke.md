# Revoking a role for a resource

You can prevent the [subject](../../../iam/concepts/access-control/index.md#subject) from accessing a resource. To do this, revoke the subject's roles for that resource or the resources that the access rights are inherited from. For more information, see [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to revoke a role for a resource.

  1. In the list of services, select **{{ container-registry-name }}**.

  1. Revoke a role for the resource.

     * Revoking a role for a registry:
       1. To the right of the registry name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Configure ACL**.
       1. In the window that opens, expand the drop-down list in the row with the name of the user whose permissions you want to revoke.
       1. Deselect the role that you want to revoke.
          To revoke all the user's permissions, click **Revoke**.
       1. Click **Save**.

     * Revoking a role for a repository:
       1. Select the desired registry.
       1. To the right of the desired repository name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Configure ACL**.
       1. In the window that opens, expand the drop-down list in the row with the name of the user whose permissions you want to revoke.
       1. Deselect the role that you want to revoke.
          To revoke all the user's permissions, click **Revoke**.
       1. Click **Save**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View assigned roles:

     ```bash
     yc <service name> <resource> list-access-bindings <resource name>|<resource ID>
     ```

     Where:
     * `<service name>`: Name of a `container` service.
     * `<resource>`: Category of the resource (`registry` or `repository`).
     * `<resource name>`: Name of the resource that the role is assigned for. You can specify a resource by its name or ID.
     * `<resource id>`: ID of the resource that the role is assigned for.

     >Example. View the roles for the registry with the ID `crp0pmf1n68dh715tf02`:
     >
     >```bash
     >yc container registry list-access-bindings crp0pmf1n68dh715tf02
     >```
     >
     >Command execution result:
     >
     >```bash
     >+--------------------------+--------------+----------------------+
     >|         ROLE ID          | SUBJECT TYPE |      SUBJECT ID      |
     >+--------------------------+--------------+----------------------+
     >| container-registry.admin | userAccount  | kolhpriseeioo9dc3v24 |
     >+--------------------------+--------------+----------------------+
     >```

  1. Revoke the role:

     ```bash
     yc <service name> <resource> remove-access-binding <resource name>|<resource ID> \
       --role <role ID> \
       --subject userAccount:<user ID>
     ```

     Where:
     * `<service name>`: Name of a `container` service.
     * `<resource>`: Category of the resource (`registry` or `repository`).
     * `<resource name>`: Name of the resource the role is revoked for. You can specify a resource by its name or ID.
     * `<resource id>`: ID of the resource the role is revoked for.
     * `<role id>`: ID of the role.
     * `<user id>`: ID of the group, user, or service account that the role is revoked from.

     >Example. Revoke the role `container-registry.admin` for the registry with the ID `crp0pmf1n68dh715tf02` from the user with the ID `kolhpriseeioo9dc3v24`:
     >
     >```bash
     >yc container registry remove-access-binding crp0pmf1n68dh715tf02 \
     >  --role container-registry.admin \
     >  --subject userAccount:kolhpriseeioo9dc3v24
     >```

- API

  Use the method `listAccessBindings` to view the roles assigned for the resources `registry` and `repository`.

  Use the method `updateAccessBindings` to revoke the role for the resources `registry` and `repository`.

{% endlist %}

Read more about role management in the [documentation](../../../iam/concepts/index.md) for {{ iam-full-name }}.

