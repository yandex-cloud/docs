# Использование интерфейса YcFunction для обработчика на Kotlin

Чтобы создать [обработчик](../handler.md) на Kotlin, вы можете реализовать интерфейс [YcFunction](https://github.com/yandex-cloud/java-sdk/blob/master/java-sdk-functions/src/main/java/yandex/cloud/sdk/functions/YcFunction.java). Для этого дополнительно добавьте [SDK](../sdk.md) в [зависимости](../dependencies.md).

Пример обработчика:

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

Указывайте два значения для параметров типа `YcFunction`: первый тип является типом входного аргумента, второй — типом возвращаемого значения. Для метода `handle` не забудьте передать второй аргумент — [контекст вызова](../context.md).

{% endnote %}

Можно использовать любые классы в качестве входного и возвращаемого типов. Поля этих классов могут иметь любые [модификаторы доступа](https://kotlinlang.org/docs/visibility-modifiers.html).
