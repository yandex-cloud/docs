# x-yc-apigateway-integration:cloud_functions extension

The `x-yc-apigateway-integration:cloud-functions` extension invokes the specified function. As its input, the function accepts the HTTP request data and values of the parameters listed in the specification. As the output, it returns the result of function execution to the client. The request data is transmitted in the same format as that of the current version of [HTTP-integration](../../../functions/concepts/function-invoke.md#http) when invoking the function with the `integration=raw` request string parameter that is most compatible with the AWS API Gateway format. The values of parameters listed in the specification are passed to the `params` field of the `data` parameter.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `function_id` | `string` | [Function](../../../functions/concepts/function.md) ID. |
| `tag` | `string` | Optional parameter. [Version tag](../../../functions/concepts/function.md#tag). The default value is `$latest`. <br>Parameters are substituted in `tag`. |
| `service_account_id` | `string` | ID of the service account used for authorization when accessing the function. If the parameter is omitted, the value of the [top-level](index.md#top-level) `service_account_id` parameter is used. If there is no top-level parameter, the function is invoked without authorization. |

## Extension specification {#spec}

Sample specification:

```
/example/{ID}:
    get:
      summary: Get ID
      operationId: getID
      tags:
        - example
      parameters:
        - name: ID
          in: path
          description: Return ID
          required: true
          schema:
            type: string
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icnvbuf4v755l
        tag: "$latest"
        service_account_id: ajehfe41hhliq4n93q1g
```

Function example:

```js
exports.handler= async function (data, context) {
    return {
        'statusCode': 200,
        'isBase64Encoded': false,
        'body': JSON.stringify({
            'petId': data.params.ID
        }),
    }
};
```