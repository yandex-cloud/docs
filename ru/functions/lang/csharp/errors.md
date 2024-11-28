# Обработка ошибок функции на .NET Core

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции на .NET Core, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий информацию о типе ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error).

Также информация об ошибке записывается в [журнал выполнения](logging.md), который можно [просмотреть](../../operations/function/function-logs.md) с помощью [CLI {{ yandex-cloud }}](../../../cli/index.yaml) или [консоли управления]({{ link-console-main }}).

#### Примеры обработки ошибки {#examples}

Ситуация 1: пользовательский код выходит за пределы массива, что приводит к выбрасыванию `IndexOutOfRangeException`. [Среда выполнения](../../concepts/runtime/index.md) перехватывает исключение и формирует из него JSON-документ, содержащий сообщение об ошибке (поле `errorMessage`), тип ошибки (поле `errorType`) и [трассировку стека](https://ru.qwe.wiki/wiki/Stack_trace) (поле `stackTrace`).

Код функции:

```C#
public class Handler {
  public int FunctionHandler(byte[] input) {
    readonly var array = new int[]{1, 2, 3, 4, 5};
    // в этом месте функция выбросит исключение IndexOutOfRangeException
    return array[15];
  }
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "Index was outside the bounds of the array",
  "errorType": "System.IndexOutOfRangeException",
  "stackTrace": [
    ...
  ]
}
```

Ситуация 2: пользовательский код сигнализирует об ошибке путем механизма [выбрасывания](https://docs.microsoft.com/ru-ru/dotnet/csharp/language-reference/keywords/throw) ее из функции.

Код функции:

```C#
public class Handler {
  public int FunctionHandler(byte[] input) {
    throw new SystemException("Some error message");
  }
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "Some error message",
  "errorType": "System.SystemException",
  "stackTrace": [
    ...
  ]
}
```
