# Configuring CORS when responding to clients

To configure cross-domain requests with [CORS](../../concepts/cors.md) for the [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to **HTTP headers and methods**.

   1. In the top right-hand corner, click ![image](../../../_assets/pencil.svg) **Edit**.

   1. Under **CORS when responding to client requests**:

      * In the **Access-Control-Allow-Origin header** field, specify whether to add this header to responses.
      * When adding a header, select the values of the `Origin` header that allow access to the content. To allow access only to certain origins, select `Same as Origin if on the list`, specify the domain names of the origins, and click **Add domain name**.

   1. Click **Save**.

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

   1. To enable adding the `Access-Control-Allow-Origin` header, use the `--cors` flag:

      ```bash
      yc cdn resource update <resource ID> --cors <CORS value>
      ```
      The `*` and `"$http_origin"` values grant access to content with any `Origin` header. To grant access only to specific origins, specify `"$http_origin"` and the origin domain names: `["domain.com", "second.dom.com"]`.

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the CDN resource to create:

      {% if product == "yandex-cloud" %}

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
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
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

      {% endif %}

      {% if product == "cloud-il" %}

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
        endpoint  = "{{ api-host }}:443"
        token     = "<static key of service account>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
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

      {% endif %}

      Where:

      * `cname`: The primary domain name used for content distribution. Required parameter.
      * `active`: A flag that indicates if content is available to end users. `True`: Content from the CDN is available to clients. Optional parameter, defaults to `true`.
      * `origin_protocol`: Origin protocol. Optional parameter, defaults to `http`.
      * `secondary_hostnames`: Additional domain names. Optional.
      * `origin_group_id`: ID of the [origin group](../../concepts/origins.md). Required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
      * The `options` section contains additional parameters of CDN resources:
         * `cors`: Value that the CDN will send in the `Access-Control-Allow-Origin` header in response to a [CORS request](../../concepts/cors.md).
         * `allowed_http_methods`: HTTP methods allowed for your CDN content. By default, the following methods are allowed: `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, and `OPTIONS`. If the user is not allowed to use any method, `405`(Method Not Allowed) is returned. For methods that are not supported, `501` (Not Implemented) is returned. Optional parameter, defaults to: `GET`, `HEAD`, `POST`, or `OPTIONS`.

      For more information about `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/cdn_resource).

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the changes to the CDN resource in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md):

      ```
      yc cdn resource list
      ```

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}
