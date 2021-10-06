# Вызов контейнера

Вызвать контейнер можно:
* через [HTTPS](#https);
* с помощью [триггера {{ sf-full-name }}](#trigger);
* с помощью [расширения {{ api-gw-full-name }}](#extension).

При вызове контейнера приложение принимает HTTP-запросы на порт, переданный в переменной окружения `PORT`. Порт, на котором приложение обслуживает HTTP-запросы, задается в настройках ревизии контейнера.

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

IP-адрес клиента, который вызвал контейнер, передается в заголовке `X-Forwarded-For`.

## Триггер {{ sf-full-name }} {#trigger}

При вызове контейнера c помощью триггера {{ sf-full-name }} JSON-описание события триггера передается в теле HTTP-запроса к контейнеру. Подробнее о триггерах в [документации {{ sf-full-name }}](../../functions/concepts/trigger/index.md).

## Расширение {{ api-gw-full-name }} {#extension}

При вызове контейнера с помощью расширения {{ api-gw-name }} контейнер получает HTTP-запрос, адресованный к API-шлюзу. В заголовке `Host` при этом указывается хост, по которому пользователь обратился к API-шлюзу, а не хост контейнера. Подробнее о расширении в [документации {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/containers.md).
