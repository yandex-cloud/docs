# Обработка ошибок функции на Node.js

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции на Node.js, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий подробную информацию о типе, тексте и месте возникновения ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error).

Также информация об ошибке записывается в [журнал выполнения](logging.md), который можно [просмотреть](../../operations/function/function-logs.md) с помощью [{{ yandex-cloud }} CLI](../../../cli/index.yaml) или [консоли управления]({{ link-console-main }}).

#### Пример обработки ошибки {#example}

Код функции:

```js
module.exports.handler = function () {
    return unknownVariable;
};
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "unknownVariable is not defined",
  "errorType": "ReferenceError",
  "stackTrace": [
    ...
  ]
}
```
