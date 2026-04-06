---
title: How to get information about a registry access policy in {{ cloud-registry-full-name }}
description: Follow this guide to get information about registry access policies.
---

# Getting information about a registry access policy

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the registry.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.cloud-registry.title_ip-permissions }}** tab. The page will show the registry access policy details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Get formation about a registry access policy:

  ```bash
  yc cloud-registry registry list-ip-permissions <registry_name_or_ID>
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

  To get registry access policy details, use the [listIpPermissions](../../api-ref/Registry/listIpPermissions.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/ListIpPermissions](../../api-ref/grpc/Registry/listIpPermissions.md) gRPC API call.

{% endlist %}
