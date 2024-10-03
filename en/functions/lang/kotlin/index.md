---
title: Developing in Kotlin in {{ sf-full-name }}. Overview
description: With {{ sf-name }}, you can run applications written in Kotlin. The service provides the runtime environment with Kotlin 2.0 and Ubuntu 22.04 LTS.
---

# Developing in Kotlin: Overview

With {{ sf-name }}, you can run applications written in [Kotlin](https://kotlinlang.org/docs/home.html).

#|
|| **Name** | **Kotlin version** | **JVM version** | **Operating system** | **Preloaded** | **Supported by the service** ||
|| kotlin20 | 2.0 | 21 | Ubuntu 22.04 LTS | No | Yes ||
|#

You can connect the [SDK library](https://github.com/yandex-cloud/java-sdk) to the runtime to work with the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md).

When creating a function version, the [builder](../../concepts/builder.md) will automatically install all declared dependencies required for the function to run. To learn more about the requirements for declaring dependencies, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. The handler arguments depend on the [Kotlin programming model](model/index.md) being used.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about how to write in Kotlin or how certain constructs work, we recommend taking [a tour of Kotlin](https://kotlinlang.org/docs/kotlin-tour-welcome.html).
