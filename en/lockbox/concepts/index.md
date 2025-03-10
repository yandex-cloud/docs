---
title: '{{ lockbox-full-name }}. Service overview'
description: A service for creating and storing secrets in the {{ yandex-cloud }} infrastructure
---

# {{ lockbox-full-name }} overview

{{ lockbox-full-name }} is a service for the centralized storage of secrets, such as passwords, SSH keys, and tokens. A secret is a set of versions that store your data. A version contains one or more key-value pairs. A key is a non-secret ID that identifies a value. The value is your secret data.

{{ lockbox-full-name }} allows users to manage a secret's lifecycle by creating, updating, and deleting secrets in a centralized manner and take advantage of all the access control features that [{{ iam-full-name }}](../../iam/index.yaml) provides.

All secrets are stored in encrypted form. By default, secrets are encrypted with a system key but you can also use [{{ kms-full-name }}](../../kms/index.yaml) with your own keys.

## Interfaces for using the service {#interface}

To work with {{ lockbox-full-name }}, you can use:

* [Management console]({{ link-console-main }}).
* [Command line interface (CLI)](../../cli/).
* API: [REST](../api-ref/) or [gRPC](../api-ref/grpc/).
* SDK: in [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk), or [Node.js](https://github.com/yandex-cloud/nodejs-sdk).