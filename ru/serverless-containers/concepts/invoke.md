# Вызов контейнера в {{ serverless-containers-name }}

Вызвать контейнер можно:
* через [HTTPS](#https);
* с помощью [триггера](#trigger);
* с помощью [расширения {{ api-gw-full-name }}](#extension).

{% include [port-variable-note.md](../../_includes/serverless-containers/port-variable-note.md) %}

## HTTPS {#https}

При вызове контейнера через HTTPS внутрь развернутого в контейнере приложения пробрасывается HTTP-запрос.

### Фильтрация заголовков сообщений {#filter}

При передаче в контейнер некоторые HTTP-заголовки запроса и ответа изменяются, как описано ниже.

{% list tabs %}

- Заголовки запроса
    
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

- Заголовки ответа
        
    - Удаляются из ответа:
        - "Host"
        - "Authorization"
        - "User-Agent"
        - "Connection"
        - "Max-Forwards"
        - "Cookie"
    
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

При вызове контейнера с помощью триггера JSON-описание события триггера передается в теле HTTP-запроса к контейнеру. IP-адрес источника запроса передается так же, как и при [вызове контейнера через HTTPS](#ip). Подробнее о [триггерах](trigger/index.md).

## Расширение {{ api-gw-full-name }} {#extension}

При вызове контейнера с помощью расширения {{ api-gw-name }} в контейнер передается HTTP-запрос, адресованный к API-шлюзу. В заголовке `Host` при этом указывается хост, по которому пользователь обратился к API-шлюзу, а не хост контейнера. IP-адрес источника запроса передается так же, как и при [вызове контейнера через HTTPS](#ip). Подробнее о расширении в [документации {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/containers.md).
