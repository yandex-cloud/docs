---
title: How to create a resource in {{ cdn-full-name }}
description: Follow this guide to create a resource.
---

# Creating a resource

To create a [resource](../../concepts/resource.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a resource.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Configure the basic CDN resource settings:

      {% note tip %}

      {% include [copy-configuration](../../../_includes/cdn/copy-configuration.md) %}

      {% endnote %}

      * Under **{{ ui-key.yacloud.cdn.label_section-content }}**:
        * Enable or disable **{{ ui-key.yacloud.cdn.label_access }}**.
        * In the **{{ ui-key.yacloud.cdn.label_content-query-type }}** field, select `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` or `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`:
          * When requesting `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` content, select the **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`, and specify the [origin](../../concepts/origins.md).
          * When requesting content `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`, select an [origin group](../../concepts/origins.md#groups) or create a new one:
            1. Click **{{ ui-key.yacloud.common.create }}**.
            1. Specify **{{ ui-key.yacloud.cdn.field_group-name }}**.
            1. Configure **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
                * Specify the **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`.
                * Specify an origin.
                * Select the **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.label_status-active }}` or `{{ ui-key.yacloud.cdn.label_status-backup }}`.
            1. Add other origins if needed.
            1. Click **{{ ui-key.yacloud.common.create }}**. In the **{{ ui-key.yacloud.cdn.label_origins-group }}** field, you will see the name of the created origin group.

          {% note info %}

          If the CDN resource is from one [CDN provider](../../concepts/providers.md) and the selected existing origin group is from another, a duplicate origin group will be created for the CDN resource provider.

          {% endnote %}

          For more information, see [{#T}](../../concepts/origins.md).
        * In the **{{ ui-key.yacloud.cdn.label_protocol }}** field, select a protocol for the origins.
        * In the **{{ ui-key.yacloud.cdn.label_personal-domain }}** field, specify the primary domain name you will use in your website links to CDN-hosted content, e.g., `cdn.example.com`.

          You can add multiple **Domain names**. Names may include characters other than [ASCII](https://{{ lang }}.wikipedia.org/wiki/ASCII), e.g., Cyrillic or [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). The first name is considered the primary domain name.

          {% note alert %}

          You cannot change the primary domain name used for content distribution after creating a CDN resource.

          {% endnote %}

        * Optionally, add [labels](../../concepts/labels.md):
          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Enter a label in `key: value` format.
          1. Press **Enter**.

      * Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * In the **{{ ui-key.yacloud.cdn.label_redirect }}** field, select `{{ ui-key.yacloud.cdn.value_do-not-use }}` or `{{ ui-key.yacloud.cdn.value_redirect-https-to-http }}`.

          To enable redirecting clients from HTTP to HTTPS, create a CDN resource without a redirect and get a [TLS certificate](../../concepts/clients-to-servers-tls.md) for your domain name. Next, in the CDN resource settings, [select](configure-basics.md) the `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}` client redirect method.
        * In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, select one of the options:
          * `{{ ui-key.yacloud.cdn.value_certificate-no }}`: Resource will only be available over HTTP.
          * `{{ ui-key.yacloud.cdn.value_certificate-custom }}`: Select a certificate. The resource will be available over HTTP and HTTPS.

          {% include [certificate-usage](../../../_includes/cdn/certificate-usage.md) %}

          [Learn more about configuring TLS certificates for HTTPS connections](../../concepts/clients-to-servers-tls.md).
        * In the **{{ ui-key.yacloud.cdn.label_host-header }}** field, select the value (`{{ ui-key.yacloud.cdn.value_host-header-default }}` or `{{ ui-key.yacloud.cdn.value_host-header-resend }}`) or opt for `{{ ui-key.yacloud.cdn.value_host-header-custom }}` and enter the **{{ ui-key.yacloud.cdn.label_custom-host-header }}**. 
      
          [Learn more about the `Host` header in CDN server requests to origins](../../concepts/servers-to-origins-host.md).
        * Optionally, to enable [request redirection](../../concepts/http-rewrite.md) on a CDN resource, do the following:
          1. Enable **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.
          1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** field, set a rule, e.g., `/(.*) /new-folder/$1`.

              {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

          1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** field, specify the required [flag](../../concepts/http-rewrite.md#flag):

              {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

        * Optionally, to restrict access to resource content with [secure tokens](../../concepts/secure-tokens.md), enable **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

          {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

          [Learn more about access via a secure token](enable-secure-token.md).

        * {% include [enable-ip-policy](../../../_includes/cdn/enable-ip-policy.md) %}

        * Optionally, to set a [CDN provider](../../concepts/providers.md), enable **Select provider** and specify the one you need.

          The default provider is `{{ cdn-full-name }}`.

          {% include [provider-binding](../../../_includes/cdn/provider-binding.md) %}

  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. Optionally, under **{{ ui-key.yacloud.cdn.label_resource-cache }}**, do the following:

      {% include [setup-later](../../../_includes/cdn/setup-later.md) %}

      * Under **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache }}**:
        * Enable **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}**.
        * Select the setting type: `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-source-settings }}` or `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-custom-settings }}`.
        * Select the cache lifetime from the list.
        * Optionally, for the `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-custom-settings }}` setting type, set the cache lifetime for the required HTTP response codes.
      * Under **{{ ui-key.yacloud.cdn.label_resource-cache-browser-cache }}**:
        * Enable **{{ ui-key.yacloud.cdn.label_resource-cache-browser-cache-enabled }}**.
        * Select the cache lifetime from the list.
      * Under **{{ ui-key.yacloud.cdn.label_additional }}**:
        * Select the option to ignore Cookies.
        * Select the option to ignore the Query parameters.
      * For CDN servers to compress content before sending it to clients, select **{{ ui-key.yacloud.cdn.label_resource-content-gzip-on }}**.

        The content will be sent in `gzip` format with the `Content-Encoding` HTTP header. From origins, only uncompressed content will be requested.

        [Learn more about file compression](enable-compression.md).

      * If you want files larger than 10 MB to be requested and cached in parts, each part no larger than 10 MB, select **{{ ui-key.yacloud.cdn.label_resource-content-slice }}**.

        For segmentation to work, content origins must support partial GET requests with the `Range` header.

        [Learn more about segmentation](enable-segmentation.md).

      [Learn more about caching](configure-caching.md).

  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. Under **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**:

      {% include [setup-later](../../../_includes/cdn/setup-later.md) %}

      * Under **{{ ui-key.yacloud.cdn.label_resource-http-headers-request-headers }}**:
        * In the **{{ ui-key.yacloud.cdn.label_headers }}** field, click **{{ ui-key.yacloud.common.add }}**.
        * Enter names and values of the headers you need.
      * Under **{{ ui-key.yacloud.cdn.label_resource-http-headers-response-headers }}**:
        * In the **{{ ui-key.yacloud.cdn.label_headers }}** field, click **{{ ui-key.yacloud.common.add }}**.
        * Enter names and values of the headers you need.

        [Learn more about configuring HTTP headers for requests and responses](configure-headers.md).
      * Under **{{ ui-key.yacloud.cdn.label_resource-http-headers-cors }}**:
        * In the **{{ ui-key.yacloud.cdn.label_resource-http-headers-cors-access }}** field, specify whether to add this header to responses.
        * When adding a header, select the values of the `Origin` header that allow access to the content. To grant access only to specific origins, select `{{ ui-key.yacloud.cdn.label_resource-http-headers-cors-settings-http-origin-for-source-domains }}`, specify the origin domain names and click **{{ ui-key.yacloud.cdn.button_add-domain }}**.

        [Learn more about configuring CORS for responses to clients](configure-cors.md).

      * Under **{{ ui-key.yacloud.cdn.label_resource-http-headers-http-methods }}**, select **{{ ui-key.yacloud.cdn.label_resource-http-headers-allowed-methods }}** from the drop-down list.

        [Learn more about configuring HTTP methods](configure-http.md).
  1. Click **Create and continue**.
  1. Optionally, under **Advanced**, do the following:

      {% include [setup-later](../../../_includes/cdn/setup-later.md) %}

      * Under **Log export settings**, enable log export.

        [Learn more about log export](configure-logs.md).
      * Under **Origin shielding settings**, enable shielding and select the location you need in the **{{ ui-key.yacloud.cdn.label_shielding-location }}** field.

        [Learn more about shielding](enable-shielding.md).
  1. Click **{{ ui-key.yacloud.common.continue }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/) command to create a resource:

     ```bash
     yc cdn resource create --help
     ```

  1. Get a list of [origin groups](../../concepts/origins.md#groups) in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc cdn origin-group list --format yaml
     ```

     Result:

     ```text
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
       --origin-protocol <origin_protocol>
     ```

     * Instead of `--origin-group-id`, you can specify the [origin](../../concepts/origins.md) domain name using the `--origin-custom-source` flag.
     * The possible `--origin-protocol` values are `HTTP`, `HTTPS`, and `MATCH` (same as the client's).

     {% include [certificate-settings-cli](../../../_includes/cdn/certificate-settings-cli.md) %}

     To enable [request redirects](../../concepts/http-rewrite.md) on a CDN resource, use these parameters:

     * `--rewrite-body`: Rewrite rule, e.g., `--rewrite-body '/(.*) /new-folder/$1'`.

         {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

     * `--rewrite-flag`: [Flag](../../concepts/http-rewrite.md#flag). The possible values are:

         {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

     * To add [labels](../../concepts/labels.md), use the `--add-labels` parameter, e.g., `--add-labels key1=value1`.

     {% include [access-restrictions-cli](../../../_includes/cdn/access-restrictions-cli.md) %}

     For more information about the `yc cdn resource create` command, see the [CLI reference](../../../cli/cli-ref/cdn/cli-ref/resource/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the properties of the CDN resource to create:

     {% include [create-resource-tf](../../../_includes/cdn/create-resource-tf.md) %}

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new CDN resource using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc cdn resource list
     ```

- API {#api}

  Use the [create](../../api-ref/Resource/create.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) gRPC API call.

  You can restrict access to the resource with [secure tokens](../../concepts/secure-tokens.md) and an [IP-based access policy](../../concepts/ip-address-acl.md).

{% endlist %}

{% include [get-and-create-cname](../../../_includes/cdn/get-and-create-cname.md) %}

{% include [after-creation-tip](../../../_includes/cdn/after-creation-tip.md) %}

{% include [note-dns-aname](../../../_includes/cdn/note-dns-aname.md) %}

{% include [edge-center-features-note](../../../_includes/cdn/edge-center-features-note.md) %}

## Examples {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a resource with HTTP:

  ```bash
  yc cdn resource create testexample.com \
    --origin-group-id 90209 \
    --origin-protocol HTTP
  ```

  Result:

  ```text
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