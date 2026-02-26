---
title: '{{ cdn-full-name }} release notes'
description: This section contains the {{ cdn-name }} release notes.
---

# {{ cdn-full-name }} release notes

## Q4 2025 {#q4-2025}

* Implemented [location rules](./concepts/location-rules.md), a mechanism used to selectively redefine CDN resource settings for requests whose paths match a specific pattern.
* Now you can enable a CDN resource to [follow request redirects](./concepts/follow-redirects.md) from the origin. With this feature on, {{ cdn-name }} sends a request to the address specified in the origin response and then returns content from the target address to the client.
* Added support for the [WebSocket](https://en.wikipedia.org/wiki/WebSocket) protocol. To enable the feature, contact [support]({{ link-console-support }}).
* Added new [points of presence](./concepts/points-of-presence.md).
* Supported the [pricing calculator for {{ cdn-name }}](https://yandex.cloud/en/prices?state=cc0daabb430b#calculator).
* Added an [{{ at-name }} management event](./at-ref.md), [ResourceDelete](./events-ref/ResourceDelete.md), for deleting a CDN resource.

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
