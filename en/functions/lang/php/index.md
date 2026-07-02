---
title: Developing in PHP in {{ sf-full-name }}. Overview
description: With {{ sf-name }}, you can run applications written in PHP. This service provides the runtimes with PHP 7.4.3 and Ubuntu 18.04.
---

# Developing in PHP. Overview

With {{ sf-name }}, you can run applications written in [PHP](https://www.php.net/).

{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

| Name | PHP version | Operating <br>system | Preloaded | Supported by {{ sf-name }} |
|----|----|----|----|----|
| php74 | 7.4.28 | Ubuntu 18.04 | No | No |
| php8 | 8.0.25 | Ubuntu 18.04 | No | No |
| php82 | 8.2.11 | Ubuntu 22.04 LTS | No | Yes |

When creating a new [function version](../../concepts/function.md#version), {{ sf-name }} will automatically install all declared dependencies required for the function. For more information about requirements and limitations, see [{#T}](dependencies.md).

The runtime automatically loads your code and invokes the [request handler](handler.md) you specified. It receives the incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures the application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. This system also logs entries about the start and end of each function execution, as well as any errors that occur during execution. For more information about the log format, see [{#T}](logging.md).
