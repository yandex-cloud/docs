# Revoking a role for a resource

You can prevent a [subject](../../../iam/concepts/access-control/index.md#subject) from accessing a resource. To do this, revoke the subject's [roles](../../../iam/concepts/access-control/roles.md) for that resource or the resources that the access rights are inherited from. For more information, see [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to revoke a role for a resource.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Revoke a role for the resource.
      * Revoking a role for a registry:
         1. To the right of the registry name, click ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.cr.registry.overview.button_registry-acl }}**.
         1. In the window that opens, expand the drop-down list in the row with the name of the user whose permissions you want to revoke.
         1. Deselect the role that you want to revoke.

            To revoke all the user's permissions, click **{{ ui-key.yacloud.component.acl-dialog.button_revoke }}**.
         1. Click **{{ ui-key.yacloud.common.save }}**.
      * Revoking a role for a repository:
         1. Select the registry.
         1. To the right of the repository name, click ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.cr.registry.overview.button_repository-acl }}**.
         1. In the window that opens, expand the drop-down list in the row with the name of the user whose permissions you want to revoke.
         1. Deselect the role that you want to revoke.

            To revoke all the user's permissions, click **{{ ui-key.yacloud.component.acl-dialog.button_revoke }}**.
         1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View assigned roles:

      ```bash
      yc <service_name> <resource> list-access-bindings <resource_name_or_ID>
      ```

      Where:
      * `<service_name>`: `Container` service name.
      * `<resource>`: Category of the resource (`registry` or `repository`).
      * `<resource_name_or_ID>`: Name or ID of the resource the role is assigned for. You can specify a resource by its name or ID.

      > Example. View the roles for the registry with the `crp0pmf1n68d********` ID:
      >
      > ```bash
      > yc container registry list-access-bindings crp0pmf1n68d********
      > ```
      >
      > Result:
      >
      > ```bash
      > +--------------------------+------------------+----------------------+
      > |         ROLE ID          |   SUBJECT TYPE   |      SUBJECT ID      |
      > +--------------------------+------------------+----------------------+
      > | container-registry.admin | federatedAccount | kolhpriseeio******** |
      > +--------------------------+------------------+----------------------+
      > ```

   1. Revoke a role:

      
      ```bash
      yc <service_name> <resource> remove-access-binding <resource_name_or_ID> \
        --role <role_ID> \
        --subject userAccount:<user_ID>
      ```



      Where:
      * `<service_name>`: `Container` service name.
      * `<resource>`: Category of the resource (`registry` or `repository`).
      * `<resource_name_or_ID>`: Name or ID of the resource you revoke a role from. You can specify a resource by its name or ID.
      * `--role`: Role ID.
      * `--subject`: ID of the group, user, or service account you revoke a role from.

      > Example. Revoke the `container-registry.admin` role for the registry with the `crp0pmf1n68d********` ID from the user with the `kolhpriseeio********` ID:
      >

      
      > ```bash
      > yc container registry remove-access-binding crp0pmf1n68d******** \
      >  --role container-registry.admin \
      >  --subject userAccount:kolhpriseeio********
      > ```



- API {#api}

   Use the `listAccessBindings` method to view the roles assigned for the `registry` and `repository` resources.

   Use the `updateAccessBindings` method to revoke the role for the `registry` and `repository` resources.

{% endlist %}

Read more about role management in the {{ iam-full-name }} [documentation](../../../iam/concepts/index.md).