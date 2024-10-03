---
title: How to get information about a registry access policy in {{ container-registry-full-name }}
description: Follow this guide to get information about registry access policies.
---

# Getting information about a registry access policy

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the registry.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.cr.switch_registry }}**.
  1. Select the registry.
  1. The **{{ ui-key.yacloud.cr.registry.label_ip-permissions }}** page will show the registry access policy details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To find out a registry ID or name, [get](registry-list.md) a list of registries in the folder.
  
  Get formation about a registry access policy:

  ```bash
  yc container registry list-ip-permissions <registry_name>
  ```

  Result:

  ```text
  +--------+---------------+
  | ACTION |  IP           |
  +--------+---------------+
  | PULL   | 217.132.72.25 |
  +--------+---------------+
  ```

- API {#api}

  To get registry access policy details, use the [listIpPermission](../../api-ref/Registry/listIpPermission.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/ListIpPermission](../../api-ref/grpc/registry_service.md#ListIpPermission) gRPC API call.

{% endlist %}