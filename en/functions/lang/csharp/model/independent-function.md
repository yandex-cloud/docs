# Using the Function interface to set a handler function in C#

You can set a handler function in C# without [SDK](https://github.com/yandex-cloud/dotnet-sdk) class inheritance.

{% note warning %}

The handler method must be public, be named `FunctionHandler`, and have one input parameter.

{% endnote %}

Example of a valid handler:

```C#
public class Handler {
  public String FunctionHandler(int i) {
    return i.ToString();
  }
}
```

Example of an invalid handler:

```C#
// Handler should not have any type parameters (see the [handler requirements](index.md))
public class Handler<T> {
  public int FunctionHandler(T i) {
    return 2;
  }
}
```

You can use any classes as input and return types.

{% note info %}

Fields of these classes may have any [access modifiers](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers). If a field is non-public, it requires a public `getter` method. Otherwise, the field won't be included in the response.

{% endnote %}

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function receives a request with two fields (a string and a number) as an input and returns a formatted string with the data received.

{% note warning %}

To invoke the function, use the [YC CLI](../../../concepts/function-invoke.md) or an HTTP request with the `integration=raw` parameter.

{% endnote %}

The Request.cs file:

```C#
public class Request {
  public String message { get; set; }
  public int number { get; set; }
}
```

The Handler.cs file:

```C#
public class Handler {
  public String FunctionHandler(Request r) {
    // at this stage, the r variable already stores the parsed query
    return $"Message is {r.message}, number is {r.number}";
  }
}
```

Example of input data:

```json
{
  "message": "Hello",
  "number": 24
}
```

Returned string:

```
Message is Hello, number is 24
```

### Parsing an HTTP request

The function is invoked using an HTTP request with the username, logs the request method and body, and returns a greeting.

{% note warning %}

Don't use the `integration=raw` parameter to invoke this function. If you do, the function won't get any data about the original request's methods, headers, or parameters.

{% endnote %}

The Request.cs file:

```C#
public class Request {
  public String httpMethod { get; set; }
  public String body { get; set; }
}
```

The Response.cs file:

```C#
public class Response {
  public int statusCode { get; set; }
  public String body { get; set; }

  public Response(int statusCode, String body) {
    this.statusCode = statusCode;
    this.body = body;
  }
}
```

The Handler.cs file:

```C#
using System.Text.Json;

public class Handler {

  public Response FunctionHandler(Request r) {
    var method = r.httpMethod;
    var body = r.body;
    Console.WriteLine($"{method}, {body}");

    using var jsonDoc = JsonDocument.Parse(body);
    var root = jsonDoc.RootElement;

    // here the "name" parameter is obtained from the request body
    // if you don't pass it, an error is thrown
    var name = root.GetProperty("name").GetString(); 
    return new Response(200, $"Hello, {name}");
  }
}
```

Example of input data (the POST method):

```json
{
  "name": "Anonymous"
}
```

The log will contain the following:

```
POST, { "name": "Anonymous" }
```

Response returned:

```
Hello, Anonymous
```
