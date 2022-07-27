# Python function call handler

A _call handler_ is a method used to process each Python function call. When creating a function version, you should specify an entry point that consists of a file name and a call handler name (such as, `main.handler`).

{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}

When invoking the handler, the runtime passes the following arguments:
1. Call body (`event` parameter):
   * If the call body is a [JSON document](../../concepts/function-invoke.md#request), it's converted to `dict` using the `json.loads` method.
   * If a function was invoked with the `integration=raw` request string parameter, the HTTP request body is passed to the function as-is (unprocessed).
1. [Invocation context](context.md) (`context` parameter).

   The context contains the necessary information about the function version. The structure of this object is described in [{#T}](context.md).

## Handler types {#type}

A function can use both synchronous and asynchronous request handlers.

## Synchronous handler {#sync}

To have the output returned, use the `return` statement or raise an exception using the `raise` statement. A synchronous function must return a result or throw an exception.

## Asynchronous handler {#async}

A handler can be an `async def` asynchronous function. In this case you can use the following statements:
* `return`: Returns the function response.
* `raise`: Reports an error to the runtime environment.
* `await`: Tracks the execution of asynchronous function invocations.

{% note info %}

The service only supports the `asyncio` library as a runtime environment for asynchronous functions.

{% endnote %}

For more information about development using `async/await`, see the [relevant documentation section](https://docs.python.org/3.7/library/asyncio.html).

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function outputs the request structure and invocation context to both the execution log and function response:

```python
import json


def handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps(
            {
                'event': event,
                'context': context,
            },
            default=vars,
        ),
    }
```

Function invocation example:

```
curl --data '{"hello": "world"}' -H 'Content-Type: application/json' https://functions.yandexcloud.net/d4eo2faf62**********?param=one
```

Result:

```bash
{
    "context": {
        "aws_request_id": "6e8356f9-489b-4c7b-8ba6-c8cd74f25455",
        "deadline_ms": 1657713543198,
        "function_name": "d4eo2faf62**********",
        "function_version": "d4e3vrugh3**********",
        "invoked_function_arn": "d4eo2faf62**********",
        "log_group_name": "ckgjmanjlh**********",
        "log_stream_name": "d4e3vrugh3**********",
        "memory_limit_in_mb": 128,
        "request_id": "6e8356f9-489b-4c7b-8ba6-c8cd74f25455",
        "token": {
            "access_token": "<IAM token>",
            "expires_in": 42299,
            "token_type": "Bearer"
        }
    },
    "event": {
        "body": "{\"hello\": \"world\"}",
        "headers": {
            "Accept": "*/*",
            "Content-Length": "18",
            "Content-Type": "application/json",
            "Host": "functions.yandexcloud.net",
            "User-Agent": "curl/7.64.1",
            "X-Forwarded-For": "109.252.148.209",
            "X-Real-Remote-Address": "[109.252.148.209]:2816",
            "X-Request-Id": "6e8356f9-489b-4c7b-8ba6-c8cd74f25455",
            "X-Trace-Id": "e9fe9b05-c1aa-4fb8-94d8-a514fd6f3ff7"
        },
        "httpMethod": "POST",
        "isBase64Encoded": false,
        "multiValueHeaders": {
            "Accept": [
                "*/*"
            ],
            "Content-Length": [
                "18"
            ],
            "Content-Type": [
                "application/json"
            ],
            "Host": [
                "functions.yandexcloud.net"
            ],
            "User-Agent": [
                "curl/7.64.1"
            ],
            "X-Forwarded-For": [
                "109.252.148.209"
            ],
            "X-Real-Remote-Address": [
                "[109.252.148.209]:2816"
            ],
            "X-Request-Id": [
                "6e8356f9-489b-4c7b-8ba6-c8cd74f25455"
            ],
            "X-Trace-Id": [
                "e9fe9b05-c1aa-4fb8-94d8-a514fd6f3ff7"
            ]
        },
        "multiValueParams": {},
        "multiValueQueryStringParameters": {
            "param": [
                "one"
            ]
        },
        "params": {},
        "pathParams": {},
        "queryStringParameters": {
            "param": "one"
        },
        "requestContext": {
            "httpMethod": "POST",
            "identity": {
                "sourceIp": "109.252.148.209",
                "userAgent": "curl/7.64.1"
            },
            "requestId": "6e8356f9-489b-4c7b-8ba6-c8cd74f25455",
            "requestTime": "13/Jul/2022:11:58:59 +0000",
            "requestTimeEpoch": 1657713539
        },
        "url": ""
    }
}
```

