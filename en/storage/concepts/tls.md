---
title: What is TLS? Transport Layer Security overview
description: TLS (Transport Layer Security) is a protocol that supports secure client-server data exchange. To ensure robust protection of your data exchange, use TLS version 1.2 or higher.
keywords:
  - TLS protocol
  - tls
  - transport layer security
---

# TLS protocol



{{ objstorage-name }} supports secure client-server data exchange via the Transport Layer Security (TLS) protocol. To ensure robust protection of your data exchange, use TLS version 1.2 or higher.

{% note alert %}

Starting July 1, 2025, {{ objstorage-name }} will discontinue support for TLS versions 1.0 and 1.1.

{% endnote %}

We recommend updating the TLS protocol on the client side of the software to version 1.2 or higher.

To temporarily continue to use TLS versions 1.0 and 1.1 to work with {{ objstorage-name }}, try the following solutions:
* For website hosting: [Bucket](bucket.md) configured as [static website hosting](hosting.md) as a content [source](../../cdn/concepts/origins.md) in [{{ cdn-full-name }}](../../cdn/concepts/index.md). The connection between the client and the CDN server will be over TLS versions 1.0 and 1.1, and between the CDN server and {{ objstorage-name }}, over TLS version 1.2 or higher.
* For other scenarios: {{ compute-full-name }} VM with a web server and [L7 balancing](../../application-load-balancer/concepts/application-load-balancer.md), e.g., [NGINX](https://nginx.org/en/), as a reverse proxy server. The connection between the client and the proxy server will be over TLS versions 1.0 or 1.1, and between the proxy server and {{ objstorage-name }}, over TLS version 1.2 or higher.


Most Amazon S3-compatible {{ objstorage-name }} clients do not allow you to explicitly select the TLS version; instead, they use the version specified at the system level.

For more information on configuring clients to work with TLS version 1.2 and higher, see these AWS guides:
* [AWS SDK for Java](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/security-java-tls.html)
* [AWS SDK for .NET](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/enforcing-tls.html)
* [AWS SDK for JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/enforcing-tls.html)