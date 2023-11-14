---
title: "Developing in Python in {{ sf-full-name }}. Overview"
description: "With {{ sf-name }}, you can run applications written in Python. The service provides several runtime environments with different versions."
---

# Developing in Python. Overview

With {{ sf-name }}, you can run applications written in [Python](https://python.org/).


The service provides several [runtime environments](../../concepts/runtime/index.md) with different versions:

| Name | Python version | Operating <br>system | Preloaded |
|----|----|----|----|
| python37 | 3.7.13 | Ubuntu 18.04 | No |
| python38 | 3.8.13 | Ubuntu 18.04 | No |
| python39 | 3.9.11 | Ubuntu 18.04 | No |
| python311 | 3.11.0 | Ubuntu 18.04 | Yes |
| python312 | 3.12.0 | Ubuntu 22.04 LTS | Yes |


{% note info %}

Function behavior in preloaded and normal runtime environments may differ. Review the features of function behavior in [{#T}](../../concepts/runtime/preload-runtime.md).

{% endnote %}


By default, the `python37` and `python38` runtime environments have a built-in SDK library to handle the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md). You can install the SDK library in other versions of the runtime by specifying a dependency in `requirements.txt`.


{{ sf-name }} automatically installs all the specified dependencies required for the function to run. Dependencies are installed when creating a new [function version](../../operations/function/version-manage.md). For more information, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about developing in Python or how certain statements work, see the [official Python documentation](https://docs.python.org/3.7/).
