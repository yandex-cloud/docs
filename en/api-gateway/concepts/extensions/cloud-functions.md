# x-yc-apigateway-integration:cloud_functions extension

The `x-yc-apigateway-integration:cloud-functions` extension invokes the relevant function. As its input, the function accepts the HTTP request data and values of the properties listed in the specification. As the output, it returns the result of function execution to the client.
{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `function_id` | `string` | ID of the [function](../../../functions/concepts/function.md). |
| `tag` | `string` | This is an optional parameter. It specifies the [tag of the function version](../../../functions/concepts/function.md#tag). The default value is `$latest`.<br>The `tag` property is used for parameter substitution. |
| `service_account_id` | `string` | ID of the service account used for authorization when accessing the function. If it is not specified, its default value is taken from the [parent](./index.md#top-level) `service_account_id`. If the parent parameter is also missing, the function is invoked without authorization. |
| `payload_format_version` | `string` | Function call format version. The possible values are [`0.1`](#request_v0) and [`1.0`](#request_v1). The default version is [`0.1`](#request_v0). |
| `context` | `object` | This is an optional parameter. This is the operation context, an object in `YAML` or `JSON` format. It is provided to a function within a [request](../../../functions/concepts/function-invoke.md#request) in the `requestContext.apiGateway.operationContext` field. `context` is used for parameter substitution. |

## Extension specification {#spec}

Specification example:

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
        function_id: b095c95icnvb********
        tag: "$latest"
        service_account_id: ajehfe56hhl********
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

## v0.1 request structure {#request_v0}

The request JSON structure for version `0.1` replicates the [structure of a request](../../../functions/concepts/function-invoke.md#request) to a function with some additional fields:

```json
{
    "url": <actual request path>,
    "path": <path matching the request in the specification>,
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

## v1.0 request structure {#request_v1}

Request JSON structure for version `1.0` is compatible with the request format for [AWS API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format) version `1.0` with some additional fields:

```json
{
    "version": <request format version>,
    "resource": <resource matching the request in the specification>,
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
    "operationId": <operationId matching the request in the OpenAPI specification>
}
```

`requestContext` element structure:

```json
    {
        "identity": <key:value pairs for user authentication>,
        "httpMethod": <DELETE, GET, HEAD, OPTIONS, PATCH, POST, or PUT>,
        "requestId": <request ID generated on the router side>,
        "requestTime": <request time in CLF format>,
        "requestTimeEpoch": <request time in Unix format>,
        "authorizer": <dictionary with authorization context>,
        "apiGateway": <dictionary of custom data transmitted by API gateway for function call>,
        "connectionId": <web socket connection ID>",
        "connectedAt": <web socket connection time>,
        "eventType": <web socket event or operation type: CONNECT, MESSAGE, or DISCONNECT>,
        "messageId": <ID of message received from web socket>,
        "disconnectStatusCode": <web socket closure status code>,
        "disconnectReason": <web socket disconnection cause description in text format>
    }
```

`authorizer` element structure:
```json
    {
        "jwt": { // Field that is filled in by the API Gateway JWT authorizer. It contains data about the user and their permissions'
          "claims": <dictionary of JWT body fields>,
          "scopes": <list of JWT owner permissions>
        }
        // Other authorization context fields returned from the authorizer function
    }
```
