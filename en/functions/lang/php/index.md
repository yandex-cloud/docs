---
title: "Developing in PHP in {{ sf-full-name }}. Overview"
description: "With {{ sf-name }}, you can run applications written in the PHP programming language. The service provides the runtime environments with PHP 7.4.3 and Ubuntu 18.04."
---

# Developing in PHP. Overview

With {{ sf-name }}, you can run applications written in the [PHP](https://www.php.net/) programming language. The service provides [runtime environments](../../concepts/runtime/index.md) with the following versions:

| Name | PHP version | Operating <br>system | Preloaded |
|----|----|----|----|
| php74 | 7.4.28 | Ubuntu 18.04 | No |
| php8 | 8.0.25 | Ubuntu 18.04 | No |
| php82 | 8.2.11 | Ubuntu 22.04 LTS | No |

When creating a new [function version](../../concepts/function.md#version), {{ sf-name }} will automatically install all declared dependencies required for the function to run. For more information about requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).
