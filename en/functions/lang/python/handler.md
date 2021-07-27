---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Request handler

_A request handler_ is a method used to handle each function invocation. When creating a function version, you should specify the entry point that consists of the file name and request handler name (for example, `main.handler`).

{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}

When invoking the handler, the runtime passes the following arguments:

1. The request body (the `event` parameter):
   * If the request body is a [JSON document](../../concepts/function-invoke.md#request), it's converted to a `dict` using the `json.loads` method.
   * If the function was called with the `integration=raw` query string parameter, the HTTP request body is passed to the function as is, unhandled.

1. [The invocation context](context.md) (the `context` parameter).

   The context contains the necessary information about the function version. The structure of this object is described in [{#T}](context.md).

## Handler types {#type}

A function can use both synchronous and asynchronous request handlers.

## Synchronous handler {#sync}

To have the execution result returned, use the `return` statement or raise an exception using the `raise` statement. A synchronous function must return a result or throw an exception.

## Asynchronous handler {#async}

A handler can be an `async def` asynchronous function. In this case you can use the following statements:

* `return`: Returns the function response.
* `raise`: Reports an error to the runtime environment.
* `await`: Tracks the execution of asynchronous function invocations.

{% note info %}

The service only supports the `asyncio` library as a runtime environment for asynchronous functions.

{% endnote %}

To learn more about programming using the `async/await` syntax, see the [relevant section of the documentation](https://docs.python.org/3.7/library/asyncio.html).

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function outputs the request structure and invocation context to both the execution log and function response:

```python
import json


def handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps({
            'event': event,
        }),
    }
```

