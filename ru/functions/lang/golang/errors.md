# Обработка ошибок функции на Go

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции на Go, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий информацию о типе ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error).

Также информация об ошибке записывается в [журнал выполнения](logging.md), который можно [просмотреть](../../operations/function/function-logs.md) с помощью [{{ yandex-cloud }} CLI](../../../cli/index.yaml) или [консоли управления]({{ link-console-main }}).

#### Примеры обработки ошибки {#examples}

Ситуация 1: пользовательский код выходит за пределы массива, ожидается `panic`. В реальности [обработчик](handler.md) перехватывает `panic` автоматически, собирает информацию о нём воедино и формирует из неё JSON-документ, содержащий сообщение об ошибке (поле `errorMessage`), тип ошибки (поле `errorType`) и [трассировку стека](https://ru.qwe.wiki/wiki/Stack_trace) (поле `stackTrace`).

Код функции:

```golang
package main

func Handler () (int, error) {
  array := []int{1, 2, 3, 4, 5}
  return array[15], nil
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "user code execution causes panic: runtime error: index out of range [15] with length 5",
  "errorType": "UserCodePanic",
  "stackTrace": [
    ...
  ]
}
```

Ситуация 2: пользовательский код сигнализирует об ошибке путем возвращения её из функции. В этом случае [обработчик](handler.md) перехватывает данную ошибку и формирует из неё JSON-документ, содержащий сообщение пользовательской ошибки (поле `errorMessage`) и её тип (поле `errorType`).

Код функции:

```golang
package main

import "fmt"

func Handler () (int, error) {
  return 0, fmt.Errorf("an error")
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "an error",
  "errorType": "UserCodeError"
}
```
