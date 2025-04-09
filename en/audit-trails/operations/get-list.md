---
title: How to get a list of trails
description: Follow this guide to view a list of available trails in {{ at-full-name }}.
---

# Getting a list of trails

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of [trails](../concepts/trail.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. The **{{ ui-key.yacloud.audit-trails.label_trails }}** page will display a list of trails.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command to view a list of [trails](../concepts/trail.md):

      ```bash
      yc audit-trails trail list --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}

- API {#api}

  To view a list of [trails](../concepts/trail.md), use the [list](../api-ref/Trail/list.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/List](../api-ref/grpc/Trail/list.md) gRPC API call.

{% endlist %}