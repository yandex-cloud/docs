---
title: '{{ cdn-full-name }} release notes'
description: This section contains the {{ cdn-name }} release notes.
---

# {{ cdn-full-name }} release notes

## Q2 2026 {#q2-2026}

* {{ cdn-name }} is now available in the Kazakhstan [region](../overview/concepts/region.md).
* Updated the [pricing](./pricing.md) model.
* Added resource-based pricing for [dedicated IP addressing](./concepts/dedicated-ip-addressing.md). 
* Introduced a [limit](./concepts/limits.md#cdn-limits) on the number of dedicated IP addresses for CDN resources per billing account.
* Extended the list of HTTP methods blocked by default in client requests: aside from `POST`, now `PUT`, `PATCH`, and `DELETE` are also blocked. For more on activating methods, see [{#T}](./troubleshooting.md#post-responses).
* Extended the network of our [points of presence](./concepts/points-of-presence.md): the Russia [region](../overview/concepts/region.md) now has 65 PoPs with a total throughput exceeding 7 Tbps.
* Fixed errors related to the [{{ TF }} provider](../terraform/release-notes.md).
* Improved the [management console]({{ link-console-main }}) interface:
    * Moved the following fields to the origin settings section:
      * **{{ ui-key.yacloud.cdn.label_protocol }}**
      * **{{ ui-key.yacloud.cdn.field_origin }}**
      * **{{ ui-key.yacloud.cdn.label_host-header }}**
    * Moved these fields to a dedicated tab, **{{ ui-key.yacloud.cdn.label_section-security }}**:
      * **{{ ui-key.yacloud.cdn.label_redirect }}**
      * **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**
      * **{{ ui-key.yacloud.cdn.field_secure-key-type }}**
      * **{{ ui-key.yacloud.cdn.field_address-acl }}**
    * Improved error display in wizard steps when creating a CDN resource and origin group. Now you see each error on the actual step where it occurred.
    * If you select an L7 load balancer as an origin, the drop-down list now displays only load balancers that have public IP addresses linked.

## Q1 2026 {#q1-2026}

* Now you can specify a different [origin](./concepts/origins.md) for a [CDN resource](./concepts/resource.md) in [location rules](./concepts/location-rules.md) without inheriting settings from the main configuration.
* Implemented [TLS security profiles](./concepts/clients-to-servers-tls.md#tls-profiles) for a CDN resource, containing certain allowed TLS ciphers.
* Added support for [configuring a custom server name for SNI](./operations/resources/configure-server-name.md).
* In the [management console]({{ link-console-main }}), implemented the ability to configure for a CDN resource the allowed HTTP `POST` method in client requests as well as [WebSocket](https://{{ lang }}.wikipedia.org/wiki/WebSocket) support. To activate these options, contact [support]({{ link-console-support }}). For more information, see [{#T}](./troubleshooting.md#post-responses) and [{#T}](./troubleshooting.md#websocket-support).
* Added an [HTTP response configuration](./operations/resources/configure-response.md) option to set a code for a CDN resource redirect or a static response code with a predefined response body.
* Added a CDN resource blocking status indicator to the management console. The status is displayed if the CDN resource has been blocked for violating the terms of use.
* Now you can set a custom [content caching](./concepts/caching.md) duration.
* Now you can set up how to [follow request redirects](./concepts/follow-redirects.md) in the management console.

## Q4 2025 {#q4-2025}

* Implemented [location rules](./concepts/location-rules.md), a mechanism used to selectively redefine CDN resource settings for requests whose paths match a specific pattern.
* Now you can enable a CDN resource to [follow request redirects](./concepts/follow-redirects.md) from the origin. With this feature on, {{ cdn-name }} sends a request to the address specified in the origin response and then returns content from the target address to the client.
* Added support for the [WebSocket](https://en.wikipedia.org/wiki/WebSocket) protocol. To enable the feature, contact [support]({{ link-console-support }}).
* Added new [points of presence](./concepts/points-of-presence.md).
* Supported the [pricing calculator for {{ cdn-name }}](https://yandex.cloud/en/prices?state=cc0daabb430b#calculator).
* Added an [{{ at-name }} management event](./at-ref.md), `ResourceDelete`, for deleting a CDN resource.

## Q3 2025 {#q3-2025}

* Added a {{ cdn-full-name }} provider based on Yandex's proprietary technology.

* You can now select a provider when creating a [resource](./operations/resources/create-resource.md) or [origin group](./operations/origin-groups/create-group.md).

* Updated the CDN resource creation interface:

  * Creating and configuring a resource through the wizard are made simpler.
  * You can now duplicate the configuration of an existing CDN resource.

* Added functionality to manage resource use rules for the {{ cdn-full-name }} provider. This setting is available in the [API](./api-ref/ResourceRules/index.md).

* Fixed bugs related to {{ TF }}:

  * Incorrect display of the `provider_cname` resource domain name.
  * Not being able to select a provider for a resource.

## Q4 2024 {#q4-2024}

Added the option to [assign](./operations/resources/labeling.md) {{ resmgr-full-name }} [labels](./concepts/labels.md) to CDN resources.

## Q3 2024 {#q3-2024}

* Added the [request redirection](./concepts/http-rewrite.md) feature. This setting is available in the management console, CLI, and API.
* Added support for setting up an [IP-based access policy](./concepts/ip-address-acl.md) in the management console.

## Q2 2024 {#q2-2024}

You can now [configure secure token access](./operations/resources/enable-secure-token.md) in the management console.

## Q1 2024 {#q1-2024}

* Added support for [IP-based access policies](./concepts/ip-address-acl.md) for CDN resources.
* Implemented a system for restricting access to a CDN resource using [secure tokens](./concepts/secure-tokens.md).
* Removed support for automatic issue of TLS certificates for CDN resources by the EdgeCenter CDN provider. Now, you must pre-upload TLS certificates to {{ certificate-manager-full-name }}. For more information, see [{#T}](./concepts/clients-to-servers-tls.md).
