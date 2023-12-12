---
title: "Developing in Node.js in {{ sf-full-name }}. Overview"
description: "With {{ sf-name }}, you can run applications written in Node.js. The service provides several runtime environments with different OS versions."
---

# Developing in Node.js. Overview

With {{ sf-name }}, you can run applications written in [Node.js](https://nodejs.org/en/docs/).


{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

| Name | Node.js version | {{ yandex-cloud }}<br>SDK version | Operating <br>system | Preloaded | Supported by the service |
|----|----|----|----|----|----|
| nodejs10 | 10.16.3 | 1.3.3 | Ubuntu 18.04 | No | No |
| nodejs12 | 12.22.10 | 1.3.3 | Ubuntu 18.04 | No | No |
| nodejs14 | 14.19.0 | 1.3.3 | Ubuntu 18.04 | No | No |
| nodejs16 | 16.14.1 | None | Ubuntu 18.04 | Yes | No |
| nodejs18 | 18.16.1 | None | Ubuntu 22.04 LTS | Yes | Yes |


{% include [note-preload-runtime](../../../_includes/functions/note-preload-runtime.md) %}


Some runtime environments have an SDK library installed by default to work with the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md).


When creating a new [function version](../../concepts/function.md#version), {{ sf-name }} will automatically install all declared dependencies required for the function to run. For more information about requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about how to write in JavaScript or how certain statements work, see the [Modern JavaScript tutorial](https://javascript.info/).
