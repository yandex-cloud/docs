# Using the Function interface to set a handler function in Java

You can set a handler function in Java by implementing the [Function](https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html) interface.

{% note warning %}

You should specify both values for the `Function` type parameters, the first one being the input argument type and the second one the type of the return value.

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
// the Function has only one parameter type specified
// the Handler should not have any type parameters (see the handler requirements)
public class Handler<T> implements Function<T, Integer> {
  @Override
  public Integer apply(T i) {
    return 2;
  }
}
```

```java
import java.util.function.Function;
// the Function doesn't have both parameter types specified
public class Handler implements Function {
  @Override
  public Object apply(Object i) {
    return i;
  }
}
```

You can use any classes as input and return types.

{% note info %}

Fields of these classes may have any [access modifiers](https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html). If a field is non-public, writing `getter`/`setter` methods for it is optional.

{% endnote %}

## Examples {#examples}

### HTTP request structure output {#http-req}

The following function receives a request with two fields (a string and a number) as an input and returns a formatted string with the data received.

{% note warning %}

To invoke the function, use the [{{ yandex-cloud }} CLI](../../../concepts/function-invoke.md) or an HTTP request with the `integration=raw` parameter.

{% endnote %}

The `Request.java` file:
```java
public class Request {
  public String message;
  public int number;
}
```

The `Handler.java` file:
```java
import java.util.function.Function;

public class Handler implements Function<Request, String> {

  @Override
  public String apply(Request r) {
    // at this stage, the r variable already stores the parsed query
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

The function is invoked using an HTTP request with the username, logs the request method and body, and returns a greeting.

{% note warning %}

Do not use the `integration=raw` parameter to invoke this function. If you do, the function won't get any data about the original request's methods, headers, or parameters.

{% endnote %}

{% note info %}

In this example, to interpret `JSON`, we use a third-party library named [`org.json`](https://github.com/stleary/JSON-java).

{% endnote %}

The Request.java file:
```java
public class Request {
  public String httpMethod;
  public String body;
}
```

The Response.java file:
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

The Handler.java file:
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
    // here the "name" parameter is obtained from the request body
    // if you don't pass it, an error is thrown
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
