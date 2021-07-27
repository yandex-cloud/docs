---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Using the HttpServlet class to set a handler

You can set a handler by overriding the selected methods of the [HttpServlet](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html) class.

{{ sf-name }} will automatically redirect each `HTTP` request to your handler, depending on the `HTTP` method that this request was initiated with.For example, a `GET` request is redirected to your handler's `doGet` method and a `POST` request to the `doPost` method. For a successful redirect, the corresponding handler methods must exist, otherwise the function returns the `HTTP method XXX is not supported by this URL` message with code `405`.

## Unsupported methods {#unsupported}

When using this model, please note that some methods of the [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) and [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html) classes are not supported by {{ sf-name }}.

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

Don't use the `integration=raw` parameter to call this function. If you do, the function won't get any data about the original request's methods, headers, and parameters.

{% endnote %}

The `Handler.java` file:

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

Sample requests:

The `GET` method:

```html
<b>Hello, world. In bold.</b>
```

{% note info %}

When executing a `GET` request, this string is displayed in bold and the tags disappear in the browser, because `Content-Type: text/html` was specified in the handler code.

{% endnote %}

The `POST` method, the `name=Anonymous` request parameter:

```
Hello, Anonymous
```

The `PUT` method:

```
HTTP method PUT is not supported by this URL
```

