# Использование интерфейса YcFunction для задания функции-обработчика на Java

Вы можете задать функцию-обработчик на Java, реализовав интерфейс [YcFunction](https://github.com/yandex-cloud/java-sdk/blob/master/java-sdk-functions/src/main/java/yandex/cloud/sdk/functions/YcFunction.java). Для этого дополнительно нужно добавить [SDK](../sdk.md) в [зависимости](../dependencies.md).

{% note warning %}

Вы должны указать оба значения для параметров типа `YcFunction`, причем первый тип является типом входного аргумента, а второй — типом возвращаемого значения. Так же у метода `handle` есть второй аргумент — [контекст вызова](../context.md).

{% endnote %}

Пример корректного обработчика:
```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;

public class Handler implements YcFunction<Integer, String> {
  @Override
  public String handle(Integer i, Context c) {
    return String.valueOf(i);
  }
}
```

Примеры некорректных обработчиков:
```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;
// у YcFunction указан лишь один тип параметра
// у Handler не должно быть типов-параметров (см. требования к обработчику)
public class Handler<T> implements YcFunction<T, Integer> {
  @Override
  public Integer handle(T i, Context c) {
    return 2;
  }
}
```

```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;
// у YcFunction не указаны оба типа параметра
public class Handler implements YcFunction {
  @Override
  public Object apply(Object i, Context c) {
    return i;
  }
}
```

Вы можете использовать любые классы в качестве входного и возвращаемого типов.

{% note info %}

Поля этих классов могут иметь любые [модификаторы доступа](https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html). В случае, когда поле непубличное, писать для него `getter`/`setter` необязательно.

{% endnote %}

## Пример: вывод информации о функции {#http-info}

Следующая функция получает на вход число, выводит данные о функции, взятые из контекста вызова, в журнал выполнения и возвращает данные о том, является ли переданное число четным.

{% note warning %}

Функцию необходимо вызывать с помощью [CLI {{ yandex-cloud }}](../../../concepts/function-invoke.md) или с помощью HTTP-запроса с параметром `?integration=raw`.

{% endnote %}

Файл `Handler.java`:
```java
import yandex.cloud.sdk.functions.YcFunction;
import yandex.cloud.sdk.functions.Context;

public class Handler implements YcFunction<Integer, Boolean> {

  private String format(String f, String s) {
    return String.format(f, s);
  }

  @Override
  public Boolean handle(Integer number, Context c) {
    System.out.println(format("Function name: %s", c.getFunctionName()));
    System.out.println(format("Function version: %s", c.getFunctionVersion()));
    // если не выбран сервисный аккаунт, напечатается пустая строка
    System.out.println(format("Service account token: %s", c.getTokenJson()));
    return number % 2 == 0;
  }
}
```

Пример входных данных:

```
41
```

В журнале будет напечатано:

```
Function name: <название вашей функции>
Function version: <id данной версии вашей функции>
Service account token: <token для вашего сервисного аккаунта>
```

Возвращаемая строка:

```
false
```
