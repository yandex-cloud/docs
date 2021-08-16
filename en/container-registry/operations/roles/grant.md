# Assigning a role for a resource

To grant access to a resource, assign a [role](../../../iam/concepts/access-control/roles.md) to the subject for that resource or the resource that the access rights are inherited from (such as a folder or cloud). For more information, see [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to assign a role for the resource.

  1. In the list of services, select **{{ container-registry-name }}**.

  1. Assign a role for the resource.

     * Assigning roles for a registry:
       1. To the right of the registry name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Configure ACL**.
       1. In the window that opens, select a group, user, or system account and click **Add**.
       1. In the **Permissions** drop-down list, select the desired roles.
       1. Click **Save**.

     * Assigning roles for a repository:
       1. Select the desired registry.
       1. To the right of the desired repository name, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Configure ACL**.
       1. In the window that opens, select a group, user, or system account and click **Add**.
       1. In the **Permissions** drop-down list, select the desired roles.
       1. Click **Save**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Select a role from the [list](../../security/index.md#service-roles).

  1. Assign the role.

     * To add the role to the existing permissions, run the command:

       ```bash
       yc <service name> <resource> add-access-binding <resource name>|<resource ID> \
         --role <role ID> \
         --subject userAccount:<user ID>
       ```

     * To add the role and delete all the existing permissions, run the command:

       ```bash
       yc <service name> <resource> set-access-bindings <resource name>|<resource ID> \
         --role <role ID> \
         --subject userAccount:<user ID>
       ```

     Where:
     * `<service name>`: Name of a `container` service.
     * `<resource>`: Category of the resource (`registry` or `repository`).
     * `<resource name>`: Name of the resource that the role is assigned for. You can specify a resource by its name or ID.
     * `<resource id>`: ID of the resource that the role is assigned for.
     * `<role id>`: ID of the role.
     * `<user id>`: ID of the group, user, or service account that is assigned the role.

     >Example. Add the role `container-registry.admin` for the registry with the ID `crp0pmf1n68dh715tf02` to the user with the ID `kolhpriseeioo9dc3v24`:
     >
     >```bash
     >yc container registry add-access-binding crp0pmf1n68dh715tf02 \
     >  --role container-registry.admin \
     >  --subject userAccount:kolhpriseeioo9dc3v24
     >```

- API

  Use the method `updateAccessBindings` for the resources `registry` and `repository`.

{% endlist %}

Read more about role management in the [documentation](../../../iam/concepts/index.md) for {{ iam-full-name }}.

