---
title: Location rules {{ cdn-full-name }}
description: This section describes location rules, which enable targeted overrides of CDN resource settings for requests with matching path patterns.
---

# Location rules {{ cdn-full-name }}

{% include [location-rules-description](../../_includes/cdn/location-rules-description.md) %}

You can use location rules to override the following CDN resource settings:
* [Content caching](./caching.md)
* [Redirecting requests](./http-rewrite.md)
* [Parameters of access via secure tokens](./secure-tokens.md)
* [IP-based access policy](./ip-address-acl.md)
* [HTTP request and response headers](../operations/resources/configure-headers.md)
* [Allowed HTTP methods for client requests](../operations/resources/configure-http.md)
* [Cross-domain CORS requests](cors.md)
* [Content compression](compression.md)
* [Content segmentation](slicing.md)

{% include [location-rules-additional](../../_includes/cdn/location-rules-additional.md) %}

For each location rule, specify the following parameters:
* _Regular expression_: URI path pattern against which requests are checked. If there is a match, the settings specific to that location rule will apply.

  {% include [location-rules-pattern-tip](../../_includes/cdn/location-rules-pattern-tip.md) %}

* _Rule weight_: Rule triggering priority. The lower a rule’s weight, the higher its priority in the user resource configuration. If multiple rules have the same weight, they will be applied in a random order.

  <br>

  {% include [location-rules-weight-example](../../_includes/cdn/location-rules-weight-example.md) %}

For the full list of location rule parameters, see the [API](../api-ref/ResourceRules/create.md) specification.

You can configure location rules in the [management console]({{ link-console-main }}) or using the [API](../api-ref/ResourceRules/index.md). For more information, see [{#T}](../operations/resources/location-rules.md).

## See also {#see-also}

* [{#T}](./resource.md)
* [{#T}](./caching.md)
* [{#T}](./http-rewrite.md)
* [{#T}](./secure-tokens.md)
* [{#T}](./ip-address-acl.md)
* [{#T}](../operations/resources/location-rules.md)