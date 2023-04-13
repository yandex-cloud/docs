# Использование аннотации SpringBootApplication для задания обработчика на Java

Вы можете задать обработчик на Java, загрузив `Spring Boot` приложение с точкой входа в виде класса, помеченного аннотацией [SpringBootApplication](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/autoconfigure/SpringBootApplication.html).

В момент исполнения функция {{ sf-name }} не имеет данных о пути, по которому она была вызвана. Другими словами, при наличии эндпоинта `/api/v1/list` в вашем `Spring Boot` приложении, вызвать функцию по адресу `https://functions.yandexcloud.net/function-id/api/v1/list` не получится, вместо этого нужно либо передать данные о пути в теле запроса (параметр `url`), либо воспользоваться интеграцией с [API Gateway](../../../../api-gateway/quickstart/index.md). Мы рекомендуем именно второй способ, поскольку `API Gateway` наиболее прост в использовании со `Spring Boot` приложением, а так же позволяет обращаться к эндпоинтам приложения привычным образом.

В случае, если логика вашего приложения использует классы [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) и [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html), обратите внимание, что сервис {{ sf-name }} поддерживает не все методы этих классов. Подробнее ознакомиться со списком неподдерживаемых методов можно [здесь](servlet-api.md#unsupported).

{{ sf-name }} не поддерживает Spring Boot Loader.

## Пример: простое приложение с эндпоинтом

Следующее приложение имеет один эндпоинт: `GET: /get/{name}`. По `GET` запросу по адресу `/get` с указанным параметром пути функция вернет строку `Hello, $name`, где `$name` — переданный параметр пути. В примере используется [публичная](../../../operations/function/function-public.md) функция. Если ваша функция [приватная](../../../operations/function/function-private.md), укажите в спецификации API-шлюза сервисный аккаунт, у которого есть права на ее вызов.

Файл `Application.java`:
```java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {
  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }
}
```

Файл `TestController.java`:
```java
import org.springframework.web.bind.annotation.*;

@RestController
public class TestController {
  @GetMapping("/get/{name}")
  public String get(@PathVariable String name) {
    return String.format("Hello, %s", name);
  }
}
```

Интеграция с `API Gateway`:
```api
openapi: 3.0.0
info:
  title: Test API
  version: 1.0.0
paths:
  /get/{name}:
    get:
      x-yc-apigateway-integration:
        type: cloud-functions
        function_id: <id вашей функции>
      operationId: get
      parameters:
      - description: my param
        explode: false
        in: path
        name: name
        required: true
        schema:
          type: string
        style: simple
```

Пример запроса:

```
https://your-apigw-id.apigw.yandexcloud.net/get/Anonymous
```

Возвращаемая строка:
```
Hello, Anonymous
```
