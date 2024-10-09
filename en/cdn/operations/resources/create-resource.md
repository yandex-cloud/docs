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
  1. {% include [activate-provider](../../../_includes/cdn/activate-provider.md) %}
  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Under **{{ ui-key.yacloud.cdn.label_section-content }}**, select the **{{ ui-key.yacloud.cdn.label_content-query-type }}**: `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` or `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`:
     * When requesting content `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`, select an **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Specify an [origin](../../concepts/origins.md).
     * When requesting content from an `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`, select an [origin group](../../concepts/origins.md#groups) or create a new one:
        * Click **{{ ui-key.yacloud.common.label_create-new_female }}**.
        * Enter **{{ ui-key.yacloud.cdn.field_group-name }}**.
        * Configure **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
           * Specify the **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`.
           * Specify an origin.
           * Select the **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.label_status-active }}` or `{{ ui-key.yacloud.cdn.label_status-backup }}`.
        * Add other origins if needed.
        * Click **{{ ui-key.yacloud.common.create }}**. In the **{{ ui-key.yacloud.cdn.label_origins-group }}** field, you will see the name of the created origin group.

     For more information, see [{#T}](../../concepts/origins.md).
  1. Under **{{ ui-key.yacloud.cdn.label_section-domain }}**, enter **{{ ui-key.yacloud.cdn.label_personal-domain }}**. You can add multiple **Domain names**. Names may include characters other than [ASCII](https://{{ lang }}.wikipedia.org/wiki/ASCII), e.g., Сyrillic, or [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). The first name is considered the primary domain name.

     {% note warning %}

     After you create a resource, you cannot change the primary domain name.

     {% endnote %}

     In the settings of your DNS hosting, create [CNAME records](../../../dns/concepts/resource-record.md#cname) for the specified domain names using the value displayed at the bottom of the **{{ ui-key.yacloud.cdn.label_section-domain }}** section. For more information, see [{#T}](../../concepts/resource.md#hostnames).
  1. Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:
     1. Select **{{ ui-key.yacloud.cdn.label_protocol }}**.
     1. Select a client redirect method: `{{ ui-key.yacloud.cdn.value_do-not-use }}` or `{{ ui-key.yacloud.cdn.value_redirect-https-to-http }}`.

        To enable redirecting clients from HTTP to HTTPS, create a CDN resource without a redirect and get a [TLS certificate](../../concepts/clients-to-servers-tls.md) for your domain name. Next, in the CDN resource settings, [select](configure-basics.md) the `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}` client redirect method.
     1. Enable or disable **{{ ui-key.yacloud.cdn.label_access }}**.
     1. In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, select one of the options:
         * `{{ ui-key.yacloud.cdn.value_certificate-no }}`: Resource will only be available over HTTP.


         * `{{ ui-key.yacloud.cdn.value_certificate-custom }}`: Select a certificate. The resource will be available over HTTP and HTTPS.

           {% include [lets-encrypt-over](../../../_includes/cdn/lets-encrypt-over.md) %}

           {% include [certificate-usage](../../../_includes/cdn/certificate-usage.md) %}

         For more information, see [{#T}](../../concepts/clients-to-servers-tls.md).
     1. Select the **{{ ui-key.yacloud.cdn.label_host-header }}** value (`{{ ui-key.yacloud.cdn.value_host-header-default }}` or `{{ ui-key.yacloud.cdn.value_host-header-resend }}`) or choose `{{ ui-key.yacloud.cdn.value_host-header-custom }}` and enter the **{{ ui-key.yacloud.cdn.label_custom-host-header }}**. For more information, see [{#T}](../../concepts/servers-to-origins-host.md).
     1. To enable [request redirection](../../concepts/http-rewrite.md) on a CDN resource:

         1. Enable **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.
         1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** field, set a rule, e.g., `/(.*) /new-folder/$1`.

             {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

         1. In the **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** field, specify the required [flag](../../concepts/http-rewrite.md#flag):

             {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

     1. To restrict access to resource content with [secure tokens](../../concepts/secure-tokens.md), enable **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

          {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

        For more information, see [{#T}](enable-secure-token.md).

     1. {% include [enable-ip-policy](../../../_includes/cdn/enable-ip-policy.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. If you have not created resources before, connect to the provider first:

     ```bash
     yc cdn provider activate --type gcore
     ```

  1. View the description of the [CLI](../../../cli/) create resource command:

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
     * Possible `--origin-protocol` values are `HTTP`, `HTTPS`, and `MATCH` (same as the client's).

     {% include [certificate-settings-cli](../../../_includes/cdn/certificate-settings-cli.md) %}

     To enable [request redirection](../../concepts/http-rewrite.md) on a CDN resource, use these parameters:

     * `--rewrite-body`: Rewrite rule, e.g., `--rewrite-body '/(.*) /new-folder/$1'`.

         {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

     * `--rewrite-flag`: [Flag](../../concepts/http-rewrite.md#flag). The possible values are:

         {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

     {% include [access-restrictions-cli](../../../_includes/cdn/access-restrictions-cli.md) %}

     For more information about the `yc cdn resource create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/create.md).
  1. Get the [CNAME record](../../../dns/concepts/resource-record.md#cname) value for the CDN resource:

     ```bash
     yc cdn resource get-provider-cname
     ```

     Result:

     ```text
     cname: cl-ms6*****90.edgecdn.ru
     folder_id: b1gt6g8ht345********
     ```

  1. In [{{ dns-full-name }}](../../../dns/), [create a resource record](../../../dns/operations/resource-record-create.md) with the obtained value.

- {{ TF }} {#tf}

  Make sure to activate the CDN provider before creating a resource. You can activate it in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/) command:

  ```bash
  yc cdn provider activate \
    --folder-id <folder_ID> \
    --type gcore
  ```

  Where:
  * `--folder-id`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) where you want to activate the CDN provider.
  * `--type`: Provider type. The only possible value is `gcore`.

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the CDN resource to create:

     {% include [create-resource-tf](../../../_includes/cdn/create-resource-tf.md) %}

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new CDN resource in the [management console]({{ link-console-main }}) or using this CLI command:

     ```bash
     yc cdn resource list
     ```

  1. Get the [CNAME record](../../../dns/concepts/resource-record.md#cname) value for the CDN resource:

     ```bash
     yc cdn resource get-provider-cname
     ```

     Result:

     ```text
     cname: cl-ms6*****90.edgecdn.ru
     folder_id: b1gt6g8ht345********
     ```

  1. In [{{ dns-full-name }}](../../../dns/), [create a resource record](../../../dns/operations/resource-record-create.md) with the obtained value.

- API {#api}

  If you have not created any resources before, connect to the CDN provider. To do this, use the [activate](../../api-ref/Provider/activate.md) REST API method for the [Provider](../../api-ref/Provider/index.md) resource or the [ProviderService/Activate](../../api-ref/grpc/provider_service.md#Activate) gRPC API call.
  1. Use the [create](../../api-ref/Resource/create.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Create](../../api-ref/grpc/resource_service.md#Create) gRPC API call.

     You can restrict access to the resource with [secure tokens](../../concepts/secure-tokens.md) and an [IP-based access policy](../../concepts/ip-address-acl.md).
  1. Create a [CNAME record](../../../dns/concepts/resource-record.md#cname) for the CDN resource in [{{ dns-full-name }}](../../../dns):
     * To get the CNAME record value for a CDN resource, use the [getProviderCName](../../api-ref/Resource/getProviderCName.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/GetProviderCName](../../api-ref/grpc/resource_service.md#GetProviderCName) gRPC API call.
     * To create a resource record in a DNS zone, use the [updateRecordSets](../../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) gRPC API call.

{% endlist %}

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