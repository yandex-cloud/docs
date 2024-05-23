# История изменений в {{ api-gw-full-name }}

## Апрель 2024 {#april-2024}

### Обновления {#updates}

* В расширение [x-yc-apigateway-authorizer:jwt](concepts/extensions/jwt-authorizer.md) добавлены:
    * альтернативное название параметра `scopes` — `scp`.
    * возможность указать массив в качестве типа данных одного из объектов `scopes`/`scp`.
* Добавлена поддержка автоматической отправки результата вызова интеграции в [WebSocket-соединение](concepts/extensions/websocket.md) при выполнении операции `x-yc-apigateway-websocket-connect`.

### Исправления и улучшения {#fixes-improvements}

* Удалено требование для [пользовательской сети](concepts/networking#user-network) иметь подсеть в зоне доступности `ru-central1-c` в связи с [выводом этой зоны из эксплуатации](../overview/concepts/ru-central1-c-deprecation).

## Март 2024 {#march-2024}

### Обновления {#updates}

* Добавлен параметр `default_object` в расширение спецификации OpenAPI для [интеграции с {{ objstorage-full-name }}](concepts/extensions/object-storage.md).
* Добавлена поддержка подстановки параметров в `error_object` и `default_object` в расширении спецификации OpenAPI для интеграции с {{ objstorage-full-name }}.
* Добавлена поддержка передачи заголовков `Via` и `Www-Authenticate` из ответа интеграций.
* Добавлена поддержка автоматической отправки в веб-сокет ответа интеграции в [операции](concepts/extensions/websocket.md#connect) `x-yc-apigateway-websocket-connect`.

## Январь–Февраль 2024 {#jan-feb-2024}

### Обновления {#updates}

* Добавлена поддержка настроек логирования для API-шлюза в {{ TF }}.
* Добавлена передача контекста авторизации в интеграции [Обращение по HTTP](concepts/extensions/http.md).
* Добавлено дополнительное сообщение в ответ от API-шлюза при ошибке валидации ответа от [функции {{ sf-name }}, которая используется для авторизации HTTP-запроса](concepts/extensions/function-authorizer.md).

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка валидации названий переменных в спецификации API-шлюза.
* Исправлена ошибка передачи массива значений query-параметров в интеграции [Обращение по HTTP](concepts/extensions/http.md).
* Уменьшено время ответа API-шлюза при большом RPS.
