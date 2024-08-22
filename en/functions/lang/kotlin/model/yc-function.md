# Using the YcFunction interface for a handler in Kotlin

To create a [handler](../handler.md) in Kotlin, you can implement the [YcFunction](https://github.com/yandex-cloud/java-sdk/blob/master/java-sdk-functions/src/main/java/yandex/cloud/sdk/functions/YcFunction.java) interface. To do this, add the [SDK](../sdk.md) to the [dependencies](../dependencies.md).

Here is an example of a handler:

```kotlin
import yandex.cloud.sdk.functions.YcFunction
import yandex.cloud.sdk.functions.Context

class Handler : YcFunction<Int, Int> {
    override fun handle(event: Int, context: Context?): Int {
        return event
    }
}
```

{% note warning %}

Specify both values for `YcFunction` type parameters: the first one is for the input argument type, while the second one, for the return value type . For the `handle` method, make sure to provide the [invocation context](../context.md) as its second argument.

{% endnote %}

You can use any classes as input and return types. Fields of these classes may have any [access modifiers](https://kotlinlang.org/docs/visibility-modifiers.html).
