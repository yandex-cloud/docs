---
title: "How to edit the basic settings of a resource in {{ cdn-full-name }}"
description: "Follow this guide to update the basic resource settings."
---

# Editing the basic settings of a resource

To edit the basic settings of a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

   1. Click the resource name.

   1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

   1. Edit the resource settings.

      {% note warning %}

      You cannot change the primary [domain name used for content distribution](../../concepts/resource.md#hostnames).

      {% endnote %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

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

   1. Edit the resource settings:

      ```bash
      yc cdn resource update <resource_ID> \
        <flag> <new_value>
      ```

      If you want to restrict access to the new resource with [secure tokens](../../concepts/secure-tokens.md), use the following parameters:
      * `--secure-key>`: Secret key that is an arbitrary string of 6 to 32 characters.
      * `--enable-ip-url-signing`: Optional parameter that restricts access to a CDN resource based on IP. A trusted IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a [signed link](../../concepts/secure-tokens.md#protected-link). If the parameter is not set, file access will be allowed from any IP.

      See also [{#T}](./enable-secure-token.md).

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To update the parameters of a CDN resource created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the fragment with the resource description.

      {% cut "An example of describing a CDN resource in the {{ TF }} configuration" %}

      ```hcl
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = "<origin_group_ID>"
          ...
          options {
            edge_cache_settings = "345600"
            ignore_cookie       = true
            ...
          }
      }
      ```

      {% endcut %}

      For more information about `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_resource).

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

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the changes to the CDN resource in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md):

      ```
      yc cdn resource list
      ```

- API

   Use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update) gRPC API call.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

## Examples {#examples}

{% list tabs %}

- CLI

   Change the protocol for origins from HTTP to HTTPS and select a Let's Encrypt® certificate [added](../../../certificate-manager/operations/managed/cert-create.md) to {{ certificate-manager-name }} or an [uploaded](../../../certificate-manager/operations/import/cert-create.md) certificate of your own:

   ```bash
   yc cdn resource update s0me1dkfjq******** \
     --origin-protocol HTTPS \
     --cert-manager-ssl-cert-id <certificate_ID>
   ```

   Result:

   ```bash
   id: s0me1dkfjq********

   ...

   cname: testexample.com
   active: true

   ...

   origin_group_id: "89783"
   origin_group_name: My origins group
   origin_protocol: HTTPS
   ssl_certificate:
   type: CM
   status: CREATING
   ```

{% endlist %}