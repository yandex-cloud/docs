# Обработка ошибок функции на PHP

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции на PHP, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий подробную информацию о типе, тексте и месте возникновения ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error).

Также информация об ошибке записывается в [журнал выполнения](logging.md), который можно [просмотреть](../../operations/function/function-logs.md) с помощью [{{ yandex-cloud }} CLI](../../../cli/index.yaml) или [консоли управления]({{ link-console-main }}).

#### Пример обработки ошибки {#example}

Код функции:

```php
<?php

function myHandler ($event, $context) {
    return undefinedFunction();
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "Call to undefined function undefinedFunction()",
  "errorType": "Error",
  "stackTrace": [
    ...
  ]
}
```
