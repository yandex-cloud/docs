# x-yc-apigateway-integration:cloud_functions extension

The `x-yc-apigateway-integration:cloud_functions` extension invokes the relevant function. As its input, the function accepts the HTTP request data and values of the properties listed in the specification. As the output, it returns the result of function execution to the client.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Parameter | Type | Description 
----|----|----
`function_id` | `string` | [Function](../../../functions/concepts/function.md) ID.
`tag` | `string` | This is an optional parameter. It specifies the [tag of the function version](../../../functions/concepts/function.md#tag). The default value is `$latest`. <br>The parameters are subsituted into `tag`.
`service_account_id` | `string` | ID of the service account used for authorization when accessing the function. If you omit the parameter, the `service_account_id` [top-level](./index.md#top-level) parameter value will be used. If the top-level parameter is also missing, the function is invoked without authorization. 
`payload_format_version` | `string` | Function call format version. It can be either [`0.1`](#request_v0) or [`1.0`](#request_v1). [`0.1`](#request_v0) is the default version.
`context` | `object` | This is an optional parameter. It provides the operation context, i.e., an object in `YAML` or `JSON` format. It is provided to a function within a [request](../../../functions/concepts/function-invoke.md#request) in the `requestContext.apiGateway.operationContext` field. The parameters are subsituted into `context`.

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

## Request structure for v0.1 {#request_v0}

The request JSON structure for version `0.1` replicates the [structure of a request](../../../functions/concepts/function-invoke.md#request) to a function with some additional fields:

```json
{
    "url": <actual request path>,
    "path": <path matching specification request>,
    "httpMethod": <HTTP method name>,
    "headers": <dictionary with HTTP header string values>,
    "multiValueHeaders": <dictionary with lists of HTTP header values>,
    "queryStringParameters": <dictionary of queryString parameters>,
    "multiValueQueryStringParameters": <dictionary with lists of queryString parameter values>,
    "requestContext": <dictionary with request context>,
    "body": <request contents>,
    "isBase64Encoded": <true or false>,
    "pathParams": <dictionary of request path parameter values>,
    "params": <dictionary of request parameter values as described in the OpenAPI spec>,
    "multiValueParams": <dictionary with request parameter value lists as described in the OpenAPI spec>
}
```

## Request structure for v1.0 {#request_v1}

The request JSON structure for version `1.0` is compatible with the request format for [AWS API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format) version `1.0` with some additional fields:

```json
{
    "version": <request format version>,
    "resource": <resource matching specification request>,
    "path": <actual request path>,
    "httpMethod": <HTTP method name>,
    "headers": <dictionary with HTTP header string values>,
    "multiValueHeaders": <dictionary with lists of HTTP header values>,
    "queryStringParameters": <dictionary of queryString parameters>,
    "multiValueQueryStringParameters": <dictionary with lists of queryString parameter values>,
    "requestContext": <dictionary with request context>,
    "pathParameters": <dictionary of request path parameter values>,
    "body": <request contents>,
    "isBase64Encoded": <true or false>,
    // additional fields:    
    "parameters": <dictionary of request parameter values as described in the OpenAPI spec>,
    "multiValueParameters": <dictionary with request parameter value lists as described in the OpenAPI spec>,
    "operationId": <operationId matching the request in the OpenAPI spec>
}
```

Structure of the `requestContext` element:

```json
    {
        "identity": <a set of key:value pairs to authenticate the user>,
        "httpMethod": <DELETE, GET, HEAD, OPTIONS, PATCH, POST, or PUT>,
        "requestId": <request ID generated in the router>,
        "requestTime": <request time in CLF format>,
        "requestTimeEpoch": <request time in Unix format>,
        "authorizer": <dictionary with authorization context>,
        "apiGateway": <dictionary with specific data transmitted by API gateway during function invocation>,
        "connectionId": <web socket connection ID>",
        "connectedAt": <web socket connection time>,
        "eventType": <type of web socket event or operation: CONNECT, MESSAGE, DISCONNECT>,
        "messageId": <ID of the message received from the web socket>,
        "disconnectStatusCode": <web socket close code>,
        "disconnectReason": <text description of the reason the web socket was closed>
    }
```

Structure of the `authorizer` element:
```json
    {
        "jwt": { // Field filled in by the API Gateway JWT authorizer. It contains the token data about the user and the user's permissions'
          "claims": <dictionary of JWT body fields>,
          "scopes": <list of JWT owner permissions>
        }
        // Other authorization context fields returned from the authorizer function
    }
```

## Use cases {#examples}

* [{#T}](../../tutorials/api-gw-integration.md)
* [{#T}](../../tutorials/canary-release.md)
* [{#T}](../../tutorials/recognizer-bot.md)
* [{#T}](../../tutorials/java-servlet-todo-list.md)
