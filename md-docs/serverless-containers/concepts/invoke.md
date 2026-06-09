# Вызов контейнера в {{ serverless-containers-name }}

Вызвать контейнер можно:
* через [HTTPS](#https);
* с помощью [триггера](#trigger);
* с помощью [расширения {{ api-gw-full-name }}](#extension).

При вызове контейнера запускается [активная ревизия](container.md#revision).

Процесс, который запускается при вызове контейнера, зависит от [режима работы контейнера](container.md#runtime).

Вызов контейнера завершается в одном из следующих случаев:

* {{ serverless-containers-name }} обработал HTTP-запрос за заданный таймаут и вернул HTTP-ответ в соответствии с [режимом работы контейнера](container.md#runtime). Таймаут включает в себя время запуска экземпляра контейнера.
* {{ serverless-containers-name }} не успел обработать HTTP-запрос за заданный таймаут и вернул ошибку 504.
* Произошла инфраструктурная ошибка или ошибка инициализации, информация о которой будет передана в теле ответа.

## HTTPS {#https}

{% note info %}

Возможность вызова контейнера может быть ограничена [политиками авторизации](../../iam/concepts/access-control/access-policies.md#supported-policies).

{% endnote %}

При вызове контейнера через HTTPS внутрь развернутого в контейнере приложения пробрасывается HTTP-запрос.

### Фильтрация заголовков сообщений {#filter}

При передаче в контейнер некоторые HTTP-заголовки запроса и ответа изменяются, как описано ниже.

{% list tabs %}

- Заголовки запроса {#request-headers}
    
    Удаляются из запроса:

    - "Expect"
    - "Te"
    - "Trailer"
    - "Upgrade"
    - "Proxy-Authenticate"
    - "Authorization"
    - "Connection"        
    - "Content-Md5"       
    - "Max-Forwards"
    - "Server"
    - "Transfer-Encoding"
    - "Www-Authenticate"
    - "Cookie"

- Заголовки ответа {#response-headers}
        
    - Удаляются из ответа:
        - "Host"
        - "Authorization"
        - "User-Agent"
        - "Connection"
        - "Max-Forwards"
        - "Cookie"
        - "X-Request-Id"
        - "X-Function-Id"
        - "X-Function-Version-Id"
        - "X-Content-Type-Options"
    
    - Вызывают ошибку, если присутствуют в ответе:
    
        - "Proxy-Authenticate"
        - "Transfer-Encoding"
        - "Via"
    
    - Перезаписываются с добавлением префикса `X-Yf-Remapped-`:
        - "Content-Md5"
        - "Date"
        - "Server"
        - "Www-Authenticate"

{% endlist %}

### IP-адрес источника запроса {#ip}

Если в запросе есть заголовок [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For), в нем передаются указанные IP-адреса и IP-адрес пользователя, который вызвал контейнер. Иначе — только IP-адрес пользователя, который вызвал контейнер.

## Триггер {#trigger}

При вызове контейнера с помощью триггера по [адресу, по которому вызывается контейнер](../operations/invocation-link.md), отправляется HTTP-запрос с методом POST. Тело запроса содержит JSON-описание события триггера. IP-адрес источника запроса передается так же, как и при [вызове контейнера через HTTPS](#ip). Подробнее о [триггерах](trigger/index.md).

## Расширение {{ api-gw-full-name }} {#extension}

При вызове контейнера с помощью расширения {{ api-gw-name }} в контейнер передается HTTP-запрос, адресованный к API-шлюзу. В заголовке `Host` при этом указывается хост, по которому пользователь обратился к API-шлюзу, а не хост контейнера. IP-адрес источника запроса передается так же, как и при [вызове контейнера через HTTPS](#ip). Подробнее о расширении в [документации {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/containers.md).

## Примеры использования {#examples}

* [{#T}](../tutorials/movies-database.md)
* [{#T}](../tutorials/pg-connect.md)
* [{#T}](../tutorials/functions-framework-to-container.md)