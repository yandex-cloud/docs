---
title: Setting up access via a secure token
description: Follow this guide to set up access to a {{ cdn-name }} resource content based on time and IP address using secure tokens.
---

# Setting up access via a secure token

Using [secure tokens](../../concepts/secure-tokens.md), you can restrict access to [CDN resource](../../concepts/resource.md) files. Files will be accessed via [signed URLs](../../concepts/secure-tokens.md#protected-link) with the limited validity period.

You can also use secure tokens to specify a trusted [IP address](../../../vpc/concepts/address.md) from which a CDN resource can be accessed.

### Enabling access {#enable-secure-token}

To enable access via a secure token:
1. Come up with a secret key that is an arbitrary string of 6 to 32 characters. It will be saved in the CDN resource settings and used to generate signed URLs.
1. On your website, set up [generation](../../concepts/secure-tokens.md#link-generation-code) of signed URLs with secure tokens.
1. Enable access to the CDN resource via a secure token:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
      1. Click the resource name.
      1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. Enable **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

         {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

      1. Click **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

      {% include [include](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. View the description of the [CLI](../../../cli/) update resource command:

         ```bash
         yc cdn resource update --help
         ```

      1. Get a list of all resources in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

         ```bash
         yc cdn resource list --format yaml
         ```

         Result:

         ```text
         id: bc8br5k6iohx********
         folder_id: b1gt6g8ht345********
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

         Save the `ID` of the resource for which you want to set up access via a secure token.
      1. Enable access via a secure token:

         ```bash
         yc cdn resource update \
             --id <resource_ID> \
             --secure-key <secret_key> \
             --enable-ip-url-signing
         ```

         Where:
         * `--id`: ID of the CDN resource for which to enable access via a secure token.
         * `--secure-key`: Previously created secret key.
         * `--enable-ip-url-signing`: Optional parameter that restricts access to a CDN resource by IP address. A trusted IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://{{ lang }}.wikipedia.org/wiki/MD5) hash for a signed URL. If the parameter is not set, file access will be allowed from any IP address.

   - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. Open the {{ TF }} configuration file and add the following parameters to the section with the CDN resource description:

         ```hcl
         resource "yandex_cdn_resource" "my_resource" {
           ...
           options {
             ...
             secure_key = "<secret_key>"
             enable_ip_url_signing = true
           }
         }
         ```

         Where:
         * `secure_key`: Previously created secret key.
         * `enable_ip_url_signing`: Optional parameter, `true` or `false`. It restricts access to a CDN resource by IP address. A trusted IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://{{ lang }}.wikipedia.org/wiki/MD5) hash for a signed URL. If the parameter is not set, file access will be allowed from any IP address.

         For more information about `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_resource).
      1. Apply the changes:

         {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updated CDN resource parameters using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc cdn resource get <resource_ID>
      ```

   - API {#api}

      Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update) gRPC API call.

   {% endlist %}

   {% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

   Enabling access to CDN resource content via a secure token disables access to it via regular links.

### Disabling access {#disable-secure-token}

To disable access to a CDN resource via a secure token:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. Click the resource name.
   1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
   1. Enable **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   Run this command:

   ```bash
   yc cdn resource update \
     --id <resource_ID> \
     --clear-secure-key
   ```

   Where:
   * `--id`: ID of the CDN resource for which to disable access via a secure token.
   * `--clear-secure-key`: Parameter that disables access via a secure token.

- {{ TF }} {#tf}

   1. Open the {{ TF }} configuration file and delete the `secure_key` and `enable_ip_url_signing` parameters from the section with the CDN resource description:

      ```hcl
      resource "yandex_cdn_resource" "my_resource" {
        ...
        options {
          ...
          secure_key = "<secret_key>"
          enable_ip_url_signing = true
        }
      }
      ```

      For more information about `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_resource).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   You can check the updated CDN resource parameters using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc cdn resource get <resource_ID>
   ```

- API {#api}

   Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update) gRPC API call.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}