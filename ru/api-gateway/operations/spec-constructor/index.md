---
title: "Инструкции по работе с конструктором спецификаций {{ api-gw-full-name }}"
description: "Из статьи вы узнаете, как работать с конструктором спецификаций {{ api-gw-full-name }} в {{ yandex-cloud }}. Вы научитесь добавлять расширения в спецификацию с помощью конструктора."
---

# Обзор конструктора спецификаций

Для работы с [интеграциями](../../concepts/extensions/index.md#integration) {{ api-gw-name }} можно использовать конструктор спецификаций. Чтобы добавить расширение `x-yc-apigateway-integration` в OpenAPI-спецификацию с помощью конструктора, заполните форму в консоли управления при [создании](../api-gw-create.md) или [изменении](../api-gw-update.md) API-шлюза.

Доступные интеграции:

* [{{ sf-name }}](cloud-functions.md)
* [Статический ответ](dummy.md)
* [{{ objstorage-name }}](object-storage.md)
* [{{ serverless-containers-name }}](containers.md)
* [Обращение по HTTP](http.md)
* [{{ message-queue-name }}](ymq.md)
* [{{ yds-name }}](datastreams.md)
* [{{ ydb-name }}](ydb.md)
* [{{ ml-platform-name }}](datasphere.md)
* [{{ yagpt-full-name }}](yagpt.md)