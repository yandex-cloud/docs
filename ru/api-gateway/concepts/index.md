---
title: "Взаимосвязь ресурсов сервиса {{ api-gw-full-name }}"
description: "API-шлюз — это интерфейс взаимодействия с сервисами внутри {{ yandex-cloud }} или в интернете. API-шлюз задается декларативно при помощи спецификации. Спецификация — это файл в формате JSON или YAML с описанием API-шлюза по стандарту OpenAPI 3.0. В сервисе {{ api-gw-name }} спецификация дополнена расширениями, которые вы можете использовать для интеграции с другими облачными платформами."
---

# Взаимосвязь ресурсов в {{ api-gw-name }}

_API-шлюз_ — это интерфейс взаимодействия с сервисами внутри {{ yandex-cloud }} или в интернете.

API-шлюз задается декларативно при помощи спецификации. Спецификация — это файл в формате JSON или YAML с описанием API-шлюза по стандарту  [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification). В сервисе {{ api-gw-name}} спецификация дополнена расширениями, которые вы можете использовать для интеграции с другими облачными платформами.

Доступные расширения:
* [Статический ответ](../concepts/extensions/dummy.md).
* [Вызов функции](../concepts/extensions/cloud-functions.md).
* [Обращение по HTTP](../concepts/extensions/http.md).
* [Интеграция с {{ objstorage-name }}](../concepts/extensions/object-storage.md).
* [Интеграция с {{ ml-platform-name }}](../concepts/extensions/datasphere.md).
* [Интеграция с {{ yds-name }}](../concepts/extensions/datastreams.md).
* [Интеграция с {{ serverless-containers-name }}](../concepts/extensions/containers.md).
* [Интеграция с {{ message-queue-short-name }}](../concepts/extensions/ymq.md).
* [Интеграция с {{ ydb-short-name }}](../concepts/extensions/ydb.md).
* [Жадные параметры](../concepts/extensions/greedy-parameters.md).
* [Обобщенный HTTP-метод](../concepts/extensions/any-method.md).

## Использование доменов {#domains}

Сервис {{ api-gw-short-name }} интегрирован с системой управления доменами сервиса {{ certificate-manager-short-name }}. 

Вы можете использовать домены с подтвержденными правами при обращении к API. При этом для обеспечения TLS-соединения будет использован привязанный к домену сертификат.

Подробнее о доменах читайте в разделе [{#T}](../../certificate-manager/concepts/domains/services.md).

## Авторизация {#authorization}

{{ api-gw-short-name }} позволяет реализовать стандартные [механизмы аутентификации и авторизации](https://swagger.io/docs/specification/authentication/), которые предусмотрены спецификацией [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification). На данный момент доступна [авторизация с помощью функции](../concepts/extensions/function-authorizer.md).

## WebSocket {#websocket}

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

Для организации асинхронного двунаправленного взаимодействия между клиентами и API-шлюзом сервис {{ api-gw-short-name }} поддерживает протокол [WebSocket](https://en.wikipedia.org/wiki/WebSocket). Клиенты могут отправлять сообщения в API-шлюз, который в свою очередь может независимо отправлять сообщения клиентским приложениям. Такая возможность позволяет клиентам получать данные без необходимости делать HTTP-запрос. Веб-сокеты часто используются в приложениях, требующих обновления данных в режиме реального времени, таких как мессенджеры и онлайн-чаты, многопользовательские игры, платформы для совместной работы, а также приложения финансового рынка и спортивные онлайн-площадки.

Чтобы подключиться к API-шлюзу по протоколу WebSocket, можно использовать служебный домен, выделяемый при создании API-шлюза, или любой другой, добавленный к API-шлюзу.

Доступны интеграции на следующие события:
* открытие соединения;
* отправка сообщений через веб-сокет;
* закрытие соединения.

Для настройки интеграций предусмотрены [специальные расширения](extensions/websocket.md) OpenAPI-спецификации.

Управлять веб-сокетами можно с помощью [API](../api-ref/websocket/authentication.md), который позволяет получить информацию о соединении, отправить данные на клиентскую сторону и закрыть соединение.

Ограничения, связанные с поддержкой протокола WebSocket, описаны в разделе [Квоты и лимиты](../concepts/limits.md).

[Пример serverless-приложения с использованием протокола WebSocket](http://github.com/yandex-cloud-examples/yc-serverless-serverless-game).
 
#### См. также {#see-also}

* [Обзор доступных расширений](extensions/index.md).