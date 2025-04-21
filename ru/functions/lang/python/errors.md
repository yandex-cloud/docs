# Обработка ошибок функции на Python

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции на Python, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий подробную информацию о типе, тексте и месте возникновения ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error).

Также информация об ошибке записывается в [журнал выполнения](logging.md), который можно [просмотреть](../../operations/function/function-logs.md) с помощью [{{ yandex-cloud }} CLI](../../../cli/) или [консоли управления]({{ link-console-main }}).

#### Пример обработки ошибки {#example}

Код функции:

```python
def handler(event, context):
    return unknownVariable
```

Возвращаемый JSON-документ:

```json
{
    "errorMessage": "name 'unknownVariable' is not defined",
    "errorType": "NameError",
    "stackTrace": [
        "  File \"/function/runtime/runtime.py\", line 155, in handle_event\n    result = h(r.event, r.context)\n",
        "  File \"/function/code/main.py\", line 2, in handler\n    return unknownVariable\n"
    ]
}
```
