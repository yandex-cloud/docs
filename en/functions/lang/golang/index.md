---
title: Developing in Go in {{ sf-full-name }}. Overview
description: With {{ sf-name }}, you can run applications written in Go. This service provides the runtime with different versions.
---

# Developing in Go. Overview

With {{ sf-name }}, you can run applications written in [Go](https://go.dev/doc/).

{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

| Name | Go version | Operating <br>system | Preloaded | Supported by {{ sf-name }}
| ---- | ---- | ---- | ---- | ----
| golang116 | 1.16.15 | Ubuntu 18.04 | No | No
| golang117 | 1.17.8 | Ubuntu 18.04 | No | No
| golang118 | 1.18.5 | Ubuntu 18.04 | No | No
| golang119 | 1.19.3 | Ubuntu 18.04 | No | No
| golang121 | 1.21.9 | Ubuntu 22.04 LTS | No | No
| golang123 | 1.23.9 | Ubuntu 22.04 LTS | No | Yes

You can add an [SDK library](https://github.com/yandex-cloud/go-sdk) to the runtime to work with the {{ yandex-cloud }} API. For more info on how to use the SDK, see [Using the SDK](sdk.md).

When creating a new [function version](../../concepts/function.md#version), the [builder](../../concepts/builder.md) will automatically install all declared dependencies required for the function. For more information about requirements and limitations, see [{#T}](dependencies.md).

{% note warning %}

{% include [move-groups-api](../../../_includes/functions/go-mod-lang-version-notice.md) %}

{% endnote %}

The runtime automatically loads your code and invokes the [request handler](handler.md) you specified. It receives the incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures the application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. This system also logs entries about the start and end of each function execution, as well as any errors that occur during execution. For more information about the log format, see [{#T}](logging.md).

To learn more about programming in Go or how certain constructs work, we recommend taking [this tour of Go](https://go.dev/tour/welcome/1).
