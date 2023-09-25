## Примеры {#examples}

### Вывод структуры HTTP-запроса {#http-req}

Следующая функция получает на вход запрос с двумя полями (строкой и числом) и возвращает отформатированную строку с переданными данными.

{% note warning %}

Функцию необходимо вызывать с помощью [CLI {{ yandex-cloud }}](../../functions/concepts/function-invoke.md) или с помощью HTTP-запроса с параметром `?integration=raw`.

{% endnote %}

Файл Request.cs:

```C#
public class Request {
  public String message { get; set; }
  public int number { get; set; }
}
```

Файл Handler.cs:

```C#
public class Handler {
  public String FunctionHandler(Request r) {
    // на этом этапе в переменной r уже хранится разобранный запрос
    return $"Message is {r.message}, number is {r.number}";
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

### Разбор HTTP-запроса

Функция вызывается с помощью HTTP-запроса с именем пользователя, записывает в журнал метод и тело запроса и возвращает приветствие.

{% note warning %}

Не используйте для вызова функции параметр `?integration=raw`. При применении этого параметра функция не получает данных о методах, заголовках и параметрах исходного запроса.

{% endnote %}

Файл Request.cs:

```C#
public class Request {
  public String httpMethod { get; set; }
  public String body { get; set; }
}
```

Файл Response.cs:

```C#
public class Response {
  public int statusCode { get; set; }
  public String body { get; set; }

  public Response(int statusCode, String body) {
    this.statusCode = statusCode;
    this.body = body;
  }
}
```

Файл Handler.cs:

```C#
using System.Text.Json;

public class Handler {

  public Response FunctionHandler(Request r) {
    var method = r.httpMethod;
    var body = r.body;
    Console.WriteLine($"{method}, {body}");

    using var jsonDoc = JsonDocument.Parse(body);
    var root = jsonDoc.RootElement;

    // здесь из тела запроса достается параметр "name"
    // если не передать его, то выбросится ошибка
    var name = root.GetProperty("name").GetString(); 
    return new Response(200, $"Hello, {name}");
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