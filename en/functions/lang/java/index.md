---
title: Developing in Java in {{ sf-full-name }}. Overview
description: With {{ sf-name }}, you can run applications written in Java. This service provides the runtime with Java 11 and Ubuntu 18.04.
---

# Developing in Java. Overview

With {{ sf-name }}, you can run applications written in [Java](https://docs.oracle.com/en/java/javase/11/docs/api/index.html).

{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

#|
|| **Name** | **Java version** | **Operating system** | **Preloaded** | **Supported by {{ sf-name }}** ||
|| java11 | 11 | Ubuntu 18.04 | No | No ||
|| java17 | 17 | Ubuntu 18.04 | No | No ||
|| java21 | 21 | Ubuntu 22.04 LTS | No | Yes ||
|#

You can add an [SDK library](https://github.com/yandex-cloud/java-sdk) to the runtime to work with the {{ yandex-cloud }} API. For more info on how to use the SDK, see [Using the SDK](sdk.md).

When creating a function version, the [builder](../../concepts/builder.md) will automatically install all declared dependencies required for the function. To learn more about the requirements for declaring dependencies, see [{#T}](dependencies.md).

The runtime automatically loads your code and invokes the [request handler](handler.md) you specified. It receives the incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures the application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. This system also logs entries about the start and end of each function execution, as well as any errors that occur during execution. For more information about the log format, see [{#T}](logging.md).

To learn more about programming in Java or how certain constructs work, we recommend taking a basic [course on Stepik](https://stepik.org/course/187/promo).
