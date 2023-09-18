# Go function call handler

A _call handler_ is a method used to handle each Go function call. When creating a function version, you should specify the entry point that consists of the file name and request handler name (for example, `index.Handler`).

* To work properly, the handler must reside in the `main` package.
* To make the handler available outside the module (file), export it by typing the first letter of its name in uppercase.

{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}

## Cloud Functions signature {#functions}

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

   The body can be represented by an array of bytes, a string, a custom type, or a pointer to it, as well as an [empty interface](https://go.dev/tour/methods/14). In the first two cases, to get the correct response, you should run functions by specifying the `integration=raw` request string parameter. Learn more about invoking functions in the [relevant section](../../concepts/function-invoke.md#http). In other cases, the response value is converted to an object of the corresponding type using the `json.Unmarshal` method and returned as a JSON document.

1. An error (the `error` value).

   If an error occurs when calling a function, it's recommended to return an appropriate error message. If `error != nil`, the response body, if any, is ignored. **Important**: An error is a **mandatory** return value. In other words, if the response body is missing, an error must be returned as the only return value of the function, otherwise the error must be the last on the list of return values.

## Standard Go signature {#go}

{{ sf-name }} supports the following handlers:
* Functions with the `func (http.ResponseWriter, *http.Request)` signature.
* Objects that satisfy the [http.Handler](https://pkg.go.dev/net/http#Handler) interface.

The function can take values passed in the request from the [http.Request](https://pkg.go.dev/net/http#Request) structure and return a response via the [http.ResponseWriter](https://pkg.go.dev/net/http#ResponseWriter) interface.

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

The following function receives a request with two fields (a string and a number) as an input, outputs the request structure and invocation context to the execution log, and returns a string entry of a JSON document containing information about the context and request.

{% note warning %}

To invoke the function, use the [{{ yandex-cloud }} CLI](../../concepts/function-invoke.md) or an HTTP request with the `integration=raw` parameter.

{% endnote %}

```golang
package main

import (
  "context"
  "encoding/json"
  "fmt"
)

// The input JSON document is automatically converted to this type of object
type Request struct {
  Message string `json:"message"`
  Number  int    `json:"number"`
}

type ResponseBody struct {
  Context context.Context `json:"context"`
  Request interface{}     `json:"request"`
}

func Handler(ctx context.Context, request *Request) ([]byte, error) {
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

  // The response body must be returned as an array of bytes
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
context {context.Background map[lambdaRuntimeFunctionName:b09ks558ute7l8agve8t lambdaRuntimeFunctionVersion:b09ebrsp6jbam10vrvs2 lambdaRuntimeLogGroupName:eolitpnj15jrgmsnqloh lambdaRuntimeLogStreamName:b09ebrsp6jbam10vrvs2 lambdaRuntimeMemoryLimit:512 lambdaRuntimeRequestID:58fc90cc-97b9-4c2b-95db-9dd0e961e8ae]}
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

### Parsing an HTTP request

The function is invoked using an HTTP request with the username, logs the request method and body, and returns a greeting.

{% note warning %}

Don't use the `integration=raw` parameter to invoke this function. If you do, the function won't get any data about the original request's methods, headers, or parameters.

{% endnote %}

```golang
package main

import (
  "context"
  "encoding/json"
  "fmt"
)

// The request structure (see the paragraph following this example).
// The other fields aren't used anywhere in this example, so you can do without them
type RequestBody struct {
  HttpMethod string `json:"httpMethod"`
  Body       []byte `json:"body"`
}

// We convert the body field of the RequestBody object
type Request struct {
  Name string `json:"name"`
}

type Response struct {
  StatusCode int         `json:"statusCode"`
  Body       interface{} `json:"body"`
}

func Greet(ctx context.Context, request []byte) (*Response, error) {
  requestBody := &RequestBody{}
  // The array of bytes with the request body is converted to the corresponding object
  err := json.Unmarshal(request, &requestBody)
  if err != nil {
    return nil, fmt.Errorf("an error has occurred when parsing request: %v", err)
  }

  // The log will show the name of the HTTP method used to make the request and the request body
  fmt.Println(requestBody.HttpMethod, string(requestBody.Body))

  req := &Request{}
  // The request's body field is converted to a Request object to get the passed name
  err = json.Unmarshal(requestBody.Body, &req)
  if err != nil {
    return nil, fmt.Errorf("an error has occurred when parsing body: %v", err)
  }

  name := req.Name
  // The response body must be returned as a structure that is automatically converted to a JSON document
  // that will be displayed on the screen
  return &Response{
    StatusCode: 200,
    Body:       fmt.Sprintf("Hello, %s", name),
  }, nil
}
```

For details about the request body structure (`type RequestBody struct`), see [{#T}](../../concepts/function-invoke.md#request).

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



### Parsing an {{ api-gw-name }} HTTP request

The function is called by {{ api-gw-full-name }} with a service account, logs the request method and body, and returns a greeting.

The function decodes the body of an incoming request using `json.Unmarshal()`.

```golang
package main

import (
	"context"
	"encoding/json"
	"fmt"
)

// API Gateway v1 request structure
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

	Body            []byte `json:"body"`
	IsBase64Encoded bool   `json:"isBase64Encoded,omitempty"`

	RequestContext interface{} `json:"requestContext"`
}

// API Gateway v1 response structure
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

	// The request's event.Body field is converted to a Request object to get the passed name
	if err := json.Unmarshal(event.Body, &req); err != nil {
		return nil, fmt.Errorf("an error has occurred when parsing body: %v", err)
	}

	// The log will show the name of the HTTP method that was used to make the request and the path
	fmt.Println(event.HTTPMethod, event.Path)

	// The response body.
	return &APIGatewayResponse{
		StatusCode: 200,
		Body:       fmt.Sprintf("Hello, %s", req.Name),
	}, nil
}
```

{% note warning %}

Access the function via the API gateway.

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



