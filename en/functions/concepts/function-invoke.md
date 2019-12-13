# Invoking a function

You can invoke a function:

- [Using an HTTP request](#http).
- [Using the CLI](#cli).

Each method has a specific data structure for function requests and responses.

## Invoking a function using HTTP {#http}

If a function is invoked for processing an HTTP request, it gets the request data in JSON format: the HTTP method name, request headers, request line arguments, and other parameters describing the HTTP request.

The result returned by the function should also be a JSON document. It should contain the HTTP response code, response headers, and response content. {{ sf-name }} automatically processes this JSON document and returns data in a standard HTTP response to the user.

You can run functions by specifying the `integration=raw` request line parameter. When invoked this way, a function cannot analyze or set HTTP headers. The contents of the request body, without any transformations, will be passed to the function as input data. The result will also be directly returned from the function as an HTTP response with a 200 status code.

### Request data structure {#request}

JSON query structure:

```
{
    "httpMethod": "<HTTP method name>",
    "headers": "<dictionary with HTTP header string values>",
    "multiValueHeaders": "<dictionary with lists of HTTP header values>",
    "queryStringParameters": "<dictionary of queryString parameters>",
    "multiValueQueryStringParameters": "<dictionary with lists of queryString parameter values>",
    "requestContext": "<dictionary with request context>",
    "body": "<request contents>",
    "isBase64Encoded": <true or false>
}
```

Detailed description of a request:

- `httpMethod`: The HTTP method name, such as DELETE, GET, HEAD, OPTIONS, PATCH, POST, or PUT.

- `headers`: A dictionary of strings with HTTP request headers and their values. If the same header is passed multiple times, the dictionary contains the last value passed.

- `multiValueHeaders`: A dictionary with HTTP request headers and lists of their values. It contains the same keys as the `headers` dictionary, but if any header is repeated multiple times, its list contains all the passed values for this header. If the header is passed only once, it's included in this dictionary and the list for it contains a single value.

- `queryStringParameters`: A dictionary with query parameters. If the same parameter is set multiple times, the dictionary contains the last specified value.

- `multiValueQueryStringParameters`: A dictionary with a list of all specified values for each query parameter. If the same parameter is set multiple times, the dictionary contains all the specified values.

- `requestContext`

    Contains data of the following structure:

    ```
    {
        "identity": "<a set of key:value pairs to authenticate the user>",
        "httpMethod": "<DELETE, GET, HEAD, OPTIONS, PATCH, POST or PUT>",
        "requestId": "<request ID, generated in the router>",
        "requestTime": "<request time in CLF format>",
        "requestTimeEpoch": "<request time in Unix format>"
    }
    ```

    Structure of the `identity` element:

    ```
    {
        "sourceIp": "<request source address>",
        "userAgent": "<contents of the original request User-Agent HTTP header>"
    }
    ```

- `body`: Request contents as a string with JSON or binary data in Base64 format.

- `isBase64Encoded`: If the parameter value is `true`, the `body` contains Base64-encoded data.

### Response data structure {#response}

Response JSON structure:

```
{
    "statusCode": <HTTP response code>,
    "headers": "<dictionary with HTTP header string values>",
    "multiValueHeaders": "<dictionary with lists of HTTP header values>",
    "body": "<response contents>",
    "isBase64Encoded": <true or false>
}
```

Detailed response description:

- `statusCode`: The HTTP status code, which the client uses to interpret the request results.

- `headers`: A dictionary of strings with HTTP response headers and their values.

- `multiValueHeaders`: A dictionary where you can specify one or more values as a list of HTTP response headers. If the same header is specified in both the `headers` and `multiValueHeaders` dictionaries, the contents of the `headers` dictionary is ignored.

- `body`: contents of the response as a string with JSON or binary data in Base64 format.

- `isBase64Encoded`: If the parameter value is `true`, the `body` contains Base64-encoded data.

### Message headers {#headers}

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

### Handling errors in user-defined function code {#error}

#### List of status codes {#http-state}

- 200 OK: Successful function execution.
- 400 BadRequest: Error in HTTP request parameters.
- 401 Unauthorized: Failed to authorize in the service that the {{ sf-name }} service depends on.
- 403 Forbidden: Can't execute the request due to restrictions on the client's access to the specified resource.
- 404 Not Found: Resource not found at the specified URL.
- 429 TooManyRequests: Exceeded maximum number of simultaneous requests.
- 500 Internal Server Error: Internal server error.
- 502 BadGateway: Incorrect function code or format of the returning JSON response.
- 503 Service Unavailable: The service that the {{ sf-name }} service depends on isn't available.
- 504 Gateway Timeout: Exceeded maximum function execution time before timeout.

If the error occurs in a user-defined function, the `X-Function-Error: true` response header is added.

#### Result in the event of an error in user code {#code-error}

If an unhandled error occurs in user code, {{ sf-name }} returns a 502 error and error details in the following JSON structure:

```
{
  "errorMessage": <error message>,
  "errorType": <error type>,
  "stackTrace": <list of invoked methods>
}
```

Error details:

- `errorMessage`

    The error description string.

- `errorType`

    The type of error or exception that depends on the programming language.

- `stackTrace`

    The list of strings describing the function execution stack at the time of the error.

The specific contents of these fields depend on the programming language and your function's runtime environment.

## Invoking a function using the YC CLI {#cli}

Function calls from the CLI are HTTP requests with the POST method and the `integration=raw` parameter. See the detailed description of this parameter [above](#http).

View the help for the function call command:

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
    yc serverless function invoke b09bhaokchn9pnbrlseb -d '{"queryStringParameters": {"parameter_name": "parameter_value"}}'
    ```

- `--data-file`: Data is read from a file.

    ```
    yc serverless function invoke b09bhaokchn9pnbrlseb --data-file <file path>
    ```

    Similar to the command with the `-d` argument with the value `@<file name>`: `yc serverless function invoke b09bhaokchn9pnbrlseb -d @<file path>`

- `--data-stdin`: Data is read from the input stream.

     ```
     echo '{"queryStringParameters": "name"}' | yc serverless function invoke b09bhaokchn9pnbrlseb --data-stdin
     ```

    Similar to the command with the `-d` argument with the value `@-`:

    ```
    echo '{"queryStringParameters": "name"}' | yc serverless function invoke b09bhaokchn9pnbrlseb -d @-`
    ```

