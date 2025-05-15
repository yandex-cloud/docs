---
title: '{{ cdn-full-name }} release notes'
description: This section contains {{ cdn-name }} release notes.
---

# {{ cdn-full-name }} release notes

## Q4 2024 {#q4-2024}

Added the option to [assign](./operations/resources/labeling.md) {{ resmgr-full-name }} [labels](./concepts/labels.md) to CDN resources.

## Q3 2024 {#q3-2024}

* Added the [request redirection](./concepts/http-rewrite.md) feature. This setting is available in the YC management console, CLI, and API.
* Added support for setting up an [IP-based access policy](./concepts/ip-address-acl.md) in the management console.

## Q2 2024 {#q2-2024}

You can now [configure secure token access](./operations/resources/enable-secure-token.md) in the management console.

## Q1 2024 {#q1-2024}

* Added support for [IP-based access policies](./concepts/ip-address-acl.md) for CDN resources.
* Implemented a system for restricting access to a CDN resource using [secure tokens](./concepts/secure-tokens.md).
* Removed support for automatic issue of TLS certificates for CDN resources by the EdgeCenter CDN provider. Now, you must pre-upload TLS certificates to {{ certificate-manager-full-name }}. For more information, see [{#T}](./concepts/clients-to-servers-tls.md).
