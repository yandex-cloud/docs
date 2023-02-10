# x-yc-apigateway-integration:cloud_functions extension

The `x-yc-apigateway-integration:cloud-functions` extension invokes the specified function. As its input, the function accepts the HTTP request data and values of the parameters listed in the specification. As the output, it returns the result of function execution to the client. The request data is transmitted in the same format as that of the current version of the [HTTP integration](../../../functions/concepts/function-invoke.md#http) when invoking the function with the `integration=raw` request string parameter that is most compatible with the AWS API Gateway format. The values of parameters listed in the specification are passed to the `params` field of the `data` parameter.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `function_id` | `string` | ID of the [function](../../../functions/concepts/function.md). |
| `tag` | `string` | Optional. [Tag of the function version](../../../functions/concepts/function.md#tag). The default value is `$latest`.<br>Parameters are substituted in `tag`. |
| `service_account_id` | `string` | ID of the service account used for authorization when accessing the function. If the parameter is omitted, the value of the [top-level](./index.md#top-level) `service_account_id` parameter is used. If there is no top-level parameter, the function is invoked without authorization. |
| `payload_format_version` | `string` | Function call format version. Possible values: [`0.1`](#request_v0) and [`1.0`](#request_v1). Default version is [`0.1`](#request_v0). |
| `context` | `object` | Optional. Operation context is an arbitrary object in `YAML` or `JSON` format. Passed to a function inside a [request](../../../functions/concepts/function-invoke.md#request) in the `requestContext.apiGateway.operationContext`. `Context` is where parameter substitution takes place. |

## Extension specification {#spec}

Example specification:

```yaml
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
        service_account_id: ajehfe56hhlsd4n93q1
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

## The request structure v0.1 {#request_v0}

The request JSON structure for version `0.1` replicates the [request structure](../../../functions/concepts/function-invoke.md#request) to a function with some additional fields:

```json
{
    "url": <actual request path>,
    "path": <path corresponding to the request in the specification>,
    "httpMethod": <HTTP method name>,
    "headers": <dictionary with string values for HTTP headers>,
    "multiValueHeaders": <dictionary with lists of values of HTTP headers>,
    "queryStringParameters": <dictionary of queryString parameters>,
    "multiValueQueryStringParameters": <dictionary of list of values of queryString parameters>,
    "requestContext": <dictionary with the request context>,
    "body": <body of the request>,
    "isBase64Encoded": <true or false>
    "pathParams": <dictionary of values of the request path parameters>,
    "params": <dictionary of values of the request parameters described in the OpenAPI specification>,
    "multiValueParams": <dictionary with lists of request parameter values described in the OpenAPI specification>
}
```

## The request structure v1.0 {#request_v1}

Request JSON structure for version `1.0` is compatible with the request format for [AWS API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format) version `1.0` with some additional fields:

```json
{
    "version": <request format version>,
    "resource": <resource corresponding to the request in the specification>,
    "path": <actual request path>,
    "httpMethod": <HTTP method name>,
    "headers": <dictionary with string values of HTTP headers>,
    "multiValueHeaders": <dictionary with lists of values of HTTP headers>,
    "queryStringParameters": <dictionary of queryString parameters>,
    "multiValueQueryStringParameters": <dictionary of lists of values of queryString parameters>,
    "requestContext": <dictionary with the request context>,
    "pathParameters": <dictionary of the request path parameter values>,
    "body": <request body>,
    "isBase64Encoded": <true or false>,
    // additional fields:    
    "parameters": <dictionary of values of the request parameters described in the OpenAPI specification>,
    "multiValueParameters": <dictionary with lists of values of the request parameters described in the OpenAPI specification>,
    "operationId": <The operationId that corresponds to the request in the OpenAPI specification>
}
```
