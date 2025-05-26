---
title: How to configure resource caching in {{ cdn-full-name }}
description: Follow this guide to configure resource caching.
---

# Configuring resource caching

To configure the [caching](../../concepts/caching.md) parameters of a [resource](../../concepts/resource.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click the resource name.

  1. Navigate to the **{{ ui-key.yacloud.cdn.label_resource-cache }}** tab.

  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Select and configure the caching options:

      * Under **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache }}**:

          * Enable **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}**.
          * Select the setting type: `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-source-settings }}` or `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-custom-settings }}`.
          * Select the cache lifetime from the list.
          * Optionally, for the `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-custom-settings }}` setting type, set the cache lifetime for the required HTTP response codes.

      * Under **{{ ui-key.yacloud.cdn.label_resource-cache-browser-cache }}**:

          * Enable **{{ ui-key.yacloud.cdn.label_resource-cache-browser-cache-enabled }}**.

  1. Optionally, under **{{ ui-key.yacloud.cdn.label_additional }}**:

      * Select the option to ignore Cookies.
      * Select the option to ignore the Query parameters.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to update a resource:

      ```bash
      yc cdn resource update --help
      ```

  1. Get a list of all resources in the default folder:

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

  1. To change the cache lifetime, run:

      ```bash
      yc cdn resource update <resource_ID> \
        --cache-expiration-time <time> \
        --browser-cache-expiration-time <time> \
        --ignore-cookie true \
        --ignore-query-string
      ```

      Where:

      * `--cache-expiration-time`: Cache lifetime in seconds.
      * `--browser-cache-expiration-time`: Browser cache lifetime in seconds.
      * `--ignore-cookie`: If `true`, ignores cookies.
      * `--ignore-query-string`: Ignores query parameters.

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the properties of the `yandex_cdn_resource` CDN resource you want to create:

      ```hcl
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
            version = "0.69.0"
          }
        }
      }

      provider "yandex" {
        token     = "<OAuth_token>"
        cloud_id  = "<cloud_ID>"
        folder_id = "<folder_ID>"
        zone      = "<availability_zone>"
      }

      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
          options {
            edge_cache_settings    = "345600"
            browser_cache_settings = "1800"
            ignore_cookie          = true
            ignore_query_params    = false
          }

      }
      ```

      Where:

      * `cname`: Primary domain name used for content distribution. This is a required parameter.
      * `active`: Flag indicating content availability to end users. `True`: CDN content will be available to clients. This is an optional parameter. The default value is `true`.
      * `origin_protocol`: Protocol for origins. This is an optional parameter. The default value is `http`.
      * `secondary_hostnames`: Additional domain names. This is an optional parameter.
      * `origin_group_id`: [Origin group](../../concepts/origins.md) ID. This is a required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
      * The `options` section contains additional parameters of CDN resources:
         * `browser_cache_settings`: Browser cache lifetime in seconds. This is an optional parameter. The default value is `0`.
         * `edge_cache_settings`: Cache lifetime for response codes in seconds. This is an optional parameter. The default value is `345600`.
         * `ignore_query_params`: Ignore query parameters. This is an optional parameter. The default value is `false`.
         * `ignore_cookie`: Ignore cookies. This is an optional parameter. The default value is `false`.

      For more information about the `yandex_cdn_resource` properties in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_resource).

  1. In the command line, go to the directory with the {{ TF }} configuration file.

  1. Check the configuration using this command:
     ```
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```

     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the changes:
     ```
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm the changes.

     You can check the CDN resource update in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

     ```
     yc cdn resource list
     ```

- API {#api}

  Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/Resource/update.md) gRPC API call.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}