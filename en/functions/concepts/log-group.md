# Log group

Log group is a method to group messages from the same source. Such source can be [function](function.md) or IoT-core [registry](../../iot-core/concepts/index.md#registry) for example.

You can get log group identifier by its source with CLI methods. For example, you should execute this command to get the log group of function:

```    
$ yc serverless function get <function_id> | grep log_group_id
```
Result:
```
log_group_id: eol6cgr0************
```