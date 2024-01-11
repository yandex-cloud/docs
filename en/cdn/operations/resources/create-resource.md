---
title: "How to create resources in {{ cdn-full-name }}"
description: "Follow this guide to create a resource."
---

# Creating a resource


{% include [lets-encrypt-over](../../../_includes/cdn/lets-encrypt-over.md) %}


To create a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder in which to create a resource.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

   1. If you do not have any CDN resources, click **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}**. A connection is established automatically.

   1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.

   1. Under **{{ ui-key.yacloud.cdn.label_section-content }}**, select **{{ ui-key.yacloud.cdn.label_content-query-type }}** `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` or `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`:

      * When requesting content `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`, select an **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Specify an origin. For more information about types, see [{#T}](../../concepts/origins.md).

      * When requesting content from an `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`, select an [origin group](../../concepts/origins.md#groups) or create a new one:
         * Click **{{ ui-key.yacloud.common.label_create-new_female }}**.
         * Enter **{{ ui-key.yacloud.cdn.field_group-name }}**.
         * Configure **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
            * Specify the **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. For more information about types, see [{#T}](../../concepts/origins.md).
            * Specify an origin.
            * Select the **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.label_status-active }}` or `{{ ui-key.yacloud.cdn.label_status-backup }}`. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).
         * Add other origins if needed.
         * Click **{{ ui-key.yacloud.common.create }}**. In the **{{ ui-key.yacloud.cdn.label_origins-group }}** field, you will see the name of the created group.

      For more information, see [{#T}](../../concepts/origins.md).

   1. Under **{{ ui-key.yacloud.cdn.label_section-domain }}**, enter **{{ ui-key.yacloud.cdn.label_personal-domain }}**. You can add multiple **Domain names**. Names containing characters other than ASCII (for example, Cyrillic) and [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) are supported. The first name is considered the primary domain name.

      {% note warning %}

      After you create a resource, you cannot change the primary domain name.

      {% endnote %}

      In the settings of your DNS hosting, create CNAME records for the specified domain names using the value displayed at the bottom of the **{{ ui-key.yacloud.cdn.label_section-domain }}** section. For more information, see [{#T}](../../concepts/resource.md#hostnames).

   1. Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:

      1. Select **{{ ui-key.yacloud.cdn.label_protocol }}**.
      1. Select a client redirect method: `{{ ui-key.yacloud.cdn.value_do-not-use }}` or `{{ ui-key.yacloud.cdn.value_redirect-https-to-http }}`.

         To enable a client redirect from HTTP to HTTPS, create a CDN resource without a redirect and get a TLS certificate for your domain name. Next, in the CDN resource settings, [select](configure-basics.md) the `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}` client redirect method.

      1. Enable or disable **{{ ui-key.yacloud.cdn.label_access }}**.
      1. In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, select one of the options:

         * `{{ ui-key.yacloud.cdn.value_certificate-no }}`: Resource will only be available over HTTP.
         * `{{ ui-key.yacloud.cdn.value_certificate-custom }}`: Select a certificate in {{ certificate-manager-name }}. This can be both a [Let's Encrypt® certificate](../../../certificate-manager/concepts/managed-certificate.md) and a [user certificate](../../../certificate-manager/concepts/imported-certificate.md).

         For more information, see [{#T}](../../concepts/clients-to-servers-tls.md).

      1. Select the **{{ ui-key.yacloud.cdn.label_host-header }}** value (`{{ ui-key.yacloud.cdn.value_host-header-default }}` or `{{ ui-key.yacloud.cdn.value_host-header-resend }}`) or choose `{{ ui-key.yacloud.cdn.value_host-header-custom }}` and enter the **{{ ui-key.yacloud.cdn.label_custom-host-header }}**. For more information, see [{#T}](../../concepts/servers-to-origins-host.md).

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. If you have not created resources before, connect to the provider first:

      ```bash
      yc cdn provider activate --type gcore
      ```

   1. View a description of the CLI create resource command:

      ```bash
      yc cdn resource create --help
      ```

   1. Get a list of origin groups in the folder:

      ```bash
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```bash
      - id: "90209"
        folder_id: s0mefo1der7p********
        name: test-group-1
        use_next: true
        origins:
        - id: "561547"
          origin_group_id: "90209"
          source: www.example2.com
          enabled: true
          backup: true
        - id: "561546"
          origin_group_id: "90209"
          source: www.example1.com
          enabled: true
      - id: "90208"
        folder_id: b1g86q4m5ve********
        name: test-group
        use_next: true
        origins:
        - id: "561545"
          origin_group_id: "90208"
          source: www.a2.com
          enabled: true
          backup: true
        - id: "561544"
          origin_group_id: "90208"
          source: www.a1.com
          enabled: true
      ```

   1. Create a resource:

      ```bash
      yc cdn resource create <resource_domain_name> \
        --origin-group-id <origin_group_ID> \
        --origin-protocol <protocol_used_for_origins>
      ```

      * Instead of `--origin-group-id`, you can specify the origin domain name using the `--origin-custom-source` flag.
      * Possible `--origin-protocol` values are `HTTP`, `HTTPS`, and `MATCH` (same as the client's).

      If you want to restrict access to the new resource with [secure tokens](../../concepts/secure-tokens.md), use the following parameters:
      * `--secure-key>`: Secret key that is an arbitrary string of 6 to 32 characters.
      * `--enable-ip-url-signing`: Optional parameter that restricts access to a CDN resource based on IP. A trusted IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a [signed link](../../concepts/secure-tokens.md#protected-link). If the parameter is not set, file access will be allowed from any IP.

      See also [{#T}](./enable-secure-token.md).

      For more information about the `yc cdn resource create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- {{ TF }}

   Make sure the CDN provider is activated before you start using CDN resources. You can activate it in the [management console]({{ link-console-main }}) or using the [YC CLI](../../../cli/quickstart.md) command:

   ```
   yc cdn provider activate --folder-id <folder_ID> --type gcore
   ```

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
      }
      ```



      Where:

      * `cname`: Primary domain name used for content distribution. This is a required parameter.
      * `active`: Flag indicating whether content is available to end users. `True`: Content from the CDN is available to clients. This is an optional parameter. The default value is `true`.
      * `origin_protocol`: Origin protocol. This is an optional parameter. The default value is `http`.
      * `secondary_hostnames`: Additional domain names. This is an optional parameter.
      * `origin_group_id`: ID of the [origin group](../../concepts/origins.md). This is a required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.

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

   Use the [create](../../api-ref/Resource/create.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Create](../../api-ref/grpc/resource_service.md#Create) gRPC API call.

{% endlist %}

{% include [after-creation-tip](../../../_includes/cdn/after-creation-tip.md) %}

{% include [note-dns-aname](../../../_includes/cdn/note-dns-aname.md) %}

{% include [edge-center-features-note](../../../_includes/cdn/edge-center-features-note.md) %}

## Examples {#examples}

{% list tabs %}

- CLI

   Create a resource with HTTP:

   ```bash
   yc cdn resource create testexample.com \
     --origin-group-id 90209 \
     --origin-protocol HTTP
   ```

   Result:

   ```bash
   id: s0me1dkfjq********

   ...

   cname: testexample.com
   active: true

   ...

   origin_group_id: "90209"
   origin_group_name: test-group-1
   origin_protocol: HTTP
   ssl_certificate:
   type: DONT_USE
   status: READY
   ```

{% endlist %}
