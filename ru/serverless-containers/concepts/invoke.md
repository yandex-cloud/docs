---
title: Вызов контейнера в {{ serverless-containers-full-name }}
description: Вы можете вызвать контейнер с помощью HTTPS, триггера или расширения {{ api-gw-full-name }}.
---

# Вызов контейнера в {{ serverless-containers-name }}

Вызвать контейнер можно:
* через [HTTPS](#https);
* с помощью [триггера](#trigger);
* с помощью [расширения {{ api-gw-full-name }}](#extension).

{% include [active-revision](../../_includes/serverless-containers/active-revision.md) %}

{% include [port-variable-note](../../_includes/serverless-containers/port-variable-note.md) %}

{% include [invoke-container](../../_includes/serverless-containers/invoke-container.md) %}

## HTTPS {#https}

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

{% include [ip](../../_includes/serverless-containers/ip.md) %}

## Триггер {#trigger}

При вызове контейнера с помощью триггера по [адресу, по которому вызывается контейнер](../operations/invocation-link.md), отправляется HTTP-запрос с методом POST. Тело запроса содержит JSON-описание события триггера. IP-адрес источника запроса передается так же, как и при [вызове контейнера через HTTPS](#ip). Подробнее о [триггерах](trigger/index.md).

## Расширение {{ api-gw-full-name }} {#extension}

При вызове контейнера с помощью расширения {{ api-gw-name }} в контейнер передается HTTP-запрос, адресованный к API-шлюзу. В заголовке `Host` при этом указывается хост, по которому пользователь обратился к API-шлюзу, а не хост контейнера. IP-адрес источника запроса передается так же, как и при [вызове контейнера через HTTPS](#ip). Подробнее о расширении в [документации {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/containers.md).
