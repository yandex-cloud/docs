# x-yc-apigateway-integration:dummy extension

The `x-yc-apigateway-integration:dummy` extension returns fixed content with the specified response code and required headers without any third-party service involved.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Parameter | Type | Description 
----|----|----
`http_code` | `int` | HTTP response code.
`http_headers` | `map[string](string\|[]string)` | It shows the list of headers to send in the response. The parameters are subsituted into `http_headers`.
`content` | `map[string]string` | Data to send in response. <br>It can be either actual content or the result of mapping the requested `Content-Type` to data. This allows you to send errors in the requested format: JSON or XML. The `*` key is used for the default value. The parameters are subsituted into `content`.

## Extension specification {#spec}

Specification example: 

```yaml
x-yc-apigateway-integration:
  type: dummy
  http_code: 302
  http_headers:
    Location: "/some/location"
    Set-Cookie: ["a={number}", "b=2"]
  content:
    "application/json": "{ \"message\": \"You've been redirected.\" }"
```

Extension features:
* If the request contains the `Accept` header:
    * The best match is selected first.
    * If there is no match, the `*` key is selected.
    * If there is no key, the `415 Media not supported` response is returned. 
* If the `Accept` header is missing, any response may be selected.
* If the content option is selected by the `*` key, the response's `Content-Type` will be picked from `http_headers`. If it is not specified there, the actual `Content-Type` is returned.


## Use cases {#examples}

* [{#T}](../../tutorials/api-gw-sws-integration.md)
* [{#T}](../../tutorials/api-gw-websocket.md)
* [{#T}](../../tutorials/slack-bot-serverless.md)
