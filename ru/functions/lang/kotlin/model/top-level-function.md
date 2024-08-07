# Использование функции верхнего уровня для обработчика на Kotlin

Чтобы создать [обработчик](../handler.md) на Kotlin, вы можете задать [функцию верхнего уровня](https://kotlinlang.org/docs/functions.html#function-scope). Это функция, объявленная внутри пакета, для создания которой не нужно создавать класс.

Пример обработчика, который принимает число и его же возвращает:

```kotlin
fun handle(s: Int): Int = s
```

{% note warning %}

Передавайте в функции верхнего уровня только один параметр.

{% endnote %}

Протестировать функцию из примера выше можно следующими способами:

* В [консоли управления]({{ link-console-main }}), на странице функции, на вкладке **{{ ui-key.yacloud.serverless-functions.item.testing.label_title }}**.
* С помощью HTTPS-запроса с параметром [?integration=raw](../../../concepts/function-invoke.md#http):

   ```bash
   curl -H "Authorization: Bearer <IAM-тoкен>" \
        --data "<число>" \
        "https://functions.yandexcloud.net/<идентификатор_функции>?integration=raw"
   ```

   В параметре `--data` укажите число, которое должна вернуть функция.

## Примеры {#examples}

### Обработка HTTP-запроса {#handle-http-request}

Скрипт ниже обрабатывает [входящий HTTP-запрос](../../../concepts/function-invoke.md#http) и выводит результаты обработки: код ответа HTTP и тело ответа.

Файл `Handler.kt`:

```kotlin
data class Request(
    val httpMethod: String?,
    val headers: Map<String, String> = mapOf(),
    val body: String = ""
)

data class Response(
    val statusCode: Int,
    val body: String
)

fun handle(request: Request): Response {
    return Response(200, "Hello World!")
}
```

Формат результата зависит от того, указал ли пользователь параметр `?integration=raw` в запросе:

* С параметром `?integration=raw`:

    ```json
    {
        "statusCode": 200,
        "body": "Hello World!"
    }
    ```

* Без параметра `?integration=raw`:

    ```text
    "Hello World!"
    ```

    Код `200` будет передан не в теле ответа, как в случае параметра `?integration=raw`, а в виде HTTP-кода ответа.

### Вывод структуры HTTP-запроса {#http-request-structure}

Скрипт ниже обрабатывает входящий HTTP-запрос и выводит его структуру и код ответа HTTP.

Файл `Handler.kt`:

```kotlin
data class Response(
    val statusCode: Int,
    val body: String
)

fun handle(request: String): Response {
    return Response(200, request)
}
```
