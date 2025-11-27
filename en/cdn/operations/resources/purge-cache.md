---
title: How to purge the resource cache in {{ cdn-full-name }}
description: Follow this guide to purge the resource cache.
---

# Purging the resource cache

To [purge the cache](../../concepts/caching.md) of the resource:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click the resource name.

  1. Navigate to the **{{ ui-key.yacloud.cdn.label_resource-content }}** tab.

  1. In the top-right corner, click ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.cdn.button_resource-content-purge-cache }}**.

  1. Select the type of cache purging:

      * `{{ ui-key.yacloud.cdn.label_resource-content-purging-cache-type-full }}`: To purge the cache for all files.
      * `{{ ui-key.yacloud.cdn.label_resource-content-purging-cache-type-selective }}`: To purge the cache for selected files. In the **{{ ui-key.yacloud.cdn.label_resource-content-purging-cache-paths }}** field, specify comma-separated paths to the files.

          {% include [wildcard-paths-purging-specifics](../../../_includes/cdn/wildcard-paths-purging-specifics.md) %}

  1. Click **{{ ui-key.yacloud.cdn.button_resource-content-purge-cache }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to update a resource:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of all [CDN resources](../../concepts/resource.md) in the default folder:

      ```bash
      yc cdn resource list --format yaml
      ```

      Result:

      ```text
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

  1. Purge the file cache:

      ```bash
      yc cdn cache purge \
        --resource-id <resource_ID> \
        --path <file_path_1>,<file_path_2>,...,<file_path_n>
      ```

      Where:
      * `--resource-id`: ID of the CDN resource to purge cache in.
      * `--path`: List of paths to CDN resource files whose cache needs purging.

          {% include [wildcard-paths-purging-specifics](../../../_includes/cdn/wildcard-paths-purging-specifics.md) %}

          {% include [the-vary-headers-purge-warning](../../../_includes/cdn/the-vary-headers-purge-warning.md) %}

          If you omit the `--path` setting with paths to files, the cache of all resource files will be purged. Learn more in [{#T}](../../concepts/caching.md#purge).

      For more information about the `yc cdn cache purge` command, see this [CLI reference](../../../cli/cli-ref/cdn/cli-ref/cache/purge.md).

- API {#api}

  Use the [purge](../../api-ref/Cache/purge.md) REST API method for the [Cache](../../api-ref/Cache/index.md) resource or the [CacheService/Purge](../../api-ref/grpc/Cache/purge.md) gRPC API call.

{% endlist %}
  
It may take up to 15 minutes to purge the cache.