# Preloaded runtime environment

A _preloaded runtime environment_ is a special environment that enables you to reduce the cold start time of functions and to receive runtime updates automatically.

## Initializing a runtime environment {#initialization}

When a function is deployed with a cold start invocation in a normal runtime environment, {{ sf-name }} starts the interpreter after receiving the function invocation request. Therefore, request processing time includes:
* Interpreter start time.
* {{ sf-name }} runtime component initialization time.

When a function is deployed with a cold start invocation in a preloaded runtime environment, the interpreter and the runtime components start before the request is processed. This reduces the response time.

{% note info %}

When the interpreter starts, [custom environment variables](../../operations/function/environment-variables-add.md) are unknown to the preloaded runtime. They are set programmatically before the function code is initialized.

{% endnote %}

## Updating a runtime environment {#update}

If a preloaded runtime environment is selected when creating a function version, it will be automatically updated in the function version settings to the latest version available in {{ sf-name }}.

If a normal runtime environment is selected when creating a function version, you will need to create a new version to update it.
