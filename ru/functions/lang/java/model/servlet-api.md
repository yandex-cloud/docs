# Использование класса HttpServlet для задания обработчика на Java

Вы можете задать обработчик на Java, переопределив выбранные методы класса [HttpServlet](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html).

Сервис {{ sf-name }} будет автоматически перенаправлять каждый `HTTP`-запрос в ваш обработчик, в зависимости от `HTTP`-метода, с которым этот запрос был инициирован. Например, `GET`-запрос будет перенаправлен в метод `doGet` вашего обработчика, а `POST` — в `doPost`. Для успешного перенаправления соответствующие методы обработчика должны существовать, иначе ответом функции будет сообщение `HTTP method XXX is not supported by this URL` с кодом `405`.

## Неподдерживаемые методы {#unsupported}

При использовании данной модели, обратите внимание на то, что некоторые методы классов [HttpServletRequest](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) и [HttpServletResponse](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html) не поддерживаются сервисом {{ sf-name }}.

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

## Пример: моделирование различного поведения функции при вызове с разными HTTP-методами

{% note warning %}

Не используйте для вызова этой функции параметр `?integration=raw`. При применении этого параметра функция не получает данных о методах, заголовках и параметрах исходного запроса.

{% endnote %}

{{ sf-name }} [поддерживает](../dependencies.md#maven) Maven — систему управления зависимостями для языка `Java`.

Чтобы создать функцию:
1. Создайте файл `Handler.java` по пути `/src/main/java/Handler.java` и файл `pom.xml`.
1. Добавьте в ZIP-архив директорию `/src` и файл `pom.xml`.
1. [Загрузите](../../../operations/function/version-manage.md#func-version-create) ZIP-архив в {{ sf-name }}.

Файл `pom.xml`:

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

Файл `Handler.java`:
```java
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Handler extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    // выставив значение Content-Type в text/html, позволяем браузеру рендерить html код
    response.setContentType("text/html");
    // отобразится в виде полужирной строки при вызове функции из браузера
    response.getOutputStream().print("<b>Hello, world. In bold.</b>");
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    var name = request.getParameter("name");
    response.getWriter().println("Hello, " + name);
    // printWriter, возвращаемый методом getWriter, нужно обязательно закрывать
    response.getWriter().close();
  }
}
```

Примеры запросов:

Метод: `GET`:

```html
<b>Hello, world. In bold.</b>
```

{% note info %}

При выполнении `GET`-запроса в браузере данная строка отобразится в полужирном шрифте, а теги пропадут, так как был указан `Content-Type: text/html` в коде обработчика.

{% endnote %}

Метод `POST`, параметр запроса `name=Anonymous`:

```text
Hello, Anonymous
```

Метод `PUT`:

```text
HTTP method PUT is not supported by this URL
```