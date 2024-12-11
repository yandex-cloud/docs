# Using the SDK for a .NET Core function

The runtime environment does not have a pre-installed library for accessing the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your .NET Core application. The library source code is available on [GitHub](https://github.com/yandex-cloud/dotnet-sdk).

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters.