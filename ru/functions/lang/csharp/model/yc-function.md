# Использование интерфейса YcFunction для задания функции-обработчика на С#

Вы можете задать функцию-обработчик на C#, реализовав интерфейс [YcFunction](https://github.com/yandex-cloud/dotnet-sdk/blob/master/Yandex.Cloud.SDK/Functions/YcFunction.cs). Для этого дополнительно нужно добавить [SDK](../sdk.md) в [зависимости](../dependencies.md).

{% note warning %}

Вы должны указать оба значения для параметров типа `YcFunction`, причем первый тип является типом входного аргумента, а второй — типом возвращаемого значения. Также у метода `handle` есть второй аргумент — [контекст вызова](../context.md).

{% endnote %}

Пример корректного обработчика:
```C#
public class Handler : YcFunction<int, String> {
  public String FunctionHandler(int i, Context c) {
    return String.valueOf(i);
  }
}
```

Примеры некорректных обработчиков:
```C#
// у YcFunction указан лишь один тип параметра
// у Handler не должно быть типов-параметров
public class Handler<T> : YcFunction<T, int> {
  public int FunctionHandler(T i, Context c) {
    return 2;
  }
}
```

```C#
// у YcFunction не указаны оба типа параметра
public class Handler : YcFunction {
  public Object FunctionHandler(Object i, Context c) {
    return i;
  }
}
```

Подробнее о требованиях к обработчику см. в разделе [{#T}](index.md).

Вы можете использовать любые классы в качестве входного и возвращаемого типов.

{% note info %}

Поля этих классов могут иметь любые [модификаторы доступа](https://docs.microsoft.com/ru-ru/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers). В случае, когда поле непубличное, для него необходим публичный `getter`. В противном случае поле не попадет в ответ.

{% endnote %}

## Пример {#example}

### Вывод информации о функции {#http-info}

Следующая функция:
1. Получает на вход число.
1. Выводит данные о функции, взятые из контекста вызова, в журнал выполнения
1. Возвращает данные о том, является ли переданное число четным.

{% note warning %}

Функцию необходимо вызывать с помощью [{{ yandex-cloud }} CLI](../../../concepts/function-invoke.md) или с помощью HTTP-запроса с параметром `?integration=raw`.

{% endnote %}

Файл Handler.cs:

```C#
using Yandex.Cloud.Functions;

public class Handler : YcFunction<int, bool> {

  public bool FunctionHandler(int number, Context c) {
    Console.WriteLine($"Function name: {c.FunctionId}");
    Console.WriteLine($"Function version: {c.FunctionVersion}");
    Console.WriteLine($"Service account token: {c.TokenJson}");
    return number % 2 == 0;
  }
}
```

Пример входных данных:

```text
41
```

В журнале будет напечатано:

```text
Function name: <название_функции>
Function version: <идентификатор_версии_функции>
Service account token: <токен_сервисного_аккаунта>
```

Возвращаемая строка:

```text
false
```
