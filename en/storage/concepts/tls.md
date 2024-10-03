---
title: What is TLS? Transport Layer Security overview
description: TLS (Transport Layer Security) is a protocol that supports secure client-server data exchange. To ensure robust protection of your data exchange, use TLS version 1.2 and higher.
keywords:
  - tls protocol
  - tls
  - transport layer security
---

# TLS protocol

{{ objstorage-name }} supports secure client-server data exchange via the Transport Layer Security (TLS) protocol. To ensure robust protection of your data exchange, use TLS version 1.2 or higher.

Currently, {{ objstorage-name }} supports TLS 1.0 and 1.1; however this support will be discontinued moving forward, although [no issues or vulnerabilities have been detected](https://datatracker.ietf.org/doc/draft-ietf-tls-oldversions-deprecate/).

Most Amazon S3-compatible {{ objstorage-name }} clients do not allow you to explicitly select the TLS version; instead, they use the version specified at the system level.

To learn how to configure your clients for TLS 1.2, see these AWS guides:
* [AWS SDK for Java](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/security-java-tls.html)
* [AWS SDK for .NET](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/enforcing-tls.html)
* [AWS SDK for JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/enforcing-tls.html)