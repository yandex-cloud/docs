---
title: История изменений в {{ api-gw-full-name }}
description: В разделе представлена история изменений сервиса {{ api-gw-name }}.
---

# История изменений в {{ api-gw-full-name }}

## Июнь 2025 {#june-2025}

### Исправления и улучшения {#fixes-improvements}

* Улучшена стабильность работы протокола WebSocket в {{ api-gw-full-name }}: исправлена некорректная обработка ping-событий, устранено зависание долгоживущих соединений, оптимизирована обработка событий.

## Май 2025 {#may-2025}

### Обновления {#updates}

* Добавлена поддержка [интеграции с {{ sw-full-name }}](operations/spec-constructor/workflows.md).

## Март 2025 {#march-2025}

### Обновления {#updates}

* Добавлена настройка таймаута обработки запроса.

## Февраль 2025 {#february-2025}

### Исправления и улучшения {#fixes-improvements}

* Добавлен вывод ошибок в логи работы API-шлюза при использовании [интеграции с {{ yds-full-name }}](concepts/extensions/datastreams.md).

## Январь 2025 {#january-2025}

### Обновления {#updates}

* Обновлен механизм распределения нагрузки:
    * Формат служебного домена API-шлюза изменился с `https://d5ds7sk1ahjl********.apigw.yandexcloud.net` на `{{ api-host-apigw }}` — новый формат содержит на один уровень больше.
    * Увеличилось количество внешних IP-адресов, которые обрабатывают запросы пользователей, — теперь у одного API-шлюза может быть несколько IP-адресов.

    Новый механизм позволяет сохранить стабильность сервиса при растущей нагрузке.

## Ноябрь 2024 {#november-2024}

### Обновления {#updates}

* Добавлена поддержка меток.

## Сентябрь — октябрь 2024 {#sept-oct-2024}

### Обновления {#updates}

* Добавлена поддержка [обработчика ошибок валидации](concepts/extensions/validator.md#errorhandler).

### Исправления и улучшения {#fixes-improvements}

* Улучшена форма для [интеграции с {{ foundation-models-full-name }}](operations/spec-constructor/yagpt.md) в конструкторе спецификаций.
* Обновлена [интеграция с {{ objstorage-full-name }}](operations/spec-constructor/object-storage.md): изменена логика управления кодом ответа, который возвращается, если в указанном бакете отсутствует запрашиваемый объект.

## Август 2024 {#august-2024}

### Обновления {#updates}

* Добавлена поддержка [интеграции с {{ yagpt-name }}](operations/spec-constructor/yagpt.md).
* Добавлена поддержка [интеграции с {{ sws-full-name }}](concepts/extensions/sws.md).
* Добавлена поддержка расширений:
    * `x-yc-status-mapping` — [замена кода ответа](concepts/extensions/status-mapping.md);
    * `x-yc-schema-mapping` — [преобразование тела ответа и запроса](concepts/extensions/schema-mapping.md).

## Июль 2024 {#july-2024}

### Обновления {#updates}

* Добавлена поддержка [триггеров](concepts/trigger/index.md), которые отправляют сообщения в WebSocket-соединения.

### Исправления и улучшения {#fixes-improvements}

* Исправлены ошибки при [выборе обработчика](concepts/index.md#algorithm) в OpenAPI-спецификации.

## Май — июнь 2024 {#may-june-2024}

### Обновления {#updates}

* Добавлена поддержка [конструктора спецификаций](operations/spec-constructor/index.md).

## Апрель 2024 {#april-2024}

### Обновления {#updates}

* В расширение [x-yc-apigateway-authorizer:jwt](concepts/extensions/jwt-authorizer.md) добавлены:
    * альтернативное название параметра `scopes` — `scp`.
    * возможность указать массив в качестве типа данных одного из объектов `scopes`/`scp`.
* Добавлена поддержка автоматической отправки результата вызова интеграции в [WebSocket-соединение](concepts/extensions/websocket.md) при выполнении операции `x-yc-apigateway-websocket-connect`.

### Исправления и улучшения {#fixes-improvements}

* Удалено требование для [пользовательской сети](concepts/networking#user-network) иметь подсеть в зоне доступности `ru-central1-c` в связи с [выводом этой зоны из эксплуатации](../overview/concepts/region.md).

## Март 2024 {#march-2024}

### Обновления {#updates}

* Добавлен параметр `default_object` в расширение спецификации OpenAPI для [интеграции с {{ objstorage-full-name }}](concepts/extensions/object-storage.md).
* Добавлена поддержка подстановки параметров в `error_object` и `default_object` в расширении спецификации OpenAPI для интеграции с {{ objstorage-full-name }}.
* Добавлена поддержка передачи заголовков `Via` и `Www-Authenticate` из ответа интеграций.
* Добавлена поддержка автоматической отправки в веб-сокет ответа интеграции в [операции](concepts/extensions/websocket.md#connect) `x-yc-apigateway-websocket-connect`.

## Январь — февраль 2024 {#jan-feb-2024}

### Обновления {#updates}

* Добавлена поддержка настроек логирования для API-шлюза в {{ TF }}.
* Добавлена передача контекста авторизации в интеграции [Обращение по HTTP](concepts/extensions/http.md).
* Добавлено дополнительное сообщение в ответ от API-шлюза при ошибке валидации ответа от [функции {{ sf-name }}, которая используется для авторизации HTTP-запроса](concepts/extensions/function-authorizer.md).

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка валидации названий переменных в спецификации API-шлюза.
* Исправлена ошибка передачи массива значений query-параметров в интеграции [Обращение по HTTP](concepts/extensions/http.md).
* Уменьшено время ответа API-шлюза при большом RPS.
