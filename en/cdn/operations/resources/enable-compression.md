# Enabling file compression

To enable [compression](../../concepts/compression.md) of [resource](../../concepts/resource.md) files:

{% note info %}

Before delivery, the content will be compressed by CDN servers using the GZIP compression algorithm. This format is also used to send content to clients in the case of the `Content-Encoding` HTTP header. Only uncompressed content is requested from origins.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the resource is located.

   1. Select the service **{{ cdn-name }}**.

   1. On the **CDN resources** tab, click on the name of the desired resource.

   1. Go to the **Content** tab.

   1. In the upper-right corner, click **Edit**.

   1. Enable the **Compress option**.

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

   1. Enable file compression using the `--gzip-on` flag:

      ```bash
      yc cdn resource update <resource ID> --gzip-on
      ```

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the CDN resource to create:

      * `cname`: The primary domain name used for content distribution. Required parameter.
      * `active`: A flag that indicates if content is available to end users. `True`: Content from the CDN is available to clients. Optional parameter, defaults to `true`.
      * `origin_protocol`: Origin protocol. Optional parameter.
      * `secondary_hostnames`: Additional domain names. Optional parameter.
      * `origin_group_id`: ID of the [origin group](../../concepts/origins.md). Required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
      * The `options` section contains additional parameters of CDN resources:
         * `gzip_on`: A flag that indicates if compression will be used.

      Example configuration file structure:

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
            gzip_on = true
          }
      }
      ```

      For more detailed information on the `yandex_cdn_resource` parameters in Terraform, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cdn_resource).

   1. In the command line, go to the directory with the Terraform configuration file.

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

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