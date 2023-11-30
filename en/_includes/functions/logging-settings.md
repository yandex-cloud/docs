* Log group.
* (Optional) Resource types, such as `serverless.function` for {{ sf-name }} functions.
* (Optional) IDs of {{ yandex-cloud }} or your resources, such as {{ sf-name }} functions.
* (Optional) Log streams.
* (Optional) Logging levels.

A trigger fires when records that match all the optional settings are added to the specified log group. If an optional setting is not specified, the trigger fires for any value of the setting.