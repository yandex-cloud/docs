---
title: Developing in Java in {{ sf-full-name }}. Overview
description: With {{ sf-name }}, you can run applications written in Java. The service provides the runtime environment with Java 11 and Ubuntu 18.04.
---

# Developing in Java. Overview

With {{ sf-name }}, you can run applications written in [Java](https://docs.oracle.com/en/java/javase/11/docs/api/index.html).

{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

#|
|| **Name** | **Java version** | **OS** | **Preloaded** | **Supported by the service** ||
|| java11 | 11 | Ubuntu 18.04 | No | No ||
|| java17 | 17 | Ubuntu 18.04 | No | No ||
|| java21 | 21 | Ubuntu 22.04 LTS | No | Yes ||
|#


You can connect the [SDK library](https://github.com/yandex-cloud/java-sdk) to the runtime to work with the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md).


When creating a function version, the [builder](../../concepts/builder.md) will automatically install all declared dependencies required for the function to run. To learn more about the requirements for declaring dependencies, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

If you want to learn more about how to write in Java or how certain statements work, we recommend taking a basic [course on Stepik](https://stepik.org/course/187/promo).
