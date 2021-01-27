# Overview

With {{ sf-name }}, you can run applications written in [Python](https://python.org/). The service provides several [runtime environments](../../concepts/runtime/index.md) with different versions:

| Name | Python version | Operating <br>system |
| ---- | ---- | ---- |
| python27 (**deprecated**) | 2.7.17 | Ubuntu 18.04 LTS |
| python37 | 3.7.6 | Ubuntu 18.04 LTS |
| python37-preview | 3.7.6 | Ubuntu 18.04 LTS |
| python38 | 3.8.5 | Ubuntu 18.04 LTS |

{% note info %}

Note that the `python27` runtime environment is considered obsolete, since Python 2 is no longer supported by the community and is not updated.

{% endnote %}

The runtime environment has an SDK library installed by default to work with the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md).

When using the `python37-preview` and `python38` runtime, {{ sf-name }} automatically installs all declared dependencies required for the function to run. Dependencies are installed when creating a new [function version](../../operations/function/version-manage.md#func-version-create). For more information, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about how to write in Python or how certain statements work, see the [official Python documentation](https://docs.python.org/3.7/).

