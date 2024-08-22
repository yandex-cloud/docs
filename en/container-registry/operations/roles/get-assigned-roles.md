---
title: "How to view resource roles in {{ container-registry-full-name }}"
description: "Follow this guide to view roles assigned for resources."
---

# Viewing roles assigned for a resource

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to view the [roles](../../../iam/concepts/access-control/roles.md) assigned for a resource.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select a [registry](../../concepts/registry.md) or [repository](../../concepts/repository.md) in it.
  1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Find the required user, group, or [service account](../../../iam/concepts/users/service-accounts.md) in the list. Assigned roles are specified in the **{{ ui-key.yacloud.common.resource-acl.label_bindings }}** column.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Run this command:

   ```bash
   yc container <resource> list-access-bindings <resource_name_or_ID>
   ```

   Where:
   * `<resource>`: Resource type (`registry` or `repository`).
   * `<resource_name_or_ID>`: Name or ID of the resource you want to view the assigned roles for.

   **Example**

   ```bash
   yc container registry list-access-bindings my-first-registry
   ```

   Result:

   ```bash
   +--------------------------+---------------+----------------------+
   |         ROLE ID          | SUBJECT TYPE  |      SUBJECT ID      |
   +--------------------------+---------------+----------------------+
   | container-registry.admin | federatedUser | ajekv7lpqpgu******** |
   +--------------------------+---------------+----------------------+
   ```

- API {#api}

  Use the [listAccessBindings](../../api-ref/Registry/listAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/listAccessBindings](../../api-ref/grpc/registry_service.md#UpdateAccessBindings) gRPC API call.

  Use the [listAccessBindings](../../api-ref/Repository/listAccessBindings.md) REST API method for the [Repository](../../api-ref/Repository/index.md) resource or the [RepositoryService/listAccessBindings](../../api-ref/grpc/repository_service.md#UpdateAccessBindings) gRPC API call.

{% endlist %}

Read more about role management in the {{ iam-full-name }} [documentation](../../../iam/concepts/index.md).
