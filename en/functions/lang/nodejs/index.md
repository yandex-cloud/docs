---
title: Development on Node.js in Yandex Cloud Functions. Overview
description: 'With the Cloud Functions service, you can run applications written in Node.js. The service provides several runtimes with different versions.'

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Development on Node.js. Overview

With {{ sf-name }}, you can run applications written in [Node.js](https://nodejs.org/en/docs/). The service provides several [runtime environments](../../concepts/runtime/index.md) with different versions:

| Name | Node.js version | {{ yandex-cloud }}<br> SDK version | Operating <br>system |
| ---- | ---- | ---- | ---- |
| nodejs10 | 10.16.3 | 1.1.1 | Ubuntu 18.04 LTS |
| nodejs12 | 12.11.1 | 1.1.1 | Ubuntu 18.04 LTS |
| nodejs14 | 14.11.0 | 1.1.1 | Ubuntu 18.04 LTS |

The runtime environment has an SDK library installed by default to work with the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md).

When creating a new [function version](../../concepts/function.md#version), {{ sf-name }} automatically installs all declared dependencies required for the function to run. For more information about requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures standard application output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about how to write in JavaScript or how certain constructs work, see the [Modern JavaScript tutorial](https://javascript.info/).

