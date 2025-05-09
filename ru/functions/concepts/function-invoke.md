---
title: Вызов функции в {{ sf-full-name }}
description: Из статьи вы узнаете про вызов функции {{ sf-name }} с помощью HTTPS-запроса, CLI, триггера и расширения {{ api-gw-name }}.
---

# Вызов функции в {{ sf-name }}

Функцию можно вызвать: 
* [с помощью HTTPS-запроса](#http);
* [с помощью CLI](#cli);
* [с помощью триггера](#trigger);
* [с помощью расширения {{ api-gw-full-name }}](#extension);
* [с помощью событий в {{ monitoring-short-name }}](#monitoring).

Для каждого способа есть своя структура данных запроса к функции и ответа функции. Вызвать определенную [версию](function.md#version) функции можно, используя [тег](function.md#tag). Подробнее о том, как [вызвать функцию](../operations/function/function-invoke.md).

## Вызов функции с помощью HTTPS {#http}

Если функция вызывается для обработки HTTPS-запроса, то она получает первым аргументом данные о запросе в формате JSON: название HTTP-метода, заголовки, аргументы и другие параметры запроса.

Результат, который возвращает функция, также должен представлять из себя JSON-документ, содержащий код ответа HTTP, заголовки ответа и содержимое ответа. {{ sf-name }} автоматически обработает этот JSON, и пользователь получит данные в виде стандартного HTTPS-ответа.

{% note info %}

Вы можете запускать функцию с указанием параметра строки запроса `?integration=raw`. При использовании такой формы вызова функция не может анализировать и задавать HTTP-заголовки: 
* Содержимое тела HTTPS-запроса передается первым аргументом (без преобразования в JSON-структуру).
* Содержимое тела HTTPS-ответа совпадает с ответом функции (без преобразования и проверки структуры), HTTP-статус ответа: 200.

{% endnote %}

### Структура запроса {#request}

JSON-структура запроса:

```
{
    "httpMethod": "<название HTTP-метода>",
    "headers": <словарь со строковыми значениями HTTP-заголовков>,
    "multiValueHeaders": <словарь со списками значений HTTP-заголовков>,
    "queryStringParameters": <словарь queryString-параметров>,
    "multiValueQueryStringParameters": <словарь списков значений queryString-параметров>,
    "requestContext": <словарь с контекстом запроса>,
    "body": "<содержимое запроса>",
    "isBase64Encoded": <true или false>
}
```

Где:

- `httpMethod` — название HTTP-метода, такое как: DELETE, GET, HEAD, OPTIONS, PATCH, POST или PUT.
- `headers` — словарь строк, содержащий HTTP-заголовки запроса и их значения. Если один и тот же заголовок передан несколько раз, словарь содержит последнее переданное значение.
- `multiValueHeaders` — словарь, содержащий HTTP-заголовки запроса и списки с их значениями. Он содержит те же самые ключи, что и словарь `headers`, но если какой-либо заголовок повторялся несколько раз, список для него будет содержать все переданные значения для данного заголовка. Если заголовок был передан всего один раз, он включается в этот словарь, и список для него будет содержать одно значение.
- `queryStringParameters` — словарь, содержащий параметры запроса. Если один и тот же параметр указан несколько раз, словарь содержит последнее указанное значение.
- `multiValueQueryStringParameters` — словарь, содержащий для каждого параметра запроса список со всеми указанными значениями. Если один и тот же параметр указан несколько раз, словарь содержит все указанные значения.
- `requestContext` содержит следующую структуру: 
  
    ```
    {
        "identity": "<набор пар ключ:значение для аутентификации пользователя>",
        "httpMethod": "<DELETE, GET, HEAD, OPTIONS, PATCH, POST или PUT>",
        "requestId": "<ID запроса, генерируется в роутере>",
        "requestTime": "<время запроса в формате CLF>",
        "requestTimeEpoch": "<время запроса в формате Unix>",
        "authorizer": "<словарь с контекстом авторизации>",
        "apiGateway": "<словарь со специфичными данными, передаваемыми API-шлюзом при вызове функции>",
        "connectionId": "<идентификатор веб-сокетного соединения>",
        "connectedAt": "<время подключения веб-сокетного соединения>",
        "eventType": "<тип события или операции с веб-сокетом: CONNECT, MESSAGE, DISCONNECT>",
        "messageId": "<идентификатор сообщения, полученного из веб-сокета>",
        "disconnectStatusCode": "<статус-код закрытия веб-сокета>",
        "disconnectReason": "<текстовое описание причины закрытия веб-сокета>"
    }
    ```
               
    Структура элемента `identity`:
    ```
    {
        "sourceIp": "<адрес, с которого был сделан запрос>",
        "userAgent": "<содержимое HTTP-заголовка User-Agent исходного запроса>"
    }
    ```

    Структура элемента `apiGateway`:
    ```
    {
        "operationContext": "<словарь с контекстом операции, описанным в спецификации API-шлюза>"
    }
    ```  

    Структура элемента `authorizer`:
    ```
    {
        "jwt": { // Поле, которое заполняет JWT-авторайзер API Gateway. Содержит данные из токена о пользователе и его правах'
          "claims": "<словарь полей тела JWT>",
          "scopes": "<список прав владельца JWT>"
        }
        // Другие поля контекста авторизации, возвращаемые из функции-авторайзера
    }
    ```

- `body` — содержимое запроса в виде строки. Данные могут быть закодированы в формат Base64 (в этом случае {{ sf-name }} установит параметр `isBase64Encoded: true`).

    {% note info %}
    
    Если функция вызывается с заголовком `Content-Type: application/json`, то содержимое `body` останется в исходном формате (значение параметра `isBase64Encoded: false`).
    
    {% endnote %}
    
- `isBase64Encoded` — если `body` содержит данные закодированные в Base64, то {{ sf-name }} установит значение параметра в `true`. 

#### Отладка функции {#example}

Чтобы отладить обработку параметров, используйте функцию, которая возвращает JSON-структуру запроса. Пример такой функции приведен ниже.

```js
module.exports.handler = async (event) => {
    return { 
        body: JSON.stringify(event)
    };
};
```

Например, для запроса:

```bash
curl \
  --request POST \
  --data "hello, world!" \
  "https://{{ sf-url }}/<ID функции>?a=1&a=2&b=1"
```

Результат будет выглядеть следующим образом: 

```text
{
  "httpMethod": "POST",
  "headers": {
    "Accept": "*/*",
    "Content-Length": "13",
    "Content-Type": "application/x-www-form-urlencoded",
    "User-Agent": "curl/7.58.0",
    "X-Real-Remote-Address": "[88.99.0.24]:37310",
    "X-Request-Id": "cd0d12cd-c5f1-4348-9dff-c50a78f1eb79",
    "X-Trace-Id": "92c5ad34-54f7-41df-a368-d4361bf376eb"
  },
  "path": "",
  "multiValueHeaders": {
    "Accept": [ "*/*" ],
    "Content-Length": [ "13" ],
    "Content-Type": [ "application/x-www-form-urlencoded" ],
    "User-Agent": [ "curl/7.58.0" ],
    "X-Real-Remote-Address": [ "[88.99.0.24]:37310" ],
    "X-Request-Id": [ "cd0d12cd-c5f1-4348-9dff-c50a78f1eb79" ],
    "X-Trace-Id": [ "92c5ad34-54f7-41df-a368-d4361bf376eb" ]
  },
  "queryStringParameters": {
    "a": "2",
    "b": "1"
  },
  "multiValueQueryStringParameters": {
    "a": [ "1", "2" ],
    "b": [ "1" ]
  },
  "requestContext": {
    "identity": {
      "sourceIp": "88.99.0.24",
      "userAgent": "curl/7.58.0"
    },
    "httpMethod": "POST",
    "requestId": "cd0d12cd-c5f1-4348-9dff-c50a78f1eb79",
    "requestTime": "26/Dec/2019:14:22:07 +0000",
    "requestTimeEpoch": 1577370127
  },
  "body": "aGVsbG8sIHdvcmxkIQ==",
  "isBase64Encoded": true
}
```

### Служебные данные {#service-data} 

Опционально функция может принимать второй аргумент со следующей структурой:

```
{
  "requestId": "<идентификатор запроса>",
  "functionName": "<идентификатор функции>",
  "functionVersion": "<идентификатор версии функции>",
  "memoryLimitInMB": "<объем памяти версии функции, МБ>",
  "token": "<опционально, IAM-токен>",
}
```

Где:

- `requestId` — идентификатор запроса к функции, генерируется при обращении к функции и отображается в журнале вызова функции.
- `functionName` — идентификатор функции.
- `functionVersion` — идентификатор версии функции.
- `memoryLimitInMB` — объем памяти, указанный для версии функции, МБ.
- `token` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, указанного для версии функции. Актуальное значение генерируется автоматически. Используется для работы с [API {{ yandex-cloud }}](../../api-design-guide/). Поле присутствует, только если для версии функции указан корректный сервисный аккаунт.

Пример использования служебных данных в функции:

```js
module.exports.handler = async (event, context) => {
    const iamToken = context.token;
    ...
    return { 
        body: ...
    };
};
```

### Структура ответа {#response}

{{ sf-name }} интерпретирует результат выполнения функции для того, чтобы заполнить содержимое HTTPS-ответа, его заголовки и код состояния. Для этого функция должна возвращать ответ следующей структуры:

``` 
{
    "statusCode": <HTTP код ответа>,
    "headers": <словарь со строковыми значениями HTTP-заголовков>,
    "multiValueHeaders": <словарь со списками значений HTTP-заголовков>,
    "body": "<содержимое ответа>",
    "isBase64Encoded": <true или false>
}
```       

Где: 

- `statusCode` — код состояния HTTP, по которому клиент узнаёт результаты запроса. 
- `headers` — словарь строк, содержащий HTTP-заголовки ответа и их значения.
- `multiValueHeaders` — словарь, в котором для HTTP-заголовков ответа можно указать одно или несколько значений в виде списка. Если один и тот же заголовок указан и в `headers`, и в `multiValueHeaders`, содержимое `headers` игнорируется.
- `body` — содержимое ответа в виде строки. Для работы с бинарными данными содержимое может быть закодировано в формат Base64. В этом случае установите параметр `isBase64Encoded: true`.
- `isBase64Encoded` — если `body` закодирован в формат Base64, установите значение параметра в `true`.

### Обработка ошибок в коде пользовательской функции {#error}

В случае возникновения необработанной ошибки в пользовательском коде, {{ sf-name }} вернет результат с кодом ошибки 502 и подробным описанием ошибки в виде следующей JSON-структуры: 

```
{
  "errorMessage": "<сообщение ошибки>",
  "errorType": "<тип ошибки>",
  "stackTrace": <опционально, список вызываемых методов>
}
```

Где:

- `errorMessage` — строка с описанием ошибки.
- `errorType` — зависящий от языка программирования тип ошибки или исключения.
- `stackTrace` — стек выполнения функции в момент возникновения ошибки.

Конкретное содержимое указанных полей зависит от языка программирования и среды выполнения вашей функции.

#### Ошибка в случае некорректной JSON-структуры ответа {#uncorrect-json}

Если структура ответа вашей функции не соответствует тому, что описано в разделе [Структура данных ответа](#response), то {{ sf-name }} вернет результат с кодом ошибки 502 и следующий ответ:

```
{
  "errorMessage": "Malformed serverless function response: not a valid json",
  "errorType": "ProxyIntegrationError",
  "payload": "<исходное содержимое ответа функции>"
}
```

### Возможные коды ответа {{ sf-name }} {#http-state}

В случае ошибки в пользовательской функции к ответу добавляется заголовок `X-Function-Error: true`.

{{ sf-name }} может возвращать результат со следующими HTTP-кодами: 

- `200 OK` — функция успешно выполнена.
- `400 BadRequest` — ошибка в параметрах HTTPS-запроса.
- `403 Forbidden` — запрос не может быть выполнен из-за ограничений в доступе для клиента к функции. 
- `404 Not Found` — по указанному URL не найдена функция.
- `413 Payload Too Large` — превышение [лимита](../concepts/limits.md#limits) на размер JSON-структуры запроса превышает 3,5 МБ.
- `429 TooManyRequests` — слишком высокая интенсивность вызова функции: 
    - Превышение [квоты](../concepts/limits.md#functions-quotas) на количество выполняемых запросов.
    - Текущий запрос не был выполнен, так как все исполнители уже перегружены существующими запросами к данной функции.
- `500 Internal Server Error` — внутренняя ошибка сервера.
- `502 BadGateway` — ошибка в коде функции или в формате возвращаемого JSON-ответа.
- `503 Service Unavailable` — недоступность сервиса {{ sf-name }}. 
- `504 Gateway Timeout` — превышено максимальное время выполнения функции до таймаута.

### Фильтрация заголовков сообщений {#headers}

Ваша функция получает и передает содержимое HTTP-заголовков в виде полей JSON-структуры, как описано [выше](#http). Некоторые заголовки запроса и ответа удаляются или переименовываются, как описано ниже.

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

Если в запросе есть заголовок [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For), в нем передаются указанные IP-адреса и IP-адрес клиента, который вызвал функцию. Иначе — только IP-адрес клиента, который вызвал функцию.

### Примеры использования {#examples-https}

* [{#T}](../tutorials/connect-to-ydb-nodejs.md)

## Вызов функции с помощью CLI {{ yandex-cloud }} {#cli}

Вызов функции с помощью CLI — это HTTPS-запрос с методом POST и параметром `?integration=raw` (без преобразования запроса в JSON-структуру и без проверки ответа).

Посмотрите справку о команде вызова функции: 

```
yc serverless function invoke --help
Invoke the specified function

Usage:
  yc serverless function invoke <FUNCTION-NAME>|<FUNCTION-ID> [Flags...] [Global Flags...]

Flags:
      --id string          Function id.
      --name string        Function name.
      --tag string         Tag. Default $latest.
  -d, --data string        Data to be sent
      --data-file string   Data (file location) to be sent
      --data-stdin         Await stdin for data to be sent
```

Подробное описание способов передачи данных с использованием разных флагов и аргументов:

- Флаг или аргумент не указан — передается пустая строка.

- `-d, --data` — данные передаются как аргумент.

    ```
    yc serverless function invoke <ID функции> -d '{"queryStringParameters": {"parameter_name": "parameter_value"}}'
    ```

- `--data-file` — данные читаются из файла.

    ```
    yc serverless function invoke <ID функции> --data-file <путь к файлу>
    ```

    Аналогично команде с аргументом `-d`, имеющим значение `@<имя файла>`: `yc serverless function invoke <идентификатор_функции> -d @<путь к файлу>`

- `--data-stdin` — данные читаются из потока ввода. 

     ```
     echo '{"queryStringParameters": {"parameter_name": "parameter_value"}}' | yc serverless function invoke <ID функции> --data-stdin
     ```

    Аналогично команде с аргументом `-d`, имеющим значение `@-`: 
    
    ```
    echo '{"queryStringParameters": {"parameter_name": "parameter_value"}}' | yc serverless function invoke <ID функции> -d @-`.
    ```

## Вызов функции с помощью триггера {#trigger}

При вызове функции с помощью триггера JSON-описание события триггера передается в теле HTTP-запроса к функции. IP-адрес источника запроса передается так же, как и при [вызове функции через HTTPS](#ip). Подробнее о [триггерах](trigger/index.md).

### Примеры использования {#examples-trigger}

* [{#T}](../tutorials/data-recording.md)
* [{#T}](../tutorials/events-from-postbox-to-yds.md)
* [{#T}](../tutorials/logging-functions.md)
* [{#T}](../tutorials/logging.md)
* [{#T}](../tutorials/regular-launch-datasphere.md)
* [{#T}](../tutorials/serverless-trigger-budget-vm.md)
* [{#T}](../tutorials/video-converting-queue.md)

## Вызов функции с помощью расширения {{ api-gw-full-name }} {#extension}

При вызове функции с помощью расширения {{ api-gw-name }} функция получает HTTP-запрос, адресованный к API-шлюзу. В заголовке `Host` при этом указывается хост, по которому пользователь обратился к API-шлюзу, а не хост функции. IP-адрес источника запроса передается так же, как и при [вызове функции через HTTPS](#ip). Подробнее о расширении в [документации {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/cloud-functions.md).

### Примеры использования {#examples-api-gw}

* [{#T}](../tutorials/canary-release.md)
* [{#T}](../tutorials/java-servlet-todo-list.md)
* [{#T}](../tutorials/serverless-url-shortener.md)
* [{#T}](../tutorials/slack-bot-serverless.md)
* [{#T}](../tutorials/telegram-bot-serverless.md)
* [{#T}](../tutorials/websocket-app.md)

## Вызов функции с помощью событий в {{ monitoring-short-name }} {#monitoring}

Для автоматической обработки инцидентов и других событий можно интегрировать функции {{ sf-name }} в сервис {{ monitoring-full-name }}. Для этого потребуется добавить функцию в [канал уведомлений](../../monitoring/operations/alert/create-channel-function.md). Вызывать функцию {{ sf-name }} можно при срабатывании [алерта](../../monitoring/concepts/alerting/alert.md) или в [эскалации](../../monitoring/concepts/alerting/escalations.md) {{ monitoring-short-name }}.

Вызов функции должен выполняться в [асинхронном режиме](../concepts/function-invoke-async.md).

Пример функции для вызова внешнего API при срабатывании алерта см. в разделе [{#T}](../../monitoring/operations/alert/create-channel-function.md).
