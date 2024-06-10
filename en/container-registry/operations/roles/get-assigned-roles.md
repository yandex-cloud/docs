---
title: "How to view resource roles in {{ container-registry-full-name }}"
description: "Follow this guide to view roles assigned for resources."
---

# Viewing roles assigned for a resource

To view assigned [roles](../../../iam/concepts/access-control/roles.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to view resource roles.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. View the roles assigned for a resource:
      * Viewing roles for a [registry](../../concepts/registry.md):
         1. To the right of the registry name, click ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **Registry ACL**.
         1. In the window that opens, you can see a list of users and their permissions for the registry.
      * Viewing roles for a repository:
         1. Select the registry.
         1. To the right of the repository name, click ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **Configure ACL**.
         1. In the window that opens, you can see a list of users and their permissions for the repository.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Run this command:

   ```bash
   yc <service_name> <resource> list-access-bindings <resource_name_or_ID>
   ```

   Where:
   * `<service_name>`: `container` service name.
   * `<resource>`: Category of the resource (`registry` or `repository`).
   * `<resource_name_or_ID>`: Name or ID of the resource the role is assigned for.

   > Example. View the roles for the registry with the `crp0pmf1n68d********` ID:
   >
   > ```bash
   > yc container registry list-access-bindings crp0pmf1n68d********
   > ```
   >
   > Command result:
   >
   > ```bash
   > +--------------------------+------------------+----------------------+
   > |         ROLE ID          |   SUBJECT TYPE   |      SUBJECT ID      |
   > +--------------------------+------------------+----------------------+
   > | container-registry.admin | federatedAccount | kolhpriseeio******** |
   > +--------------------------+------------------+----------------------+
   > ```

- API {#api}

   Use the `listAccessBindings` method for the `registry` and `repository` resources.

{% endlist %}

Read more about role management in the {{ iam-full-name }} [documentation](../../../iam/concepts/index.md).