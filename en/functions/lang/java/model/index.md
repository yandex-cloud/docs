# Java programming model


{{ sf-name }} provides four models for programming in Java: using the [Function](jdk-function.md) and [YcFunction](yc-function.md) interfaces, the [HttpServlet](servlet-api.md) class, and the [Spring Boot](spring-boot.md) framework. The first three methods of setting a function handler involve writing their own implementations of these interfaces or classes, and the last one involves loading an application in its original form without any changes.

The difference between the [Function](jdk-function.md) and [YcFunction](yc-function.md) models is in the [invocation context](../context.md) that is either available or not. For example, if you need to work with {{ yandex-cloud }} services using the [SDK](../sdk.md), we recommend choosing [YcFunction](yc-function.md). Meanwhile, the model based on the [HttpServlet](servlet-api.md) class allows you to get full control over the return value and `HTTP` method used to call the function. Just as `YcFunction`, it also provides access to the [invocation context](../context.md).


For the [Function](jdk-function.md) and [YcFunction](yc-function.md) models, there are two separate types: `byte[]` and `String`. Using them is different from using other types. If you use them as the handler function argument type, the runtime environment will not convert an incoming request to a `JSON` interpretation for these types and will deliver it directly to the user handler function, unless you use the [?integration=raw](../../../concepts/function-invoke.md#http) parameter.

{% note info %}

The library used for serialization and deserialization of `JSON` is [jsoniter](http://jsoniter.com/java-features.html).

{% endnote %}

## Handler requirements {#requirements}

Regardless of the selected model, a project is uploaded as a source code, a JAR archive, or a Maven project. In addition, the following requirements apply to a class that contains a handler function:

* It must be public.
* The class must have a public no-argument constructor.

   It is included by default. However, if you created your own constructor that accepts arguments, you must also create a no-argument one.

* It should not be [generic](https://docs.oracle.com/javase/8/docs/technotes/guides/language/generics.html).
