---
title: Триггер для {{ yds-full-name }}, который отправляет сообщения в WebSocket-соединения
description: Из статьи вы узнаете о триггере для {{ yds-name }}, формате отправляемых сообщений и необходимых ролях для работы с триггером.
---

# Триггер для {{ yds-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](../trigger/) для {{ yds-name }} отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md) при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts).

Триггеру для {{ yds-name }} необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для управления потоком и отправки сообщений в WebSocket-соединения. Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

О том, как создать триггер для {{ yds-name }}, читайте в инструкции [{#T}](../../operations/trigger/data-streams-trigger-create.md).

## Роли, необходимые для корректной работы триггера для {{ yds-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли:
    * `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз;
    * `yds.admin` на поток, при отправке данных в который вызывается триггер.

## Формат сообщения от триггера для {{ yds-name }} {#format}

После того как триггер сработает, он отправит в WebSocket-соединения сообщение. Формат сообщения зависит от источника и представляет собой массив `messages`:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}

## См. также {#see-also}

* [Триггер для {{ yds-name }}, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/data-streams-trigger.md)
* [Триггер для {{ yds-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/data-streams-trigger.md)
