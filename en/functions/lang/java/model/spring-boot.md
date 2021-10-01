# Using the SpringBootApplication annotation to set a handler in Java

You can set a Java handler by loading the `Spring Boot` application with a class entry point marked with the [SpringBootApplication](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/autoconfigure/SpringBootApplication.html) annotation.

When being executed, the {{ sf-name }} function has no data about the path that was used to invoke it. In other words, if there is an endpoint like `/api/v1/list` in your `Spring Boot` application, you can't invoke the function at `https://functions.yandexcloud.net/function-id/api/v1/list`. Instead, either pass the path data in the request body (the `url` parameter), or use integration with the [API Gateway](../../../../api-gateway/quickstart/index.md). We recommend the second method, because the `API Gateway` is most easy to use with the `Spring Boot` application and it allows you to access application endpoints the usual way.

If your application's logic uses the [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) and [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html) classes, please note that some methods of these classes aren't supported in {{ sf-name }}. See the list of unsupported methods [here](servlet-api.md#unsupported).

## Example of a simple application with an endpoint

The following application has a single endpoint: `GET: /get/{name}`. In response to a `GET` request at `/get` with the specified path parameter, the function returns `Hello, $name`, where `$name` is the passed path parameter.

The `Application.java` file:

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

The `TestController.java` file:

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

Integration with the `API Gateway`:

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
        function_id: <your function ID>
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

