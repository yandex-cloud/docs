# Обработка ошибок функции на Kotlin

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий информацию о типе ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error). Информация об ошибке записывается в [журнал выполнения](logging.md).

## Примеры обработки ошибок {#examples}

Допустим, обработчик возвращает сумму чисел. Если он принимает пустой запрос, это приводит к выбрасыванию `IllegalArgumentException`.

Код функции:

```kotlin
fun handle(request: IntArray): Int {
    if (request.isEmpty()) throw IllegalArgumentException()
    return request.sum()
}
```

Ситуация 1. При вызове функции пользователь передает массив чисел `[1, 22, 333]`:

```bash
curl \
     --header "Authorization: Bearer <IAM-тoкен>" \
     --data "[1, 22, 333]" \
     "https://functions.yandexcloud.net/<идентификатор_функции>?integration=raw"
```

В результате возвращается сумма чисел `356`.

Ситуация 2. Пользователь передает пустой массив:

```bash
curl \
     --header "Authorization: Bearer <IAM-тoкен>" \
     --data "[]" \
     "https://functions.yandexcloud.net/<идентификатор_функции>?integration=raw"
```

Среда выполнения перехватывает исключение и формирует из него JSON-документ, содержащий сообщение об ошибке (поле `errorMessage`), тип ошибки (поле `errorType`) и [трассировку стека](https://ru.qwe.wiki/wiki/Stack_trace) (поле `stackTrace`).

Возвращаемый JSON-документ:

```json
{
    "errorMessage": "An exception has occurred in the user code, details: java.lang.IllegalArgumentException. [ERR_USER_CODE]",
    "errorType": "IllegalArgumentException",
    "stackTrace": [
        {
            "function": "handle",
            "file": "Handler.kt",
            "line": 2
        },
            ...
    ]
}
```

Ситуация 3. Вместо чисел передается строка, что приводит к ошибке десериализации:

```bash
curl \
     --header "Authorization: Bearer <IAM-тoкен>" \
     --data "notanarray" \
     "https://functions.yandexcloud.net/<идентификатор_функции>?integration=raw"
```

Возвращаемый JSON-документ:

```json
{
    "errorMessage": "An exception has occurred during request deserialization. Details: com.squareup.moshi.JsonEncodingException: Use JsonReader.setLenient(true) to accept malformed JSON at path $. [ERR_INVALID_REQUEST]",
    "errorType": "FunctionException"
}
```
