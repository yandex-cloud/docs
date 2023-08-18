---
title: "Developing in R in {{ sf-full-name }}. Overview"
description: "With {{ sf-name }}, you can run applications written in R. The service provides the runtime environment with R-4.0.5 and Ubuntu 18.04 LTS."
---

# Developing in R. Overview

With {{ sf-name }}, you can run applications written in [R](https://www.r-project.org/index.html). The service provides [runtime environments](../../concepts/runtime/index.md) with the following versions:

| Name | Version of R | Operating <br>system | Preloaded |
|----|----|----|----|
| r402 | 4.0.2 | Ubuntu 18.04 LTS | No |
| r40 | 4.0.5 | Ubuntu 18.04 LTS | No |
| r42 | 4.2.2 | Ubuntu 18.04 LTS | No |

When creating a new [function version](../../concepts/function.md#version) the [builder](../../concepts/builder.md) may automatically install dependencies required for the function to run. For more information about the requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

If you want to learn more about how to write in R or how certain statements work, we recommend taking a basic [course on Stepik](https://stepik.org/course/497/promo).
