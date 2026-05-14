* Log group.
* Optionally, types of resources, e.g., `serverless.function` in {{ sf-name }}.
* Optionally, IDs of your resources or {{ yandex-cloud }} resources, e.g., functions in {{ sf-name }}.
* Optionally, log streams.
* Optionally, logging levels.

A trigger fires when the specified log group receives entries that comply with all of the optional settings. If the optional setting is not specified, the trigger fires for any value.