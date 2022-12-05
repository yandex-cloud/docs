# Log group in {{ sf-name }}

A _log group_ is a way of grouping messages from the same source. This source can be, for example, a [function](function.md) or IoT-core [registry](../../iot-core/concepts/index.md#registry).

You can use the CLI to find out the ID of a log group by its source. To find out a function's log group, run the command:

```
yc serverless function get <function ID> | grep log_group_id
```
Result:
```
log_group_id: eol6cgr0************
```
