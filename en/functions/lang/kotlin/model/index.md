# Kotlin programming model

{{ sf-name }} provides two Kotlin programming models: one is based on [top-level functions](top-level-function.md), the other, on the [YcFunction](yc-function.md) interface. Unlike top-level functions, the `YcFunction` interface enables you to access the [invocation context](../context.md).

Both programming models enable using {{ yandex-cloud }} services via the [SDK](../sdk.md). To do this, add the SDK to the [Gradle dependencies](../dependencies.md#gradle).

## Distinct data types {#separate-types}

Kotlin programming models feature various distinct data types, such as `InputStream`, `String`, and `ByteArray`. They are used differently from other types. If the handler argument is of a distinct type, the runtime does not convert an [incoming HTTPS request](../../../concepts/function-invoke.md#http) to JSON. Instead, it sends the request directly to the user handler.

Handling distinct types is different when they become `Nullable`. Let’s assume the request body is `null` and the user invokes the function with the [?integration=raw](../../../concepts/function-invoke.md#http) parameter. The result the handler gets depends on the argument type:

* If the argument is `String?`, the handler gets the `null` value.
* If the argument is `String`, the handler gets a string containing the `null` text.

{% note info %}

The [Moshi](https://github.com/square/moshi) library is used for JSON serialization and deserialization.

{% endnote %}

## Handler requirements {#requirements}

No matter which model you select, the project can be uploaded as source code, a JAR archive, or a Gradle project. The requirements applied to handler classes also depend on the programming model:

* For top-level functions:

   * The function must be public.
   * It must not be [generic](https://kotlinlang.org/docs/java-interop.html#java-generics-in-kotlin).

* For the `YcFunction` interface:

   * The handler class must be public.
   * It must have a public no-argument constructor.

      It is provided by default. However, if you created your own constructor with arguments, you should also create a no-argument one.

   * The class must not be generic.
