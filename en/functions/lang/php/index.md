---
title: PHP Development at Yandex Cloud Functions. Overview
description: 'With the Cloud Functions service, you can run applications written in the PHP programming language. The service provides runtimes with the following versions — php74, 7.4.3, Ubuntu 18.04 LTS.'

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# PHP Development. Overview

With {{ sf-name }}, you can run applications written in the [PHP](https://www.php.net/) programming language. The service provides [runtime environments](../../concepts/runtime/index.md) with the following versions:

| Name | PHP version | Operating <br>system |
| ---- | ---- | ---- |
| php74 | 7.4.3 | Ubuntu 18.04 LTS |

When creating a new [function version](../../concepts/function.md#version), {{ sf-name }} automatically installs all declared dependencies required for the function to run. For more information about requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures standard application output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

