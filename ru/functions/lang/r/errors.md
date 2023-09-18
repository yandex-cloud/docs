# Обработка ошибок функции на R

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции на R, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий информацию о типе ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error).

Также информация об ошибке записывается в [журнал выполнения](logging.md), который можно [просмотреть](../../operations/function/function-logs.md) с помощью [CLI {{ yandex-cloud }}](../../../cli/index.yaml) или [консоли управления]({{ link-console-main }}).

#### Примеры обработки ошибки {#examples}

Ситуация 1: пользовательский код выходит за пределы массива, что приводит к выбрасыванию `non-numeric argument to binary operator`. [Среда выполнения](../../concepts/runtime/index.md) перехватывает исключение и формирует из него JSON-документ, содержащий сообщение об ошибке (поле `errorMessage`), тип ошибки (поле `errorType`).

Код функции:

```R
handler <-function() {
  return(paste0('{"result":"', "1" + 2,'"}'))
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "Error in a + b: non-numeric argument to binary operator\n",
  "errorType": "simpleError",
}
```

Ситуация 2: пользовательский код сигнализирует об ошибке путем механизма [выбрасывания](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/stop) ее из функции.

Код функции:

```R
handler <- function() {
  stop("Some error message")
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "Error in handler(): Some error message\n",
  "errorType": "simpleError",
}
```
