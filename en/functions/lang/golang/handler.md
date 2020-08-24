# Request handler

_A request handler_ is a method used to handle each function invocation. When creating a function version, you should specify the entry point that consists of the file name and request handler name (for example, `index.Handler`).

* To work properly, the handler must reside in the `main` package.
* To make the handler available outside the module (file), export it by typing the first letter of its name in uppercase.

{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}

When calling the handler, the runtime environment may pass the following arguments:

1. The invocation context (the `context` parameter).

    The context contains the necessary information about the function version. The structure of this object is described in [{#T}](context.md).
If the second argument (HTTP request body) is present, the invocation context must be the first in the list of arguments.

1. The HTTP request body (the `request` parameter).

    The body can be represented by an array of bytes, a string, a custom type, or a pointer to it. In the first two cases, the view reflects the HTTP request in its pure form: either as a byte array or as a string.
If the handler argument has a custom type and the request body is a JSON document, it's converted to an object of this type using the `json.Unmarshal` method.

All the above arguments are **optional**.
If the argument responsible for the request body is missing, any function input data is **ignored**.

The runtime environment returns the function execution result as a data set:

1. The response body (the `response` value).

    The body can be represented by an array of bytes, a string, a custom type, or a pointer to it, as well as an [empty interface](https://tour.golang.org/methods/14). In the first two cases, to get the correct response, you should run functions by specifying the `integration=raw` request string parameter. Learn more about invoking functions in the [relevant section](../../concepts/function-invoke.md#http). In other cases, the response value is converted to an object of the corresponding type using the `json.Unmarshal` method and returned as a JSON document.

1. An error (the `error` value).

    If an error occurs when calling a function, it's recommended to return an appropriate error message. If `error != nil`, the response body, if any, is ignored. **Important**: An error is a **mandatory** return value. In other words, if the response body is missing, an error must be returned as the only return value of the function, otherwise the error must be the last on the list of return values.

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function receives a request with two fields (a string message and a number) as an input, outputs the request structure and invocation context to the execution log, and returns a string entry of a JSON document containing information about the context and request:

```golang
package main

import (
  "context"
  "fmt"
  "encoding/json"
)

// The input JSON document is automatically converted to this type of object
type Request struct {
  Message string `json:"message"`
  Number  int    `json:"number"`
}

// The result is returned as an array of bytes
type Response struct {
	StatusCode int         `json:"statusCode"`
	Body       interface{} `json:"body"`
}

type ResponseBody struct {
  Context context.Context `json:"context"`
  Request interface{}     `json:"request"`
}

func Handler (ctx context.Context, request *Request) (*Response, error) {
  // The function logs contain the values of the invocation context and request body
  fmt.Println("context", ctx)
  fmt.Println("request", request)
  
  // The object containing the response body is converted to an array of bytes
  body, err := json.Marshal(&ResponseBody {
    Context: ctx,
    Request: request,
  })

  if err != nil {
    return nil, err
  }

  // The response body is a valid JSON document, the Body content is displayed
  return &Response{
    StatusCode: 200,
    // The byte array is returned as a string
    Body: string(body),
  }, nil
}
```

Example of input data:

```json
{
  "message": "Hello, world",
  "number": 24
}
```

The log will contain the following:

```
context {context.Background map[lambdaRuntimeFunctionName:b09ks558ute7l8agve8t lambdaRuntimeFunctionVersion:b09ebrsp6jbam10vrvs2 lambdaRuntimeLogGroupName:eolitpnj15jrgmsnqloh lambdaRuntimeLogStreamName:b09ebrsp6jbam10vrvs2 lambdaRuntimeMemoryLimit:512 lambdaRuntimeRequestID:58fc90cc-97b9-4c2b-95db-9dd0e961e8ae]}
request &{Hello 24}
```

JSON document returned:

```json
{ 
  "context": {
    "Context": 0
  },
  "request": {
    "message": "Hello, world",
    "number": 24
  }
}
```

### Output of the available response or an error

The function generates a random number from 0 to 100 and returns an error if this number is greater than or equal to 50, otherwise it returns "Lucky one!":

```golang
package main

import (
  "fmt"
  "math/rand"
)

// The response body is a string, hence to correctly output the
// response, run the function with the `integration=raw` parameter
func Handler() (string, error) {
  if (rand.Int31n(100) >= 50) {
    return "", fmt.Errorf("not so lucky")
  }
  
  return "Lucky one!", nil
}
```

JSON document returned:

If a random number is greater than or equal to 50:

```json
{
  "errorMessage":"not so lucky",
  "errorType":"UserCodeError"
}
```

Otherwise:

```
"Lucky one!"
```

