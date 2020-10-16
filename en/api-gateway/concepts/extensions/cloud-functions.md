# x-yc-apigateway-integration:cloud_functions extension

The `x-yc-apigateway-integration:cloud_functions` extension invokes the specified function. The function receives information about the HTTP request as input and returns the result of function execution to the client. The request data is transmitted in the same format as that of the current version of [HTTP-integration](../../../functions/concepts/function-invoke.md#http) when invoking the function with the `integration=raw` request string parameter that is most compatible with the AWS API Gateway format.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `function_id` | `string` | [Function](../../../functions/concepts/function.md) ID. |
| `tag` | `string` | Optional parameter. [Function version tag](../../../functions/concepts/function.md#tag). The default value is `$latest`. <br>Parameters are substituted in `tag`. |
| `service_account_id` | `string` | ID of the service account used for authorization when accessing the function. If the parameter is omitted, the value of the [top-level](./index.md#top-level) `service_account_id` parameter is used. If there is no top-level parameter, the function is invoked without authorization. |

## Extension specification {#spec}

Sample specification:

```(json)
x-yc-apigateway-integration:
  type: cloud_functions
  function_id: b095c95icnvbuf4v755l
  tag: stable
  service_account_id: ajehfe41hhliq4n93q1g
```

