# Purging the resource cache

To [purge the cache](../../concepts/caching.md) of the resource:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to the **Content** tab.

   1. In the top right-hand corner, click ![image](../../../_assets/basket.svg) **Purge cache**.

   1. Select the type of cache purging:

      * `Full`: To purge the cache for all files.
      * `Selective`: To purge the cache for selected files. Enter names of desired files in the **File path field**.

   1. Click **Purge cache**.

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

   1. Purge the file cache using the `cache purge` argument:

      ```bash
      yc cdn cache purge --resource-id <resource ID> \
        --path <paths to files>
      ```
      If you don't specify the `--path` flag with paths to files, the cache of all files will be purged.

      For more information about the `yc cdn cache purge` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/cache/purge.md).

- API

   Use the [purge](../../api-ref/Cache/purge.md) REST API method for the [Cache](../../api-ref/Cache/index.md) resource or the [CacheService/Purge](../../api-ref/grpc/cache_service.md#Purge) gRPC API call.

{% endlist %}

It may take up to 15 minutes to purge the cache.