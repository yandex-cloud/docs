---
title: "How to prefetch files to CDN servers in {{ cdn-full-name }}"
description: "Use this guide to prefetch files to CDN servers."
---

# Prefetching files to CDN servers

To [prefetch content](../../concepts/caching.md#prefetch) from [origins](../../concepts/origins.md) to CDN servers:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where your [resource](../../concepts/resource.md) is located.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

   1. Click the resource name.

   1. Go to the **{{ ui-key.yacloud.cdn.label_resource-content }}** tab.

   1. In the top-right corner, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.

   1. Enter the file names in the **{{ ui-key.yacloud.cdn.label_resource-content-prefetch-cache-paths }}** field.

   1. Click **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.

- CLI {#cli}

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI update resource command:

      ```bash
      yc cdn resource update --help
      ```

   1. Get a list of all resources in the default folder:

      ```bash
      yc cdn resource list --format yaml
      ```

      Result:

      ```bash
      id: s0me1dkfjq********
      folder_id: s0mef01der7p********
      cname: testexample.com
      created_at: "2022-01-19T09:23:57.921365Z"
      updated_at: "2022-01-19T10:55:30.305141Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default value: "345600"
        cache_http_headers:
          enabled: true
          value:
          - content-type
          - content-length
          - connection
          - server
          - date
          - test
        stale:
          enabled: true
          value:
          - error
          - updating
        allowed_http_methods:
          value:
          - GET
          - POST
          - HEAD
          - OPTIONS
      origin_group_id: "89783"
      origin_group_name: My origins group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

   1. Specify the paths to the files you would like to prefetch as a comma-separated list with no spaces:

      ```bash
      yc cdn cache prefetch --resource-id <resource_ID> \
        --path <paths_to_files>
      ```

      For more information about the `yc cdn cache prefetch` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/cache/prefetch.md).

- API {#api}

   Use the [prefetch](../../api-ref/Cache/prefetch.md) REST API method for the [Cache](../../api-ref/Cache/index.md) resource or the [CacheService/Prefetch](../../api-ref/grpc/cache_service.md#Prefetch) gRPC API call.

{% endlist %}

