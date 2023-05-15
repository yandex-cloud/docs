# Using SpringBootApplication annotation to set a handler in Java

You can set a Java handler by loading a `Spring Boot` application with an entry point as a class with [SpringBootApplication](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/autoconfigure/SpringBootApplication.html) annotation.

When being executed, the {{ sf-name }} function has no data about the path that was used to invoke it. In other words, if there is an `/api/v1/list` endpoint in your `Spring Boot` application, you will not be able to use `https://functions.yandexcloud.net/function-id/api/v1/list` to call your function. Instead, you will either have to pass path data in the body of the call (`url` parameter) or use [API Gateway](../../../../api-gateway/quickstart/index.md) integration. We recommend utilizing the second method because the `API Gateway` is easiest to use with a `Spring Boot` application and enables you to access application endpoints as usual.

In case your application logic uses the [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) and [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html) classes, please note that {{ sf-name }} does not support some methods of these classes. You can review the list of unsupported methods [here](servlet-api.md#unsupported).

{{ sf-name }} does not support Spring Boot Loader.

## Example of a simple application with an endpoint

The following application has a single endpoint: `GET: /get/{name}`. In response to a `GET` request at `/get` with the specified path parameter, the function returns `Hello, $name`, where `$name` is the provided path parameter. In our example, we use a [public](../../../operations/function/function-public.md) function. If your function is [private](../../../operations/function/function-private.md), specify a service account with permission to invoke it in the API gateway specification.

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

`API Gateway` integration:
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
