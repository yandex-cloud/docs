# Using the YcFunction interface to set a handler function in Java

You can set a handler function in Java by implementing the [YcFunction](https://github.com/yandex-cloud/java-sdk/blob/master/java-sdk-functions/src/main/java/yandex/cloud/sdk/functions/YcFunction.java) interface. To do this, add an [SDK](../sdk.md) to the [dependencies](../dependencies.md).

{% note warning %}

You should specify both values for the `YcFunction` type parameters: the first one being the input argument type and the second one the type of the return value. The `handle` method also has the second argument: the [invocation context](../context.md).

{% endnote %}

Example of a valid handler:
```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;

public class Handler implements YcFunction<Integer, String> {
  @Override
  public String handle(Integer i, Context c) {
    return String.valueOf(i);
  }
}
```

Examples of invalid handlers:
```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;
// YcFunction has only one parameter type specified
// Handler should not have any type parameters (see the handler requirements)
public class Handler<T> implements YcFunction<T, Integer> {
  @Override
  public Integer handle(T i, Context c) {
    return 2;
  }
}
```

```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;
// YcFunction doesn't have both parameter types specified
public class Handler implements YcFunction {
  @Override
  public Object apply(Object i, Context c) {
    return i;
  }
}
```

You can use any classes as input and return types.

{% note info %}

Fields of these classes may have any [access modifiers](https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html). If a field is non-public, writing `getter`/`setter` methods for it is optional.

{% endnote %}

## Example of function information output {#http-info}

The following function receives a number as an input, outputs the function data obtained from the invocation context to the execution log, and returns data on whether the received number is even.

{% note warning %}

To invoke the function, use the [{{ yandex-cloud }} CLI](../../../concepts/function-invoke.md) or an HTTP request with the `integration=raw` parameter.

{% endnote %}

The `Handler.java` file:
```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;

public class Handler implements YcFunction<Integer, Boolean> {

  private String format(String f, String s) {
    return String.format(f, s);
  }

  @Override
  public Boolean handle(Integer number, Context c) {
    System.out.println(format("Function name: %s", c.getFunctionName()));
    System.out.println(format("Function version: %s", c.getFunctionVersion()));
    // if no service account is selected, an empty line is printed
    System.out.println(format("Service account token: %s", c.getTokenJson()));
    return number % 2 == 0;
  }
}
```

Example of input data:

```
41
```

The log will contain the following:

```
Function name: <your function name>
Function version: <your function version ID>
Service account token: <token for your service account>
```

Returned string:

```
false
```
