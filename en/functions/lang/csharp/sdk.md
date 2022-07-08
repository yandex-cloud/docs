# Using the SDK for C# functions

The runtime environment doesn't have a pre-installed library for working with the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your C# application. The library source code is available on [GitHub](https://github.com/yandex-cloud/dotnet-sdk).

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters.