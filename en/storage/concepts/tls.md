---
title: "What is TLS? Transport Layer Security overview"
description: "TLS (Transport Layer Security) is a protocol that supports secure client-server data exchange. To ensure robust protection of your data exchange, use TLS version 1.2 and higher."
keywords:
  - tls protocol
  - tls
  - transport layer security
---

# TLS protocol

{{ objstorage-name }} supports secure client-server data exchange via the Transport Layer Security (TLS) protocol. To ensure robust protection of your data exchange, use TLS version 1.2 or higher.

{{ objstorage-name }} continues to support TLS versions 1.0 and 1.1 at the moment, but plans to deprecate them, although [no issues or vulnerabilities are known](https://datatracker.ietf.org/doc/draft-ietf-tls-oldversions-deprecate/).

Most of Amazon S3-compatible {{ objstorage-name }} clients don't let you explicitly select the TLS version, using the version specified at the system level.

To learn how to configure your clients for TLS version 1.2, see the documentation:
* [AWS SDK for Java](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/security-java-tls.html).
* [AWS SDK for .NET](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/enforcing-tls.html).
* [AWS SDK for JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/enforcing-tls.html).