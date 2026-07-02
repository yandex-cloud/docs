---
title: Request handler for a function in Go
description: In this article, you will learn about the request handler for functions in Go.
---

# Request handler for a function in Go

A _request handler_ is a method used to process each Go function call. When creating a function version, you must specify the entry point that consists of the file name and the request handler name, e.g., `index.Handler`. The name of the handler file must not contain any `.` before the extension, e.g., `.handler.go`.

* To work properly, the handler must reside in the `main` package.
* To enable external access to the handler (file), export it by capitalizing the first letter of its name.

{% note info %}

At any given time, one function instance cannot handle more calls than set in the [concurrency](../../concepts/function.md#concurrency) parameter. This allows you to use global variables without the need to ensure data integrity control.

{% endnote %}

## Cloud Functions signature {#functions}

When calling the handler, the runtime may provide the following arguments:
1. Invocation context (the `context` parameter). 

    The context provides all required information about the function version. The structure of this object is described in [{#T}](context.md).
    If there is a second argument (the HTTP request body), the invocation context must be the first in the list of arguments.
1. HTTP request body (the `request` parameter). 

    The body can be a byte array, a string, a custom type, or a pointer to a custom type. In the first two cases, the data is a raw HTTP request, either as a byte array or a string.
    If the handler argument is a custom type and the request body is a JSON document, the body will be converted into an object of that type using `json.Unmarshal`.

All the above arguments are **optional**.
If the request body argument is missing, any function input data is **ignored**.

The runtime returns the function execution result as a data set:
1. Response body (the `response` value).

    The body can be a byte array, a string, a custom type, a pointer to a custom type, or an [empty interface](https://go.dev/tour/methods/14). In the first two cases, call the function with the `?integration=raw` query parameter to get a valid response. Learn more about invoking functions [here](../../concepts/function-invoke.md#http). In other cases, the return value is converted to an object of the relevant type using `json.Unmarshal` and returned as a JSON document.

1. Error (the `error` value).

    To report an error in function execution, we recommend returning an appropriate error. If `error != nil`, the response body, if any, is ignored. **Note** that an error is a **required** return value. In other words, if the response body is missing, the function must return an error as the only return value; otherwise, the error must be the last return value.
    
## Standard Go signature {#go}

{{ sf-name }} supports the following handlers:
* Functions with the `func (http.ResponseWriter, *http.Request)` signature.
* Objects satisfying the [http.Handler](https://pkg.go.dev/net/http#Handler) interface.

A function can take values from the [http.Request](https://pkg.go.dev/net/http#Request) struct and send the response via the [http.ResponseWriter](https://pkg.go.dev/net/http#ResponseWriter) interface.

{{ sf-name }} does not support paths in requests. For [http.ServeMux](https://pkg.go.dev/net/http#ServeMux) to work properly, [call the function via the API gateway](../../../api-gateway/quickstart/index.md#function).

Function example:

```golang
package main

import (
  "fmt"
  "io"
  "net/http"
)

func Handler(rw http.ResponseWriter, req *http.Request) {
  rw.Header().Set("X-Custom-Header", "Test")
  rw.WriteHeader(200)
  name := req.URL.Query().Get("name")
  io.WriteString(rw, fmt.Sprintf("Hello, %s!", name))
}
```

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function accepts a request with two fields (a string and a number), outputs the request structure and invocation context to the execution log, and returns a JSON string with information about the context and the request.

{% note warning %}

To invoke the function, use the [{{ yandex-cloud }} CLI](../../concepts/function-invoke.md) or an HTTP request with the `?integration=raw` parameter.

{% endnote %}

```golang
package main

import (
  "context"
  "encoding/json"
  "fmt"
)

// The input JSON document will be automatically converted into an object of this type.
type Request struct {
  Message string `json:"message"`
  Number  int    `json:"number"`
}

type ResponseBody struct {
  Context context.Context `json:"context"`
  Request interface{}     `json:"request"`
}

func Handler(ctx context.Context, request *Request) ([]byte, error) {
  // The function logs will include the values of the invocation context and the request body.
  fmt.Println("context", ctx)
  fmt.Println("request", request)
  
  // The object containing the response body will be converted into a byte array.
  body, err := json.Marshal(&ResponseBody {
    Context: ctx,
    Request: request,
  })

  if err != nil {
    return nil, err
  }

  // The response body must be returned as a byte array.
  return body, nil
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
context {context.Background map[lambdaRuntimeFunctionName:b09ks558ute7******** lambdaRuntimeFunctionVersion:b09ebrsp6jba******** lambdaRuntimeLogGroupName:eolitpnj15jr******** lambdaRuntimeLogStreamName:b09ebrsp6jba******** lambdaRuntimeMemoryLimit:512 lambdaRuntimeRequestID:58fc90cc-97b9-4c2b-95db-9dd0********]}
request &{Hello, world 24}
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

### Returning a prepared response or an error

The function generates a random number between 0 and 100. If this number is greater than or equal to 50, the function returns an error; otherwise it returns "Lucky one!":

```golang
package main

import (
  "fmt"
  "math/rand"
)

// The response body is a string, so to correctly output
// the response, run the function with the `?integration=raw` query parameter.
func Handler() (string, error) {
  if (rand.Int31n(100) >= 50) {
    return "", fmt.Errorf("not so lucky")
  }
  
  return "Lucky one!", nil
}
```

JSON document returned:

If the random number is greater than or equal to 50:

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

### Parsing an HTTP request

The function is invoked via an HTTP request with a username, logs the request method and body, and returns a greeting.

{% note warning %}

Do not use `?integration=raw` to invoke this function. If you do, the function will not get any data about the original request’s methods, headers, or parameters.

{% endnote %}

```golang
package main

import (
  "context"
  "encoding/json"
  "fmt"
)

// Request body structure (see the paragraph after this example).
// This example does not use the other fields, so you can skip them.
type RequestBody struct {
  HttpMethod string `json:"httpMethod"`
  Body       []byte `json:"body"`
}

// Converting the body field of the RequestBody object
type Request struct {
  Name string `json:"name"`
}

type Response struct {
  StatusCode int         `json:"statusCode"`
  Body       interface{} `json:"body"`
}

func Greet(ctx context.Context, request []byte) (*Response, error) {
  requestBody := &RequestBody{}
  // The function converts the byte array that contains the request body into the relevant object.
  err := json.Unmarshal(request, &requestBody)
  if err != nil {
    return nil, fmt.Errorf("an error has occurred when parsing request: %v", err)
  }

  // The log will show the name of the HTTP method used to make the request and the request body.
  fmt.Println(requestBody.HttpMethod, string(requestBody.Body))

  req := &Request{}
  // The request's body field is converted into a Request type object to get the provided name.
  err = json.Unmarshal(requestBody.Body, &req)
  if err != nil {
    return nil, fmt.Errorf("an error has occurred when parsing body: %v", err)
  }

  name := req.Name
  // The response body must be returned as a structure that is automatically converted to a JSON document
  // that appears on the screen.
  return &Response{
    StatusCode: 200,
    Body:       fmt.Sprintf("Hello, %s", name),
  }, nil
}
```

For more information about the request body structure (`type RequestBody struct`), see [{#T}](../../concepts/function-invoke.md#request).

Example of input data (the POST method):

```json
{
  "name": "Anonymous"
}
```

The log will contain the following:
```
POST { "name": "Anonymous" }
```

Response returned:
```
Hello, Anonymous
```

### Parsing an HTTP request via {{ api-gw-name }}

The function is invoked by {{ api-gw-full-name }} with a service account, logs the request method and body, and returns a greeting.

The function decodes the body of an incoming request using `json.Unmarshal()`.

```golang
package main

import (
	"context"
	"encoding/json"
	"fmt"
)

// API Gateway v1 request body
type APIGatewayRequest struct {
	OperationID string `json:"operationId"`
	Resource    string `json:"resource"`

	HTTPMethod string `json:"httpMethod"`

	Path           string            `json:"path"`
	PathParameters map[string]string `json:"pathParameters"`

	Headers           map[string]string   `json:"headers"`
	MultiValueHeaders map[string][]string `json:"multiValueHeaders"`

	QueryStringParameters           map[string]string   `json:"queryStringParameters"`
	MultiValueQueryStringParameters map[string][]string `json:"multiValueQueryStringParameters"`

	Parameters           map[string]string   `json:"parameters"`
	MultiValueParameters map[string][]string `json:"multiValueParameters"`

	Body            string `json:"body"`
	IsBase64Encoded bool   `json:"isBase64Encoded,omitempty"`

	RequestContext interface{} `json:"requestContext"`
}

// API Gateway v1 response body
type APIGatewayResponse struct {
	StatusCode        int                 `json:"statusCode"`
	Headers           map[string]string   `json:"headers"`
	MultiValueHeaders map[string][]string `json:"multiValueHeaders"`
	Body              string              `json:"body"`
	IsBase64Encoded   bool                `json:"isBase64Encoded,omitempty"`
}

type Request struct {
	Name string `json:"name"`
}

func Greet(ctx context.Context, event *APIGatewayRequest) (*APIGatewayResponse, error) {
	req := &Request{}

	// The request’s event.Body field is converted into a Request type object to get the provided name.
	if err := json.Unmarshal([]byte(event.Body), &req); err != nil {
		return nil, fmt.Errorf("an error has occurred when parsing body: %v", err)
	}

	// The log will show the name of the HTTP method used to make the request as well as the path.
	fmt.Println(event.HTTPMethod, event.Path)

	// Response body.
	return &APIGatewayResponse{
		StatusCode: 200,
		Body:       fmt.Sprintf("Hello, %s", req.Name),
	}, nil
}
```

{% note warning %}

Make sure to access the function via the API gateway.

{% endnote %}

Example of input data (the POST method):

```json
{
  "name": "Anonymous"
}
```

The log will contain the following:
```
POST { "name": "Anonymous" }
```

Response returned:
```
Hello, Anonymous
```