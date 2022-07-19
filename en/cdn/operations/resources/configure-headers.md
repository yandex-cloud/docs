# Configuring HTTP headers of requests and responses

To configure, for your resource, the HTTP headers of requests and responses:

{% note info %}

The `Access-Control-Allow-Origin` header for the CORS configuration is configured under **CORS when responding to client requests**. For more information, see [{#T}](configure-cors.md).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to **HTTP headers and methods**.

   1. In the top right-hand corner, click ![image](../../../_assets/pencil.svg) **Edit**.

   1. Under **Origin request headers**:

      * In the **Header** field, click **Add**.
      * Enter names and values of the desired headers.

   1. Under **Client response headers**:

      * In the **Header** field, click **Add**.
      * Enter names and values of the desired headers.

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

   1. To add headers, run:

      ```bash
      yc cdn resource update <resource ID> \
        --static-request-headers <key=value> \
        --static-headers <key=value>
      ```

      Where:

      * `--static-request-headers` adds request headers to the source. You can remove them using the `--clear-static-request-headers` flag.
      * `--static-headers` adds client response headers. You can remove them using the `--clear-static-headers` flag.

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of a CDN resource to create:

      
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
            cache_http_headers = ["GET","PUT"]
            cors                 = ["*"]
            static_response_headers = { "world2" = "2hello" }

          }

      }
      ```



      Where:

      * `cname`: The primary domain name used for content distribution. Required parameter.
      * `active`: A flag that indicates if content is available to end users. `True`: CDN content is available to end users. Optional parameter, defaults to `True`.
      * `origin_protocol`: Origin protocol. Optional parameter, defaults to `http`.
      * `secondary_hostnames`: Additional domain names. Optional.
      * `origin_group_id`: ID of the [origin group](../../concepts/origins.md). Required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
      * The `options` section contains additional parameters of CDN resources:
         * `static_response_headers` are custom headers that CDN servers send in response to the client. Optional.

      For more detailed information on the `yandex_cdn_target_group` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/cdn_resource).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check if the CDN resource has changed in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md).

      ```
      yc cdn resource list
      ```

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

#### For details, see also {#see-also}

* [{#T}](../../concepts/clients-to-servers.md)
* [{#T}](../../concepts/servers-to-origins.md)
