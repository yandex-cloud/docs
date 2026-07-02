---
title: R programming model in {{ sf-full-name }}
description: Setting a handler requires defining an R function with the event and context parameters.
---

# R programming model

Setting a handler requires defining an R function with the following parameters:
* `event`: [Request](../../../concepts/function-invoke.md#request).
* `context`: [Invocation context](../context.md) information.

## Examples {#examples}

### Working with HTTP request arguments {#http-req}

The following function returns the value of the `arg` request parameter:

```R
handler <- function(event, context) {
  return (list(statusCode = 200, body = event$queryStringParameters$arg))
}
```
