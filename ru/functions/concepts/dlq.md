---
title: Dead Letter Queue в {{ sf-name }}
description: Dead Letter Queue (DLQ) — это очередь, куда перенаправляются сообщения, которые не смогли обработать вызываемые триггером функцию или контейнер. Сообщение считается обработанным, если функция или контейнер, которые его получили, завершились без ошибок. Перенаправленные в DLQ сообщения хранятся в ней для дальнейшей диагностики.
---

# Dead Letter Queue в {{ sf-name }}

_Dead Letter Queue (DLQ)_ — это [очередь](../../message-queue/concepts/queue.md), куда перенаправляются сообщения, которые не смогла обработать вызываемая триггером [функция](./function.md) {{ sf-name }}. Сообщение считается обработанным, если функция, которая его получила, завершилась без ошибок. Перенаправленные в DLQ сообщения хранятся в ней для дальнейшей диагностики.

Если функция не обработала сообщение за заданное количество попыток, оно перенаправляется в DLQ. Количество попыток вызова функции и очередь, которая будет использоваться в качестве DLQ, определяются политикой перенаправления. DLQ в {{ sf-name }} может быть только [стандартной очередью](../../message-queue/concepts/queue.md#standard-queues).

Если политика перенаправления не настроена, необработанные функцией сообщения удаляются.

## Политика перенаправления {#redrive-policy}

Условия перенаправления сообщений в DLQ задаются политикой перенаправления.

Чтобы настроить политику перенаправления для всех триггеров, кроме триггера для {{ message-queue-full-name }}, при создании триггера необходимо указать:

* очередь, куда будут перенаправляться сообщения;
* [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с правами на запись в очередь;
* время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно;
* количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в очередь.

[Политика перенаправления](../../message-queue/concepts/dlq.md#redrive-policy) для триггера для {{ message-queue-full-name }} настраивается при создании очереди, сообщения из которой обрабатывает вызываемая триггером функция.

При перемещении в DLQ сообщение сохраняет свой идентификатор.

## Примеры использования {#examples}

* [{#T}](../tutorials/datalens.md)
* [{#T}](../tutorials/monitoring.md)