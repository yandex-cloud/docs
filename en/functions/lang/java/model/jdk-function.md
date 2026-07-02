# Using the Function interface to set a handler in Java

You can set a handler function in Java by implementing the [Function](https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html) interface.

{% note warning %}

You must specify both values for the `Function` type parameters: the first one being the input argument type and the second one, the return value type.

{% endnote %}

Example of a valid handler:
```java
import java.util.function.Function;

public class Handler implements Function<Integer, String> {
  @Override
  public String apply(Integer i) {
    return String.valueOf(i);
  }
}
```

Examples of invalid handlers:
```java
import java.util.function.Function;
// Function has only one parameter type specified.
// Handler should not have any parameter types (see handler requirements).
public class Handler<T> implements Function<T, Integer> {
  @Override
  public Integer apply(T i) {
    return 2;
  }
}
```

```java
import java.util.function.Function;
// Function has neither parameter type specified.
public class Handler implements Function {
  @Override
  public Object apply(Object i) {
    return i;
  }
}
```

You can use any classes as input and return types.

{% note info %}

Fields of these classes can have any [access modifiers](https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html). For non-public fields, defining the `getter` or `setter` method is optional.

{% endnote %}

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function receives a request with two fields (a string and a number) and returns a formatted string with the provided data.

{% note warning %}

To invoke the function, use the [{{ yandex-cloud }} CLI](../../../concepts/function-invoke.md) or an HTTP request with the `?integration=raw` parameter.

{% endnote %}

`Request.java`:
```java
public class Request {
  public String message;
  public int number;
}
```

`Handler.java`:
```java
import java.util.function.Function;

public class Handler implements Function<Request, String> {

  @Override
  public String apply(Request r) {
    // At this point, the r variable already stores the parsed request.
    return String.format("Message is %s, number is %d", r.message, r.number);
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

### Parsing an HTTP request {#parsing-http-req}

The function is invoked via an HTTP request with a username, logs the request method and body, and returns a greeting.

{% note warning %}

Do not use `?integration=raw` to invoke this function. If you do, the function will not get any data about the original request’s methods, headers, or parameters.

{% endnote %}

{% note info %}

This example uses the [`org.json`](https://github.com/stleary/JSON-java) third-party library for `JSON` parsing.

{% endnote %}

`Request.java`:
```java
public class Request {
  public String httpMethod;
  public String body;
}
```

`Response.java`:
```java
public class Response {
  public int statusCode;
  public String body;

  public Response(int statusCode, String body) {
    this.statusCode = statusCode;
    this.body = body;
  }
}
```

`Handler.java`:
```java
import java.util.function.Function;
import org.json.*;

public class Handler implements Function<Request, Response> {

  @Override
  public Response apply(Request r) {
    var method = r.httpMethod;
    var body = r.body;
    System.out.println(String.format("%s, %s", method, body));

    var jsonObject = new JSONObject(body);
    // Here, the name value is retrieved from the request body.
    // If you do not provide it, an error will be thrown.
    var name = jsonObject.getString("name");
    return new Response(200, String.format("Hello, %s", name));
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
