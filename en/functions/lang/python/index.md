---
title: Developing in Python in {{ sf-full-name }}. Overview
description: With {{ sf-name }}, you can run applications in Python. It offers multiple runtimes with different environment versions.
---

# Developing in Python. Overview

With {{ sf-name }}, you can run applications written in [Python](https://python.org/).

{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

| Name | Python version | Operating <br>system | Preloaded | Supported |
|----|----|----|----|----|
| python37 | 3.7.13 | Ubuntu 18.04 | No | No |
| python38 | 3.8.13 | Ubuntu 18.04 | No | No |
| python39 | 3.9.11 | Ubuntu 18.04 | No | No |
| python311 | 3.11.0 | Ubuntu 18.04 | No | No |
| python312 | 3.12.0 | Ubuntu 22.04 LTS | Yes | Yes |
| python314 | 3.14.0 | Ubuntu 22.04 LTS | Yes | Yes |

{% include [note-preload-runtime](../../../_includes/functions/note-preload-runtime.md) %}

By default, the `python37` and `python38` runtimes have a pre-installed SDK library for the {{ yandex-cloud }} API. For more info on how to use the SDK, see [Using the SDK](sdk.md). You can install the SDK library to other runtime versions by specifying a dependency in `requirements.txt`.

{{ sf-name }} automatically installs all the specified dependencies required for the function. Dependencies are installed when creating a new [function version](../../operations/function/version-manage.md). For more information, see [{#T}](dependencies.md).

The runtime automatically loads your code and invokes the [request handler](handler.md) you specified. It receives the incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures the application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. This system also logs entries about the start and end of each function execution, as well as any errors that occur during execution. For more information about the log format, see [{#T}](logging.md).

To learn more about programming in Python or how certain constructs work, see the [official Python documentation](https://docs.python.org/3.12/).
