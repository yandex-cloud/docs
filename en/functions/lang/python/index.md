---
title: Development in Python at Yandex Cloud Functions. Overview
description: 'With the Cloud Functions service, you can run Python applications. The service provides several runtimes with different versions.'
---

# Development in Python. Overview

With {{ sf-name }}, you can run applications written in [Python](https://python.org/). The service provides several [runtime environments](../../concepts/runtime/index.md) with different versions:

| Name | Python version | Operating <br>system | Preloaded |
| ---- | ---- | ---- | ---- |
| python37 | 3.7.12 | Ubuntu 18.04 LTS | No |
| python38 | 3.8.12 | Ubuntu 18.04 LTS | No |
| python39 | 3.9.7 | Ubuntu 18.04 LTS | Yes |

{% note info %}

Function behavior in preloaded and normal runtime environments may differ. Review the features of function behavior in [{#T}](../../concepts/runtime/preload-runtime.md).

{% endnote %}

By default, the `python37` and `python38` runtime environments have a built-in SDK library to handle the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md). You can install the SDK library in other versions of the runtime by specifying a dependency in `requirements.txt`.

{{ sf-name }} automatically installs all the specified dependencies required for the function to run. Dependencies are installed when creating a new [function version](../../operations/function/version-manage.md#func-version-create). For more information, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about how to write in Python or how certain statements work, see the [official Python documentation](https://docs.python.org/3.7/).

