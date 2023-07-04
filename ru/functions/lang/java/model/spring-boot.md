# Использование аннотации SpringBootApplication для задания обработчика на Java

Вы можете задать обработчик на Java, загрузив `Spring Boot` приложение с точкой входа в виде класса, помеченного аннотацией [SpringBootApplication](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/autoconfigure/SpringBootApplication.html).

В момент исполнения функция {{ sf-name }} не имеет данных о пути, по которому она была вызвана. Другими словами, при наличии эндпоинта `/api/v1/list` в вашем `Spring Boot` приложении, вызвать функцию по адресу `https://functions.yandexcloud.net/function-id/api/v1/list` не получится, вместо этого нужно либо передать данные о пути в теле запроса (параметр `url`), либо воспользоваться интеграцией с [API Gateway](../../../../api-gateway/quickstart/index.md). Мы рекомендуем именно второй способ, поскольку `API Gateway` наиболее прост в использовании со `Spring Boot` приложением, а так же позволяет обращаться к эндпоинтам приложения привычным образом.

В случае, если логика вашего приложения использует классы [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) и [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html), обратите внимание, что сервис {{ sf-name }} поддерживает не все методы этих классов. Подробнее ознакомиться со списком неподдерживаемых методов можно [здесь](servlet-api.md#unsupported).

{{ sf-name }} не поддерживает Spring Boot Loader.

## Пример: простое приложение с эндпоинтом

Следующее приложение имеет один эндпоинт: `GET: /get/{name}`. По `GET` запросу по адресу `/get` с указанным параметром пути функция вернет строку `Hello, $name`, где `$name` — переданный параметр пути. В примере используется [публичная](../../../operations/function/function-public.md) функция. Если ваша функция [приватная](../../../operations/function/function-private.md), укажите в спецификации API-шлюза сервисный аккаунт с ролью `functions.functionInvoker`.

Параметры версии функции:

* **Среда выполнения** — `java17`.
* **Таймаут, с** — `10`.
* **Память** — `128 МБ`.
* **Точка входа** — `app.Application`.

Структура проекта:

```text
src
 |__main
      |__ java
            |__ app
                 |__Application.java
                 |__TestController.java
pom.xml
```

Файл `Application.java`:

```java
package app;

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
package app;

import org.springframework.web.bind.annotation.*;

@RestController
public class TestController {
    @GetMapping("/get/{name}")
    public String get(@PathVariable String name) {
        return String.format("Hello, %s!", name);
    }
}
```

Файл `pom.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.5.14</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>

    <groupId>app</groupId>
    <artifactId>app</artifactId>
    <version>0.0.1-SNAPSHOT</version>

    <properties>
        <java.version>17</java.version>
        <spring.version>5.3.24</spring.version>
        <spring.boot.version>2.5.14</spring.boot.version>
        <start-class>util.Application</start-class>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
            <version>${spring.boot.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>${spring.boot.version}</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>
```

Интеграция с {{ api-gw-name }}:

```yaml
openapi: 3.0.0
info:
  title: Test API
  version: 1.0.0
paths:
  /get/{name}:
    get:
      x-yc-apigateway-integration:
        type: cloud-functions
        function_id: <идентификатор_функции>
        service_account_id: <идентификатор_сервисного_аккаунта>
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

Пример прямого запроса, где для вызова функции не используется {{ api-gw-name }}:

```
{
    "httpMethod": "GET",
    "url": "/get/Anonymous",
    "requestContext": {},
    "body": "",
    "isBase64Encoded": false
}
```
