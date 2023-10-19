# Java programming model


{{ sf-name }} provides four models for programming in Java: using the [Function](jdk-function.md) and [YcFunction](yc-function.md) interfaces, the [HttpServlet](servlet-api.md) class, and the [Spring Boot](spring-boot.md) framework. The first three methods of setting a function handler involve writing their own implementations of these interfaces or classes, and the last one involves loading an application in its original form without any changes.

The difference between the [Function](jdk-function.md) and [YcFunction](yc-function.md) models is in the [invocation context](../context.md) that is either available or not. If, for example, you need to interact with {{ yandex-cloud }} services using the [SDK](../sdk.md), we recommend choosing [YcFunction](yc-function.md). The model based on the [HttpServlet](servlet-api.md) class lets you get full control over the return value and `HTTP` method, which was used to call the function. Like the `YcFunction` model, it grants access to the [invocation context](../context.md).


For the [Function](jdk-function.md) and [YcFunction](yc-function.md) models, there are two separate types: `byte[]` and `String`. Using them is different from using other types. If you use them as the handler function argument type, the runtime does not convert an incoming request to a `JSON` interpretation for these types and delivers it directly to the user handler function. The exception is when the parameter [?integration=raw](../../../concepts/function-invoke.md#http).

{% note info %}

The library used for serialization and deserialization of `JSON` is [jsoniter](http://jsoniter.com/java-features.html).

{% endnote %}

## Handler requirements {#requirements}

Regardless of the selected model, a project is uploaded as a source code, as a `jar` archive, or as a `maven` project. In addition, the following requirements apply to a class that contains a handler function:
1. It must be public.
1. It must have a public constructor with no arguments.
   By default, it is present. But if you created your own constructor that accepts arguments, you should also create a constructor that doesn't accept any arguments.
1. It shouldn't be [generic](https://docs.oracle.com/javase/8/docs/technotes/guides/language/generics.html).
