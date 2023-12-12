---
title: "R programming model in {{ sf-full-name }}"
description: "Setting a function handler means writing an R function with the event and context parameters."
---

# R programming model

Setting a function handler means writing an R function with the following parameters:
`event`: A [request](../../../concepts/function-invoke.md#request)
`context`: Information about the [invocation context](../context.md)

## Examples {#examples}

### Working with HTTP request arguments {#http-req}

The following function outputs the value of the `arg` request parameter:

```R
handler <- function(event, context) {
  return (list(statusCode = 200, body = event$queryStringParameters$arg))
}
```
