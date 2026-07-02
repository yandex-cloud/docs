---
title: Developing in Node.js in {{ sf-full-name }}. Overview
description: With {{ sf-name }}, you can run applications written in Node.js. This service provides several runtimes with different OS versions.
---

# Developing in Node.js. Overview

With {{ sf-name }}, you can run applications written in [Node.js](https://nodejs.org/en/docs/).

{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

| Name | Node.js version | SDK version <br>{{ yandex-cloud }} | Operating <br>system | Preloaded  | Supported by {{ sf-name }} |
|----|----|----|----|----|----|
| nodejs10 | 10.16.3 | 1.3.3 | Ubuntu 18.04 | No | No |
| nodejs12 | 12.22.10 | 1.3.3 | Ubuntu 18.04 | No | No |
| nodejs14 | 14.19.0 | 1.3.3 | Ubuntu 18.04 | No | No |
| nodejs16 | 16.14.1 | None | Ubuntu 18.04 | Yes | No |
| nodejs18 | 18.16.1 | None | Ubuntu 22.04 LTS | Yes | No |
| nodejs22 | 22.15.0 | None | Ubuntu 22.04 LTS | Yes | Yes  |

{% include [note-preload-runtime](../../../_includes/functions/note-preload-runtime.md) %}

Some runtimes have an SDK library pre-installed by default to work with the {{ yandex-cloud }} API. For more info on how to use the SDK, see [Using the SDK](sdk.md).

When creating a new [function version](../../concepts/function.md#version), {{ sf-name }} will automatically install all declared dependencies required for the function. For more information about requirements and limitations, see [{#T}](dependencies.md).

The runtime automatically loads your code and invokes the [request handler](handler.md) you specified. It receives the incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically catches the application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. This system also logs entries about the start and end of each function execution, as well as any errors that occur during execution. For more information about the log format, see [{#T}](logging.md).

To learn more about programming in JavaScript or how certain constructs work, see [this JavaScript tutorial](https://javascript.info/).
