# Preloading files to CDN servers

To [pre-load content](../../concepts/caching.md#prefetch) from [origins](../../concepts/origins.md) to CDN servers:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your [resource](../../concepts/resource.md) is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to the **Content** tab.

   1. In the top right-hand corner, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Preload content**.

   1. In the **File path** field, enter the names of preloaded files.

   1. Click **Preload content**.

- CLI

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
      id: someidkfjqjfl325fw
      folder_id: somefolder7p3l5eobbd
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

   1. Specify the paths to the files you would like to preload as a comma-separated list with no spaces:

      ```bash
      yc cdn cache prefetch --resource-id <resource ID> \
        --path <paths to files>
      ```

      For more information about the `yc cdn cache prefetch` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/cache/prefetch.md).

- API

   Use the [prefetch](../../api-ref/Cache/prefetch.md) REST API method for the [Cache](../../api-ref/Cache/index.md) resource or the [CacheService/Prefetch](../../api-ref/grpc/cache_service.md#Prefetch) gRPC API call.

{% endlist %}

