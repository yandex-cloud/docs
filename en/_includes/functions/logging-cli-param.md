* `--resource-ids`: IDs of {{ yandex-cloud }} or your resources, such as {{ sf-name }} functions.
* `--resource-types`: Resource types, such as `serverless.function` for {{ sf-name }} functions.
* `--stream-names`: Log streams.
* `--log-levels`: Logging levels.
  The trigger fires when the specified log group receives records that match all of the following parameters: `resource-ids`, `resource-types`, `stream-names`, and `log-levels`. If a parameter is not specified, the trigger fires for any value of the parameter.

