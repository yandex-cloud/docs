---
title: Триггер для {{ yds-full-name }}, который вызывает функцию {{ sf-full-name }}
description: Из статьи вы узнаете, что такое триггер для {{ yds-name }}, который вызывает функцию {{ sf-name }}, необходимых ролях для работы триггера и формате отправляемых сообщений.
---

# Триггер для {{ yds-name }}, который вызывает функцию {{ sf-name }}

 [Триггер](../trigger/) для {{ yds-name }} запускает [функцию](../function.md) {{ sf-name }} при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts). 

Триггеру для {{ yds-name }} необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для управления потоком и вызова функции. Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

О том, как создать триггер для {{ yds-name }}, читайте в инструкции [{#T}](../../operations/trigger/data-streams-trigger-create.md).

{% include [batching-messages](../../../_includes/functions/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для {{ yds-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли:
    * `{{ roles-functions-invoker }}` на функцию, которую вызывает триггер;
    * `yds.admin` на поток, при отправке данных в который вызывается триггер.

## Формат сообщения от триггера для {{ yds-name }} {#format}

{% include [trigger-message-format-note](../../../_includes/functions/trigger-message-format-note.md) %}

После того как триггер сработает, он отправит в функцию сообщение с массивом `messages`:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/events-from-postbox-to-yds.md)

## См. также {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/data-streams-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/data-streams-trigger.md)
