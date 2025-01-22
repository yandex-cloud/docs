---
title: How to configure CORS for responses to clients in {{ cdn-full-name }}
description: Follow this guide to configure CORS when sending responses to clients.
---

# Configuring CORS when responding to clients

{% include [cors-note](../../../_includes/cdn/cors-note.md) %}

To configure cross-domain requests with [CORS](../../concepts/cors.md) for the [resource](../../concepts/resource.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click the resource name.

  1. Go to the **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** tab.

  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Under **{{ ui-key.yacloud.cdn.label_resource-http-headers-cors }}**:

      * In the **{{ ui-key.yacloud.cdn.label_resource-http-headers-cors-access }}** field, specify whether to add this header to responses.
      * When adding a header, select the values of the `Origin` header that allow access to the content. To grant access only to specific origins, select `{{ ui-key.yacloud.cdn.label_resource-http-headers-cors-settings-http-origin-for-source-domains }}`, specify the origin domain names and click **{{ ui-key.yacloud.cdn.button_add-domain }}**.

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

  1. To enable adding the `Access-Control-Allow-Origin` header, use the `--cors` flag:

      ```bash
      yc cdn resource update <resource_ID> --cors <CORS_value>
      ```
      The `*` and `"$http_origin"` values grant access to content with any `Origin` header value. To only grant access to specific origins, specify `"$http_origin"` and the origin domain names: `["domain.com", "second.dom.com"]`.

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

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
            allowed_http_methods = ["GET","PUT"]
            cors                 = ["*"]
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
         * `cors`: Value the CDN will send in the `Access-Control-Allow-Origin` header in response to a [CORS request](../../concepts/cors.md).
         * `allowed_http_methods`: HTTP methods allowed for your CDN content. By default, the following methods are allowed: `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, and `OPTIONS`. If the user is not allowed to use any method, they will get the `405` _Method Not Allowed_ response. For methods that are not supported, the user will get `501` (_Not Implemented_). This is an optional parameter. Its default values are `GET`, `HEAD`, `POST`, and `OPTIONS`.

      For more information about the `yandex_cdn_resource` parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/cdn_resource).

  1. In the command line, go to the folder with the {{ TF }} configuration file.

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

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the changes to the CDN resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```
     yc cdn resource list
     ```

- API {#api}

  Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/Resource/update.md) gRPC API call.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}
