---
title: "X-yc-apigateway-authorizer:function extension for {{ api-gw-full-name }}"
description: "On this page, you will learn what the x-yc-apigateway-authorizer:function extension is used for and what its specification includes. We will also give you a sample function invoked using this extension."
---

# x-yc-apigateway-authorizer:function extension

The `x-yc-apigateway-authorizer:function` extension is used inside the [securityScheme](https://swagger.io/docs/specification/authentication/) component schemes with the following types:

* [HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/)
* [HTTP Bearer](https://swagger.io/docs/specification/authentication/bearer-authentication/)
* [API Key](https://swagger.io/docs/specification/authentication/api-keys/)

To authorize an HTTP request, {{ api-gw-short-name }} calls the function specified in the extension. Find out more about the [request](#request) and the [response](#response) structures.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `function_id` | `string` | ID of the [function](../../../functions/concepts/function.md). |
| `tag` | `string` | This is an optional parameter. [Tag of the function version](../../../functions/concepts/function.md#tag). Default value: `$latest`.<br>Parameters are substituted in `tag`. |
| `service_account_id` | `string` | Service account ID. Used for authorization when invoking a function. If the parameter is omitted, the value of the top-level [`service_account_id`](./index.md#top-level) parameter is used. If there is no top-level parameter, the function is invoked without authorization. |
| `authorizer_result_ttl_in_seconds` | `int` | This is an optional parameter. A time limit on keeping the function response stored in the local {{ api-gw-short-name }} cache. If the parameter is omitted, the response is not cached. |
| `authorizer_result_caching_mode` | `string` | This is an optional parameter. Authorization result caching mode To use it, make sure to specify the `authorizer_result_ttl_in_seconds` parameter. Possible values: `path` or `URI`. |

## Extension specification {#spec}

Example specification for an HTTP Basic scheme:

```yaml
paths:
  /http/basic/authorize:
    get:
      summary: Authorized operation with http basic security scheme
      operationId: httpBasicAuthorize
      security:
        - httpBasicAuth: [ ]
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "Authorized!"
        http_code: 200
        http_headers:
          'Content-Type': "text/plain"
components:
  securitySchemes:
    httpBasicAuth:
      type: http
      scheme: basic
      x-yc-apigateway-authorizer:
        type: function
        function_id: b095c95icnvbuf4v755l
        tag: "$latest"
        service_account_id: ajehfe84hhlaq4n59q1
        authorizer_result_ttl_in_seconds: 300
```

## Request structure {#request}

Function call JSON structure:

```json
{
    "resource": <resource corresponding to specification request>,
    "path": <actual request path>,
    "httpMethod": <HTTP method name>,
    "headers": <dictionary with HTTP header string values>,
    "queryStringParameters": <dictionary of queryString parameters>,
    "pathParameters": <dictionary of request path parameter values>,
    "requestContext": <dictionary with request context>,
    "cookies": <dictionary with request cookies>
}
```

## Response structure {#response}

Response JSON structure:

```json
{
    "isAuthorized": <authorization result, true or false>,
    "context": <dictionary with authorization context>
}
```

## Function example {#function}

An example function that uses a response structure with an [authorization context](#context):

{% list tabs %}

- JavaScript

  ```js
  exports.handler = async function (event, context) {
      let response = {
          "isAuthorized": false
      };

      if (event.headers.Authorization === "secretToken") {
          response = {
              "isAuthorized": true,
              "context": {
                  "stringKey": "value",
                  "numberKey": 1,
                  "booleanKey": true,
                  "arrayKey": ["value1", "value2"],
                  "mapKey": {"value1": "value2"}
              }
          };
      }

      return response;
  };
  ```

{% endlist %}

`secretToken` is the authorization data of the registered user or trusted client, such as `Basic <base64(username:password)>` or `Bearer <JWT token>`.

## Caching {#caching}

A function response is stored in the local cache {{ api-gw-short-name }} if the extension specifies the `authorizer_result_ttl_in_seconds` parameter.

The contents of a caching key depend on the authorization type and `authorizer_result_caching_mode` parameter value.

| Authorization type | `Path` caching mode | `URI` caching mode | No caching mode specified |
----------------|--------------------------|-------------------------|----------------------------
| [HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/) | `Path`, `operation` (HTTP method) , and `Authorization` header | `URI`, `operation` (HTTP method), and `Authorization` header | `Path`, `operation` (HTTP method) , and `Authorization` header |
| [HTTP Bearer](https://swagger.io/docs/specification/authentication/bearer-authentication/) | `Path`, `operation` (HTTP method) , and `Authorization` header | `URI`, `operation` (HTTP method), and `Authorization` header | `Path`, `operation` (HTTP method) , and `Authorization` header |
| [API Key](https://swagger.io/docs/specification/authentication/api-keys/) | `Path`, `operation` (HTTP method) , and API key | `URI`, `operation` (HTTP method), and API key | `Path`, `operation` (HTTP method) , and API key |

For instance, for the following specification, when making a `/user/123` request, a caching key will be generated from the `/user/{id}`, `GET`, and `Authorization` header. If you change the `authorizer_result_caching_mode` parameter value to `URI`, a caching key will be generated from `/user/123`, `GET`, and the `Authorization` header value.

```yaml
paths:
  /user/{id}:
    get:
      summary: Authorized operation with http basic security scheme
      operationId: httpBasicAuthorize
      parameters:
        - in: path
          name: id
          schema:
            type: integer
          required: true
          description: Numeric ID of the user to get
      security:
        - httpBasicAuth: [ ]
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "Authorized!"
        http_code: 200
        http_headers:
          'Content-Type': "text/plain"
components:
  securitySchemes:
    httpBasicAuth:
      type: http
      scheme: basic
      x-yc-apigateway-authorizer:
        type: function
        function_id: b095c95icnvbuf4v755l
        tag: "$latest"
        service_account_id: ajehfe84hhlaq4n59q1
        authorizer_result_ttl_in_seconds: 300
        authorizer_result_caching_mode: path
```

If, during the time specified in `authorizer_result_ttl_in_seconds`, another HTTP request with similar caching key components is received again, {{ api-gw-short-name }} will use the cached response without invoking the function.

## Authorization context {#context}

If the authorization was successful and another user function is invoked, the authorization context will be passed down in the [request](../../../functions/concepts/function-invoke.md#request) using the `requestContext.authorizer` field. An authorization context may contain data identifying the user that is the source of the HTTP request.

## Possible errors {#errors}

* `401 Unauthorized`: Client failed to send the authorization data defined by the scheme in the HTTP request (e.g., the `Authorization` header for a scheme with the [HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/) type).
* `403 Forbidden`: {{ api-gw-short-name }} did not make a successful function call (`"isAuthorized": false`).
* `500 Internal Server Error`: {{ api-gw-short-name }} could not invoke the function or received a function response with an incorrect structure.
