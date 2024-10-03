---
title: How to configure HTTP headers of requests and responses in {{ cdn-full-name }}
description: Follow this guide to configure request and response HTTP headers.
---

# Configuring HTTP headers of requests and responses

To configure HTTP request and response headers for a resource:

{% note info %}

The `Access-Control-Allow-Origin` header for the CORS configuration is configured under **{{ ui-key.yacloud.cdn.label_resource-http-headers-cors }}**. For more information, see [{#T}](configure-cors.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click the resource name.

  1. Go to the **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** tab.

  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Under **{{ ui-key.yacloud.cdn.label_resource-http-headers-request-headers }}**:

      * In the **{{ ui-key.yacloud.cdn.label_headers }}** field, click **{{ ui-key.yacloud.common.add }}**.
      * Enter names and values of the headers you need.

  1. Under **{{ ui-key.yacloud.cdn.label_resource-http-headers-response-headers }}**:

      * In the **{{ ui-key.yacloud.cdn.label_headers }}** field, click **{{ ui-key.yacloud.common.add }}**.
      * Enter names and values of the headers you need.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI update resource command:

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

  1. To add headers, run:

      ```bash
      yc cdn resource update <resource_ID> \
        --static-request-headers <key>=<value> \
        --static-headers <key>=<value>
      ```

      Where:

      * `--static-request-headers`: Adds request headers to the origin. You can remove them using the `--clear-static-request-headers` flag.
      * `--static-headers`: Adds client response headers. You can remove them using the `--clear-static-headers` flag.

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the CDN resource to create:


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
            cache_http_headers = ["GET","PUT"]
            cors                 = ["*"]
            static_response_headers = { "world2" = "2hello" }

          }

      }
      ```



      Where:

      * `cname`: Primary domain name used for content distribution. This is a required parameter.
      * `active`: Flag indicating content availablity to end users. `True`: CDN content will be available to clients. This is an optional parameter. The default value is `true`.
      * `origin_protocol`: Protocol for origins. This is an optional parameter. The default value is `http`.
      * `secondary_hostnames`: Additional domain names. This is an optional parameter.
      * `origin_group_id`: [Origin group](../../concepts/origins.md) ID. This is a required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
      * The `options` section contains additional parameters of CDN resources:
         * `static_response_headers`: Custom headers that CDN servers send in response to the client. This is an optional parameter.

      For more information about the `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_resource).

  1. In the command line, go to the folder with the {{ TF }} configuration file.

  1. Check the configuration using this command:
     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and click **Enter**.

     You can check the changes to the CDN resource in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

     ```bash
     yc cdn resource list
     ```

- API {#api}

  Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update) gRPC API call.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/clients-to-servers.md)
* [{#T}](../../concepts/servers-to-origins.md)
