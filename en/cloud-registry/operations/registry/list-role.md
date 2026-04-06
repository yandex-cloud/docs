---
title: How to view roles for a registry in {{ cloud-registry-full-name }}
description: Follow this guide to view roles assigned for a registry.
---

# Viewing roles assigned for a registry

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Find the required user, group, or [service account](../../../iam/concepts/users/service-accounts.md) in the list. Assigned roles are specified in the **{{ ui-key.yacloud_components.acl.resource-acl.label_bindings }}** column.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  yc cloud-registry registry list-access-bindings <registry_name_or_ID>
  ```

  **Example**
  
  ```bash
  yc cloud-registry registry list-access-bindings my-first-registry
  ```

  Result:
  
  ```bash
  +----------------------+---------------+----------------------+
  |       ROLE ID        | SUBJECT TYPE  |      SUBJECT ID      |
  +----------------------+---------------+----------------------+
  | cloud-registry.admin | federatedUser | ajekv7lpqpgu******** |
  +----------------------+---------------+----------------------+
  ```

- API {#api}

  Use the [listAccessBindings](../../api-ref/Registry/listAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/ListAccessBindings](../../api-ref/grpc/Registry/listAccessBindings.md) gRPC API call.

{% endlist %}

For more information about assigning roles, see [this {{ iam-full-name }} guide](../../../iam/operations/roles/get-assigned-roles.md).
