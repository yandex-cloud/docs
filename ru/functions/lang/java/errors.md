# Обработка ошибок функции на Java

Если [обработчик](handler.md) сигнализирует об ошибке исполнения или загрузки функции, [среда выполнения](../../concepts/runtime/index.md) автоматически перехватывает ошибку и возвращает в ответ JSON-документ, содержащий информацию о типе ошибки. Формат этого JSON-документа описан в разделе [Вызов функции](../../concepts/function-invoke.md#error). Информация об ошибке записывается в [журнал выполнения](logging.md).

## Примеры обработки ошибки {#examples}

Ситуация 1: пользовательский код выходит за пределы массива, что приводит к выбрасыванию `ArrayIndexOutOfBoundsException`. [Среда выполнения](../../concepts/runtime/index.md) перехватывает исключение и формирует из него JSON-документ, содержащий сообщение об ошибке (поле `errorMessage`), тип ошибки (поле `errorType`) и [трассировку стека](https://ru.qwe.wiki/wiki/Stack_trace) (поле `stackTrace`).

Код функции:

```java
import java.util.function.Function;

public class Handler implements Function<byte[], Integer> {
  @Override
  public Integer apply(byte[] input) {
    final var array = new int[]{1, 2, 3, 4, 5};
    // в этом месте функция выбросит исключение ArrayIndexOutOfBoundsException
    return array[15];
  }
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "Index 15 out of bounds for length 5",
  "errorType": "ArrayIndexOutOfBoundsException",
  "stackTrace": [
    ...
  ]
}
```

Ситуация 2: пользовательский код сигнализирует об ошибке путем механизма [выбрасывания](https://docs.oracle.com/javase/tutorial/essential/exceptions/throwing.html) ее из функции.

Код функции:

```java
import java.util.function.Function;

public class Handler implements Function<byte[], Integer> {
  @Override
  public Integer apply(byte[] input) {
    throw new RuntimeException("Some error message");
  }
}
```

Возвращаемый JSON-документ:

```json
{
  "errorMessage": "Some error message",
  "errorType": "RuntimeException",
  "stackTrace": [
    ...
  ]
}
```
