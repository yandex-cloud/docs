# Using SpringBootApplication annotation to set a handler in Java

You can set a Java handler by loading a `Spring Boot` application with an entry point as a class with the [SpringBootApplication](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/autoconfigure/SpringBootApplication.html) annotation.

When being executed, the {{ sf-name }} function has no data about the path that was used to invoke it. In other words, if there is an `/api/v1/list` endpoint in your `Spring Boot` application, you will not be able to invoke the function at `https://{{ sf-url }}/function-id/api/v1/list`. Instead, you will have to provide path data in the request body (`url` parameter) or use [API Gateway](../../../../api-gateway/quickstart/index.md) integration. We recommend the second option because `API Gateway` is the simplest you can use with a `Spring Boot` application and enables you to address application endpoints the usual way.

In case your application logic uses the [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) and [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html) classes, please note that {{ sf-name }} does not support some methods of these classes. You can review the list of unsupported methods [here](servlet-api.md#unsupported).

{{ sf-name }} does not support Spring Boot Loader.



## Example of a simple application with an endpoint {#simple-example}

The following application has a single endpoint: `GET: /get/{name}`. In response to a `GET` request at `/get` with the path parameter specified, the function will return `Hello, $name`, where `$name` is the provided path parameter. In our example, we use a [public](../../../operations/function/function-public.md) function. If your function is [private](../../../operations/function/function-private.md), specify a service account with the `functions.functionInvoker` role in the API gateway specification.

1. [Create a function](../../../operations/function/function-create.md).

1. Create a ZIP archive with the following hierarchy:

    ```text
    src
    |__main
        |__java
            |__util
                |__Application.java
                |__controller
                    |__TestController.java
    pom.xml
    ```

    * `Application.java` file:

      ```java
      package util;

      import org.springframework.boot.SpringApplication;
      import org.springframework.boot.autoconfigure.SpringBootApplication;

      @SpringBootApplication
      public class Application {
          public static void main(String[] args) {
              SpringApplication.run(Application.class, args);
          }
      }
      ```

    * `TestController.java` file:

      ```java
      package util.controller;

      import org.springframework.web.bind.annotation.*;

      @RestController
      public class TestController {
          @GetMapping("/get/{name}")
          public String get(@PathVariable String name) {
              return String.format("Hello, %s!", name);
          }
      }
      ```

    * `pom.xml` file:

      ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
          <modelVersion>4.0.0</modelVersion>
          <parent>
              <groupId>org.springframework.boot</groupId>
              <artifactId>spring-boot-starter-parent</artifactId>
              <version>2.4.7</version>
              <relativePath/> <!-- lookup parent from repository -->
          </parent>

          <groupId>util</groupId>
          <artifactId>util</artifactId>
          <version>0.0.1-SNAPSHOT</version>

          <properties>
              <java.version>11</java.version>
              <spring.version>5.2.9.RELEASE</spring.version>
              <spring.boot.version>2.3.4.RELEASE</spring.boot.version>
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

              <dependency>
                  <groupId>javax.servlet</groupId>
                  <artifactId>javax.servlet-api</artifactId>
                  <version>4.0.1</version>
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

1. [Create](../../../operations/function/version-manage.md) a function version and specify:

    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `java17`.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: Upload the archive you created earlier.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `30`.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `util.Application`.

1. [Create](../../../../api-gateway/operations/api-gw-create.md) an {{ api-gw-name }} API gateway and add the following specification:

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

    Where:

    * `function_id`: Function ID.
    * `service_account_id`: Service account with the `functions.functionInvoker` role.

1. Create a request to the endpoint:

    ```
    curl \
      --request GET \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      https://{{ api-host-apigw }}/get/Anonymous
    ```

    Result:

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

