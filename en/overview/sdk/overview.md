---
title: '{{ yandex-cloud }} SDK overview'
description: Learn about the SDKs used to work with {{ yandex-cloud }}
sourcePath: en/sdk/sdk/overview.md
---

# {{ yandex-cloud }} SDK overview

{{ yandex-cloud }} SDK is a set of development tools for interfacing with cloud infrastructure.

The SDKs support most {{ yandex-cloud }} services and are available for the following programming languages and frameworks:
* [Node.js](https://github.com/yandex-cloud/nodejs-sdk)
* [Go](https://github.com/yandex-cloud/go-sdk)
* [Python](https://github.com/yandex-cloud/python-sdk)
* [Java](https://github.com/yandex-cloud/java-sdk)
* [.NET](https://github.com/yandex-cloud/dotnet-sdk)

For more information about integrating SDKs into your project, see [{#T}](./quickstart.md).

## Service SDKs {#service-sdks}

For some services, dedicated SDKs are available:
* [{{ ml-sdk-full-name }}](../../foundation-models/sdk/index.md) for [{{ ai-studio-full-name }}](/ai-studio) services.
* [{{ speechkit-name }} Python SDK](../../speechkit/sdk/python/index.md) for [{{ speechkit-full-name }}](../../speechkit/).
* [Video player SDK](../../video/sdk/index.md) for [{{ video-full-name }}](../../video/).
* [YDB SDK](https://ydb.tech/docs/en/reference/ydb-sdk/) for [{{ ydb-full-name }}](../../ydb/) and [{{ yq-full-name }}](../../query/).

## AWS SDK {#aws-sdk}

For services supporting AWS API compatibility, integration with the [AWS SDK](https://aws.amazon.com/developer/tools/) is available:
* [{{ objstorage-full-name }}](../../storage/tools/sdk/index.md)
* [{{ yds-full-name }}](../../data-streams/operations/aws-sdk/prepare.md)
* [{{ cns-full-name }}](../../notifications/tools/sdk-python.md)
* [{{ ydb-full-name }}](../../ydb/docapi/tools/aws-sdk/index.md)

## Working with the {{ yandex-cloud }} SDK in {{ sf-full-name }} {#serverless}

In {{ sf-name }}, you can use the {{ yandex-cloud }} SDK in [function](../../functions/concepts/function.md) code. For more information, see the language- or framework-specific guides:
* [Node.js](../../functions/lang/nodejs/sdk.md)
* [Python](../../functions/lang/python/sdk.md)
* [Go](../../functions/lang/golang/sdk.md)
* [Bash](../../functions/lang/bash/sdk.md)
* [Java](../../functions/lang/java/sdk.md)
* [Kotlin](../../functions/lang/kotlin/sdk.md)
* [.NET Core](../../functions/lang/csharp/sdk.md)

## See also {#see-also}

* [{{ console-full-name }}](../../console/)
* [{{ yandex-cloud }} CLI](../../cli/)
* [{{ TF }} to {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md)
* [{{ yandex-cloud }} API](../../api-design-guide/)