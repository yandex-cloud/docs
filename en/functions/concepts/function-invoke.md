# Invoking a function

You can invoke a function:

- [Using an HTTP request](#http).
- [Using the CLI](#cli).

Each method has a specific data structure for function requests and responses.

## Invoking a function using HTTP {#http}

If a function is invoked for processing an HTTP request, it gets the request data in JSON format in the first argument: the HTTP method name, headers, arguments, and other request parameters.

The result returned by the function should also be a JSON document. It should contain the HTTP response code, response headers, and response content. {{ sf-name }} automatically processes this JSON document and returns data in a standard HTTP response to the user.

{% note info %}

You can run functions by specifying the `integration=raw` request string parameter. When invoked this way, a function can't parse or set HTTP headers:

* The contents of the HTTP request body are passed as the first argument (without converting to a JSON structure).
* The contents of the HTTP response body is identical to the function response (without converting or checking the structure) and the HTTP response status is 200.

{% endnote %}

### Request structure {#request}

JSON structure of a request:

```
{
    "httpMethod": "<HTTP method name>",
    "headers": <dictionary with HTTP header string values>,
    "multiValueHeaders": <dictionary with lists of HTTP header values>,
    "queryStringParameters": <dictionary of queryString parameters>,
    "multiValueQueryStringParameters": <dictionary with lists of queryString parameter values>,
    "requestContext": <dictionary with request context>,
    "body": "<request body>",
    "isBase64Encoded": <true or false>
}
```

Detailed description of a request:

- `httpMethod`: The HTTP method name, such as DELETE, GET, HEAD, OPTIONS, PATCH, POST, or PUT.

- `headers`: A dictionary of strings with HTTP request headers and their values. If the same header is passed multiple times, the dictionary contains the last value passed.

- `multiValueHeaders`: A dictionary with HTTP request headers and lists of their values. It contains the same keys as the `headers` dictionary, but if any header is repeated multiple times, its list contains all the passed values for this header. If the header is passed only once, it's included in this dictionary and the list for it will contain a single value.

- `queryStringParameters`: A dictionary with query parameters. If the same parameter is set multiple times, the dictionary contains the last specified value.

- `multiValueQueryStringParameters`: A dictionary with a list of all specified values for each query parameter. If the same parameter is set multiple times, the dictionary contains all the specified values.

- `requestContext` contains the following structure:

    ```
    {
        "identity": "<a set of key:value pairs to authenticate the user>",
        "httpMethod": "<DELETE, GET, HEAD, OPTIONS, PATCH, POST или PUT>",
        "requestId": "<request ID generated in the router>",
        "requestTime": "<request time in CLF format>",
        "requestTimeEpoch": "<request time in Unix format>"
    }
    ```

    Structure of the `identity` element:

    ```
    {
        "sourceIp": "<source IP address of request>",
        "userAgent": "<contents of the original request User-Agent HTTP header>"
    }
    ```

- `body`: The request body in string format. Data can be Base64-encoded (in this case, {{ sf-name }} sets `isBase64Encoded: true`).

    {% note info %}

    If the function is called with the `Content-Type: application/json` header, the contents of `body` stays in the original format (parameter value `isBase64Encoded: false`).

    {% endnote %}

- `isBase64Encoded`: If `body` contains Base64-encoded data, then {{ sf-name }} sets the parameter to `true`.

#### Function debugging {#example}

To debug parameter processing, use a function that returns the JSON structure of the request. An example of such function is given below.

```js
module.exports.handler = async (event) => {
    return { 
        body: JSON.stringify(event)
    };
};
```

For example, for the request:

```
curl -XPOST -d "hello, world!" "https://functions.yandexcloud.net/<function ID>?a=1&a=2&b=1"
```

The result looks like this:

```
{
  "httpMethod": "POST",
  "headers": {
    "Accept": "*/*",
    "Content-Length": "13",
    "Content-Type": "application/x-www-form-urlencoded",
    "User-Agent": "curl/7.58.0",
    "X-Real-Remote-Address": "[88.99.0.24]:37310",
    "X-Request-Id": "cd0d12cd-c5f1-4348-9dff-c50a78f1eb79",
    "X-Trace-Id": "92c5ad34-54f7-41df-a368-d4361bf376eb"
  },
  "path": "",
  "multiValueHeaders": {
    "Accept": [ "*/*" ],
    "Content-Length": [ "13" ],
    "Content-Type": [ "application/x-www-form-urlencoded" ],
    "User-Agent": [ "curl/7.58.0" ],
    "X-Real-Remote-Address": [ "[88.99.0.24]:37310" ],
    "X-Request-Id": [ "cd0d12cd-c5f1-4348-9dff-c50a78f1eb79" ],
    "X-Trace-Id": [ "92c5ad34-54f7-41df-a368-d4361bf376eb" ]
  },
  "queryStringParameters": {
    "a": "2",
    "b": "1"
  },
  "multiValueQueryStringParameters": {
    "a": [ "1", "2" ],
    "b": [ "1" ]
  },
  "requestContext": {
    "identity": {
      "sourceIp": "88.99.0.24",
      "userAgent": "curl/7.58.0"
    },
    "httpMethod": "POST",
    "requestId": "cd0d12cd-c5f1-4348-9dff-c50a78f1eb79",
    "requestTime": "26/Dec/2019:14:22:07 +0000",
    "requestTimeEpoch": 1577370127
  },
  "body": "aGVsbG8sIHdvcmxkIQ==",
  "isBase64Encoded": true
}
```

### Service data {#service-data}

Optionally, the function can accept the second argument with the following structure:

```
{
  "requestId": "<request ID>",
  "functionName": "<function ID>",
  "functionVersion": "<function version ID>",
  "memoryLimitInMB": "<amount of memory available to function version, MB>",
  "token": "<IAM token, optional>",
}
```

- `requestId`: The ID of the function call, generated when the function is accessed and displayed in the function call log.
- `functionName`: The function ID.
- `functionVersion`: The ID of the function version.
- `memoryLimitInMB`: The amount of memory specified for the function version, MB.
- `token`: The [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account specified for the function version. The current value is generated automatically. It's used to access the [Yandex Cloud API](../../api-design-guide/). This field is present only if the correct service account is specified for the function version.

Example of using service data in a function:

```js
module.exports.handler = async (event, context) => {
    const iamToken = context.token;
    ...
    return { 
        body: ...
    };
};
```

### Response structure {#response}

{{ sf-name }} interprets the result of the function in order to fill in the HTTP response contents, headers, and status code. For this to work, the function must return a response in the following structure:

```
{
    "statusCode": <HTTP response code>
    "headers": <dictionary with HTTP header string values>,
    "multiValueHeaders": <dictionary with lists of HTTP header values>,
    "body": "<response contents>",
    "isBase64Encoded": <true or false>
}
```

Detailed description of a response:

- `statusCode`: The HTTP status code, which the client uses to interpret the request results.
- `headers`: A dictionary of strings with HTTP response headers and their values.
- `multiValueHeaders`: A dictionary listing one or more HTTP response headers. If the same header is specified in both the `headers` and `multiValueHeaders` dictionaries, the contents of the `headers` dictionary is ignored.
- `body`: The response body in string format. To work with binary data, the contents can be Base64-encoded. In this case, set `isBase64Encoded: true`.
- `isBase64Encoded`: If `body` is Base64-encoded, set the parameter to `true`.

### Handling errors in user-defined function code {#error}

If an unhandled error occurs in user code, {{ sf-name }} returns a 502 error and error details in the following JSON structure:

```
{
  "errorMessage": "<error message>",
  "errorType": "<error type>",
  "stackTrace": <list of invoked methods, optional>
}
```

Error details:

- `errorMessage`: A string with an error description.
- `errorType`: A programming language-dependent type of error or exception.
- `stackTrace`: The function execution stack at the time of the error.

The specific contents of these fields depend on the programming language and your function's runtime environment.

#### Error in the event the response has an invalid JSON structure {#uncorrect-json}

If the response structure of your function doesn't match the description given in [Response data structure](#response), {{ sf-name }} returns the result with a 502 error code and the following response:

```
{
  "errorMessage": "Malformed serverless function response: not a valid json",
  "errorType": "ProxyIntegrationError",
  "payload": "<original contents of the function response>"
}
```

### Possible response codes {{ sf-name }} {#http-state}

If the error occurs in a user-defined function, the `X-Function-Error: true` header is added to the response.

{{ sf-name }} can return results with the following HTTP codes:

- `200 OK`: Successful function execution.
- `400 BadRequest`: Error in HTTP request parameters (TODO: examples).
- `403 Forbidden`: Can't execute the request due to restrictions on client access to the function.
- `404 Not Found`: The function is not found at the specified URL.
- `413 Payload Too Large`: The [limit](../concepts/limits.md#limits) for the request JSON structure is exceeded by more than 3.5 MB.
- `429 TooManyRequests`: The function call intensity is too high:
    - The [quota](../concepts/limits.md#quotas) on the number of requests executed is exceeded.
    - Can't execute this request because all executors are already overloaded by the existing requests to this function.
- `500 Internal Server Error`: Internal server error.
- `502 BadGateway`: Incorrect function code or format of the returning JSON response.
- `503 Service Unavailable`: {{ sf-name }} is unavailable.
- `504 Gateway Timeout`: Exceeded maximum function execution time before timeout.

### Filtering of message headers {#headers}

Your function receives and passes the contents of HTTP headers as JSON fields (see the description [above](#http)). Some request and response headers are removed or renamed as described below.

{% list tabs %}

- Request headers

    Removed from a request:
    - "Expect"
    - "Te"
    - "Trailer"
    - "Upgrade"
    - "Proxy-Authenticate"
    - "Authorization"
    - "Connection"
    - "Content-Md5"
    - "Max-Forwards"
    - "Server"
    - "Transfer-Encoding"
    - "Www-Authenticate"
    - "Cookie"

- Response headers

    - Removed from a response:
        - "Host"
        - "Authorization"
        - "User-Agent"
        - "Connection"
        - "Max-Forwards"
        - "Cookie"

    - Cause an error if present in a response:
        - "Proxy-Authenticate"
        - "Transfer-Encoding"
        - "Via"
        - "Www-Authenticate"

    - Overwritten by adding the `X-Yf-Remapped-` prefix:
        - "Content-Md5"
        - "Date"
        - "Server"

{% endlist %}

## Invoking a function using the YC CLI {#cli}

Function invocations from the CLI are HTTP requests using the POST method and the `integration=raw` parameter (without converting the request to a JSON structure or checking the response).

View the help for the function invocation command:

```
yc serverless function invoke --help
Invoke the specified function

Usage:
  yc serverless function invoke <FUNCTION-NAME>|<FUNCTION-ID> [Flags...] [Global Flags...]

Flags:
      --id string          Function id.
      --name string        Function name.
      --tag string         Tag. Default $latest.
  -d, --data string        Data to be sent
      --data-file string   Data (file location) to be sent
      --data-stdin         Await stdin for data to be sent
```

Detailed description of how to transfer data using different flags and arguments:

- If a flag or argument is omitted, an empty string is passed.

- `-d, --data`: Data is passed as an argument.

    ```
    yc serverless function invoke <function ID> -d '{"queryStringParameters": {"parameter_name": "parameter_value"}}'
    ```

- `--data-file`: Data is read from a file.

    ```
    yc serverless function invoke <function ID> --data-file <file path>
    ```

    Similar to the command with the `-d` argument with the `@<file name>` value: `yc serverless function invoke b09bhaokchn9pnbrlseb -d @<file path>`

- `--data-stdin`: Data is read from the input stream.

     ```
     echo '{"queryStringParameters": {"parameter_name": "parameter_value"}}' | yc serverless function invoke <function ID> --data-stdin
     ```

    Similar to a command with the `-d` argument set to `@-`:

    ```
    echo '{"queryStringParameters": {"parameter_name": "parameter_value"}}' | yc serverless function invoke <function ID> -d @-`.
    ```

