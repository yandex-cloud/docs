* `--resource-ids`: IDs of your resources or {{ yandex-cloud }} resources, e.g., functions in {{ sf-name }}. This is an optional setting.
* `--resource-types`: Types of resources, e.g., `serverless.function` in {{ sf-name }}. This is an optional setting.
* `--stream-names`: Log streams. This is an optional setting.
* `--log-levels`: Logging levels. This is an optional setting.
  A trigger fires when the specified log group receives entries that comply with all of the following settings: `resource-ids`, `resource-types`, `stream-names`, and `log-levels`. If the setting is not specified, the trigger fires for any value.