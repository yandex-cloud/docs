---
title: How to set up {{ cdn-full-name }} location rules
description: Follow this guide to set up {{ cdn-full-name }} location rules to selectively redefine CDN resource settings for specific requests.
---

# Setting up {{ cdn-full-name }} location rules

{% include [location-rules-description](../../../_includes/cdn/location-rules-description.md) %}

[Learn more about location rules](../../concepts/location-rules.md)

To set up a location rule:
1. [Create](#create) a rule.
1. [Configure](#setup) advanced settings.

## Creating a location rule {#create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click the CDN resource name.
  1. Select the ![image](../../../_assets/console-icons/map-pin-plus.svg) **{{ ui-key.yacloud.cdn.label_locations }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.cdn.button_resource-locations-empty-action }}**.
  1. Under **{{ ui-key.yacloud.common.overview }}**, configure the main location rule settings:
      * **{{ ui-key.yacloud.common.name }}**.

        The rule name may contain lowercase Latin letters, numbers, underscores, hyphens, and spaces, and may be up to 50 characters long.
      * **{{ ui-key.yacloud.cdn.colunm_location-weight }}**: Rule triggering priority. The lower a rule’s weight, the higher its priority in the user resource configuration. If multiple rules have the same weight, they will be applied in a random order.

        <br>

        {% include [location-rules-weight-example](../../../_includes/cdn/location-rules-weight-example.md) %}

  1. Under **{{ ui-key.yacloud.cdn.label_rule-condition-section }}**, set **{{ ui-key.yacloud.cdn.column_location-rule-pattern }}**, i.e., the URI path pattern against which requests are checked. If there is a match, the settings specific to that location rule will apply.

      {% include [location-rules-pattern-tip](../../../_includes/cdn/location-rules-pattern-tip.md) %}

  1. Specify the CDN resource settings you want to redefine using a location rule:
      * **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}**: Temporary storage of file copies from origins. For more information, see [{#T}](./configure-caching.md).
      * **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**: Redirecting content requests to a different path. This is useful when rearranging files and folders on an origin. You can also use redirection if you want to keep search engine rankings of your content when moving your resource to a new address. For more information, see [{#T}](./setup-http-rewrite.md).
      * **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**: Restricting direct access to content via pre-signed URLs with the limited validity period. For more information, see [{#T}](./enable-secure-token.md).
      * **{{ ui-key.yacloud.cdn.field_address-acl }}**: Restricting access to content using an allowing or blocking policy. For more information, see [{#T}](./configure-basics.md).

      {% include [location-rules-additional](../../../_includes/cdn/location-rules-additional.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  Use the [create](../../api-ref/ResourceRules/create.md) REST API method for the [ResourceRules](../../api-ref/ResourceRules/index.md) resource or the [ResourceRulesService/Create](../../api-ref/grpc/ResourceRules/create.md) gRPC API call.

{% endlist %}

## Configuring advanced settings {#setup}

After creating a rule, you can configure its advanced settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click the CDN resource name.
  1. Select the ![image](../../../_assets/console-icons/map-pin-plus.svg) **{{ ui-key.yacloud.cdn.label_locations }}** tab.
  1. Click the location rule name.
  1. Configure advanced rule settings:

      * To set up advanced content caching options, go to the ![image](../../../_assets/console-icons/cloud.svg) **{{ ui-key.yacloud.cdn.label_resource-cache }}** tab and click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. For more information, see [{#T}](./configure-caching.md).
      * To configure HTTP request and response headers, CORS for responses to clients, and allowed HTTP methods for client requests, go to the ![image](../../../_assets/console-icons/arrow-up-to-line.svg) **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** tab and click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. For more information, see:
          * [{#T}](configure-headers.md)
          * [{#T}](configure-cors.md)
          * [{#T}](configure-http.md)
      * To configure file compression and segmentation, go to the ![image](../../../_assets/console-icons/box.svg) **{{ ui-key.yacloud.cdn.label_resource-content }}** tab and click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. For more information, see:
          * [{#T}](enable-compression.md)
          * [{#T}](enable-segmentation.md)

      Edit the relevant settings and click **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  Use the [update](../../api-ref/ResourceRules/update.md) REST API method for the [ResourceRules](../../api-ref/ResourceRules/index.md) resource or the [ResourceRulesService/Update](../../api-ref/grpc/ResourceRules/update.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](../../concepts/location-rules.md)
* [{#T}](./configure-caching.md)
* [{#T}](./setup-http-rewrite.md)
* [{#T}](./enable-secure-token.md)
* [{#T}](./configure-basics.md)