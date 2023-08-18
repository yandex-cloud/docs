# Preloaded runtime environment

A _preloaded runtime environment_ is a special environment that enables you to reduce the cold start time of functions and to receive runtime updates automatically.

Preloaded runtime environments are usually those which have the latest major version. For more information, see the table [{#T}](index.md#runtimes). If a new major version of a runtime environment is added to {{ sf-name }} as a preloaded one, the previous version will no longer be preloaded after a while. A notification will be sent to users who are using the old version, specifying the period available for switching to the new major version.

{% note info %}

{{ sf-name }} does not guarantee that the preload option is used for all runtime environments that support it. For such runtime environments, functions with a regular runtime environment can be invoked.

{% endnote %}

To use preloaded runtime environments as regular ones, [add the following user-defined environment variables](../../operations/function/environment-variables-add.md):

* `X_YCF_NO_RUNTIME_POOL` set to `1`.
* `LD_PRELOAD` or `LD_LIBRARY_PATH` when using [dynamic libraries](environment-variables.md#dynamic-library).

## Initializing a runtime environment {#initialization}

When a function is deployed with a cold start invocation in a normal runtime environment, {{ sf-name }} starts the interpreter after receiving the function invocation request. Therefore, request processing time includes:
* Interpreter start time.
* {{ sf-name }} runtime component initialization time.

When a function is deployed with a cold start invocation in a preloaded runtime environment, the interpreter and the runtime components start before the request is processed. This reduces the response time.

{% note info %}

When the interpreter starts, [custom environment variables](../../operations/function/environment-variables-add.md) are unknown to the preloaded runtime. They are set programmatically before the function code is initialized.

{% endnote %}

## Updating a runtime environment {#update}

If, when creating a [function version](../function.md#version), you select a runtime environment version with the preload option support, it will be automatically updated to the latest minor version available in {{ sf-name }}. The available minor runtime environment version usually lags behind the global minor version.

For example, if Python 3.11 is selected as a preloaded runtime environment, {{ sf-name }} may use 3.11.1 as a minor version while the current global minor version is 3.11.4. After a while, the currently used minor version 3.11.1 will be automatically updated to 3.11.2, then to 3.11.3, etc.

If a runtime environment stops being preloaded, it is no longer updated and is rolled back to the minor version valid at the time of function version creation. If Python 3.12 is added to {{ sf-name }} as a preloaded runtime environment, the minor runtime environment version 3.11.4 will be rolled back to 3.11.1, which was valid in {{ sf-name }} when creating a function version in the example above.

{% note info %}

A runtime environment's major version is not updated automatically.

{% endnote %}

If you select a regular runtime environment when creating a function version, you need to create a new function version with a new runtime environment version to update it.
