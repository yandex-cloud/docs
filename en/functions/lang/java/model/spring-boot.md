# Using SpringBootApplication annotation to set a handler in Java

You can set a Java handler by loading a `Spring Boot` application with an entry point as a class with [SpringBootApplication](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/autoconfigure/SpringBootApplication.html) annotation.

When being executed, the {{ sf-name }} function has no data about the path that was used to invoke it. In other words, if there is an `/api/v1/list` endpoint in your `Spring Boot` application, you will not be able to use `https://{{ sf-url }}/function-id/api/v1/list` to call your function. Instead, you will have to provide path data in the request body (`url` parameter) or use [API Gateway](../../../../api-gateway/quickstart/index.md) integration. We recommend utilizing the second method because the `API Gateway` is easiest to use with a `Spring Boot` application and enables you to access application endpoints as usual.

In case your application logic uses the [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) and [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html) classes, please note that {{ sf-name }} does not support some methods of these classes. You can review the list of unsupported methods [here](servlet-api.md#unsupported).

{{ sf-name }} does not support Spring Boot Loader.



## Example of a simple application with an endpoint

The following application has a single endpoint: `GET: /get/{name}`. In response to a `GET` request at `/get` with the specified path parameter, the function returns `Hello, $name`, where `$name` is the provided path parameter. In our example, we use a [public](../../../operations/function/function-public.md) function. If your function is [private](../../../operations/function/function-private.md), specify a service account with the `functions.functionInvoker` role in the API gateway specification.

Function version parameters:

* **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `java17`
* **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10`
* **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
* **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `app.Application`

Project structure:

```text
src
 |__main
      |__ java
            |__ app
                 |__Application.java
                 |__TestController.java
pom.xml
```

The `Application.java` file:

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

The `TestController.java` file:

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

`pom.xml`:

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

Integration with {{ api-gw-name }}:

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
        function_id: <function_ID>
        service_account_id: <service_account_ID>
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

Sample request:

```
https://your-apigw-id.apigw.yandexcloud.net/get/Anonymous
```

Returned string:
```
Hello, Anonymous
```

Sample direct request where {{ api-gw-name }} is not used to invoke the function:

```
{
    "httpMethod": "GET",
    "url": "/get/Anonymous",
    "requestContext": {},
    "body": "",
    "isBase64Encoded": false
}
```

