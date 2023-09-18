# Использование интерфейса Function для задания функции-обработчика на Java

Вы можете задать функцию-обработчик на Java, реализовав интерфейс [Function](https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html).

{% note warning %}

Вы должны указать оба значения для параметров типа `Function`, причем первый тип является типом входного аргумента, а второй — типом возвращаемого значения.

{% endnote %}

Пример корректного обработчика:
```java
import java.util.function.Function;

public class Handler implements Function<Integer, String> {
  @Override
  public String apply(Integer i) {
    return String.valueOf(i);
  }
}
```

Примеры некорректных обработчиков:
```java
import java.util.function.Function;
// у Function указан лишь один тип параметра
// у Handler не должно быть типов-параметров (см. требования к обработчику)
public class Handler<T> implements Function<T, Integer> {
  @Override
  public Integer apply(T i) {
    return 2;
  }
}
```

```java
import java.util.function.Function;
// у Function не указаны оба типа параметра
public class Handler implements Function {
  @Override
  public Object apply(Object i) {
    return i;
  }
}
```

Вы можете использовать любые классы в качестве входного и возвращаемого типов.

{% note info %}

Поля этих классов могут иметь любые [модификаторы доступа](https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html). В случае, когда поле непубличное, писать для него `getter`/`setter` необязательно.

{% endnote %}

## Примеры {#examples}

### Вывод структуры HTTP-запроса {#http-req}

Следующая функция получает на вход запрос с двумя полями (строкой и числом) и возвращает отформатированную строку с переданными данными.

{% note warning %}

Функцию необходимо вызывать с помощью [CLI {{ yandex-cloud }}](../../../concepts/function-invoke.md) или с помощью HTTP-запроса с параметром `integration=raw`.

{% endnote %}

Файл `Request.java`:
```java
public class Request {
  public String message;
  public int number;
}
```

Файл `Handler.java`:
```java
import java.util.function.Function;

public class Handler implements Function<Request, String> {

  @Override
  public String apply(Request r) {
    // на этом этапе в переменной r уже хранится разобранный запрос
    return String.format("Message is %s, number is %d", r.message, r.number);
  }
}
```

Пример входных данных:

```json
{
  "message": "Hello",
  "number": 24
}
```

Возвращаемая строка:

```
Message is Hello, number is 24
```

### Разбор HTTP-запроса {#parsing-http-req}

Функция вызывается с помощью HTTP-запроса с именем пользователя, записывает в журнал метод и тело запроса и возвращает приветствие.

{% note warning %}

Не используйте для вызова этой функции параметр `integration=raw`. При применении этого параметра функция не получает данных о методах, заголовках и параметрах исходного запроса.

{% endnote %}

{% note info %}

В данном примере для интерпретации `JSON` используется сторонняя библиотека [`org.json`](https://github.com/stleary/JSON-java).

{% endnote %}

Файл Request.java:
```java
public class Request {
  public String httpMethod;
  public String body;
}
```

Файл Response.java:
```java
public class Response {
  public int statusCode;
  public String body;

  public Response(int statusCode, String body) {
    this.statusCode = statusCode;
    this.body = body;
  }
}
```

Файл Handler.java:
```java
import java.util.function.Function;
import org.json.*;

public class Handler implements Function<Request, Response> {

  @Override
  public Response apply(Request r) {
    var method = r.httpMethod;
    var body = r.body;
    System.out.println(String.format("%s, %s", method, body));

    var jsonObject = new JSONObject(body);
    // здесь из тела запроса достается параметр "name"
    // если не передать его, то выбросится ошибка
    var name = jsonObject.getString("name");
    return new Response(200, String.format("Hello, %s", name));
  }
}
```

Пример входных данных (метод POST):

```json
{
  "name": "Anonymous"
}
```

В журнале будет напечатано:

```
POST, { "name": "Anonymous" }
```

Возвращаемый ответ:

```
Hello, Anonymous
```
