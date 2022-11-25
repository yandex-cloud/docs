---
title: "Development in R in Yandex Cloud Functions. Overview"
description: "With the Cloud Functions service, you can run applications written in R. The service provides a runtime environment with language version 4.0.5 and Ubuntu 18.04 LTS operating system."
---

# Developing in R. Overview

With {{ sf-name }}, you can run applications written in [R](https://www.r-project.org/index.html). The service provides the [runtime environment](../../concepts/runtime/index.md) with R-4.0.5 and Ubuntu 18.04 LTS.

When creating a new [function version](../../concepts/function.md#version) the [builder](../../concepts/builder.md) may automatically install dependencies required for the function to run. For more information about the requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

If you want to learn more about how to write in R or how certain statements work, we recommend taking a basic [course on Stepik](https://stepik.org/course/497/promo).
