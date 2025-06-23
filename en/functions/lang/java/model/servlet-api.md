# Using the HttpServlet class to set a Java handler

You can define a Java handler by overriding the selected methods of the [HttpServlet](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html) class.

{{ sf-name }} will automatically redirect each `HTTP` request to your handler depending on the `HTTP` method used to initiate the request. A `GET` request, for instance, will be redirected to your handler's `doGet` method, and `POST`, to `doPost`. For a redirect to be successful, these handler methods must exist, otherwise the function will return `HTTP method XXX is not supported by this URL` with code `405`.

## Unsupported methods {#unsupported}

When using this model, please note that certain [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) and [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html) methods are not supported by {{ sf-name }}.

`HttpServletRequest`:
- getAuthType
- getCookies
- upgrade
- authenticate
- login
- logout
- getContextPath
- getServletPath
- getPathTranslated
- getRealPath
- getRemotePort
- getLocalAddr
- getLocalPort
- getServerPort
- isUserInRole
- getUserPrincipal
- getRequestedSessionId
- getSession
- changeSessionId
- isRequestedSessionIdValid
- isRequestedSessionIdFromCookie
- isRequestedSessionIdFromURL
- isRequestedSessionIdFromUrl

`HttpServletResponse`:
- encodeURL
- encodeRedirectURL
- encodeUrl
- encodeRedirectUrl

## Example of modeling various function behaviors when invoked using different HTTP methods

{% note warning %}

Do not use the `?integration=raw` parameter to invoke this function. If you do, the function will not get any data about the original request's methods, headers, or parameters.

{% endnote %}

{{ sf-name }} [supports](../dependencies.md#maven) Maven, which is a dependency management system for `Java`.

To create a function:
1. Create a file named `Handler.java` at `/src/main/java/Handler.java` and a file named `pom.xml`.
1. Add the `/src` directory and the `pom.xml` file to a ZIP archive.
1. [Upload](../../../operations/function/version-manage.md#func-version-create) the ZIP archive to {{ sf-name }}.

`pom.xml` file:

```xml
<project>
    <modelVersion>4.0.0</modelVersion>

    <groupId>my.company.app</groupId>
    <artifactId>servlet</artifactId>
    <version>1</version>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>compile</scope>
        </dependency>
    </dependencies>
</project>
```

`Handler.java` file:
```java
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Handler extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    // by setting the Content-Type to text/html, we let the browser render the HTML code
    response.setContentType("text/html");
    // displayed in bold when the function is invoked from the browser
    response.getOutputStream().print("<b>Hello, world. In bold.</b>");
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    var name = request.getParameter("name");
    response.getWriter().println("Hello, " + name);
    // the printWriter class returned by the getWriter method, make sure it's closed
    response.getWriter().close();
  }
}
```

Request examples:

`GET` method:

```html
<b>Hello, world. In bold.</b>
```

{% note info %}

Running a `GET` request in a browser will display this string in bold without any tags because you had specified `Content-Type: text/html` in your handler's code.

{% endnote %}

`POST` method, `name=Anonymous` as your request parameter:

```text
Hello, Anonymous
```

`PUT` method:

```text
HTTP method PUT is not supported by this URL
```

## Example of function information output {#get-context}

The following function outputs its metadata based on the [call context](../context.md).

`pom.xml` file:

```xml
<project>
    <modelVersion>4.0.0</modelVersion>

    <groupId>my.company.app</groupId>
    <artifactId>servlet</artifactId>
    <version>1</version>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>compile</scope>
        </dependency>
    </dependencies>
</project>
```

`Handler.java` file:

```java
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Handler extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String requestId = request.getHeader("Lambda-Runtime-Aws-Request-Id");
        String functionId = request.getHeader("Lambda-Runtime-Function-Name");
        String versionId = request.getHeader("Lambda-Runtime-Function-Version");
        String memoryLimit = request.getHeader("Lambda-Runtime-Memory-Limit");
        String tokenJson = request.getHeader("Lambda-Runtime-Token-Json");

        response.getOutputStream().print(String.format(
                "RequestID: %s\n" +
                "FunctionID: %s\n" +
                "VersionID: %s\n" +
                "MemoryLimit: %s\n" +
                "TokenJSON: %s",
                requestId,
                functionId,
                versionId,
                memoryLimit,
                tokenJson
        ));
    }
}
```

Request example:

```json
{
    "httpMethod": "GET",
    "requestContext": {},
    "body": "",
    "isBase64Encoded": true
}
```

Here is a response example:

```json
{
    "multiValueHeaders": {
        "Content-Type": [
            "application/json"
        ]
    },
    "isBase64Encoded": false,
    "statusCode": 200,
    "headers": {
        "Content-Type": "application/json"
    },
    "body": "
        RequestID: 6ccf3084-a92a-43a4-9122-5520********\n
        FunctionID: b09hcbdla2ro********\n
        VersionID: b09h91stkts4********\n
        MemoryLimit: 1024\n
        TokenJSON: 
    "
}
```