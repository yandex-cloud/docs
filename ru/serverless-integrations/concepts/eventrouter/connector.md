---
title: Коннектор {{ er-full-name }}
description: Коннектор {{ er-name }} — настраиваемый компонент, позволяющий получать события из внешних источников.
keywords:
  - eventrouter
  - event router
  - шина
  - коннектор
  - Источник
  - Источник событий
  - Event Source
---

# Коннектор

_Коннектор_ — настраиваемый компонент, позволяющий получать события из внешних источников и отправлять их в [шину](bus.md).

Поддерживаемые источники:

* [Таймер](#timer)
* [API {{ er-name }}](#from-api)
* [{{ yds-full-name }}](../../../data-streams/index.yaml)
* [{{ message-queue-full-name }}](../../../message-queue/index.yaml)


## Таймер {#timer}

Таймер — тип источника, который запускает генерацию событий по расписанию. Расписание задается в формате cron-выражения. По умолчанию время в cron-выражении указывается по [UTC+0](https://ru.wikipedia.org/wiki/Всемирное_координированное_время), но в настройках таймера можно указать другой часовой пояс.

Если в настройках таймера не указаны данные, которые нужно передать в шину, на вход [приемника](./rule.md#target), указанного в [правиле](./rule.md), ничего не передается.

Подробнее о формате cron-выражений см. [{#T}](../cron.md)


## API {{ er-name }} {#from-api}

API {{ er-name }} — тип источника, который позволяет использовать [API {{ er-name }}](../../api-ref/eventrouter/authentication.md) для [отправки](./sending-events.md) пользовательских событий в шину.

Чтобы отправлять события [через коннектор](../../operations/eventrouter/bus/data-send.md) для API {{ er-name }}, используйте [вызов](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) gRPC API `EventService/Send` или [команду](../../../cli/cli-ref/serverless/cli-ref/eventrouter/send-event.md) {{ yandex-cloud }} CLI `yc serverless eventrouter send-event`.

В отличие от отправки сообщений [напрямую в шину](../../operations/eventrouter/bus/data-put.md), использование коннектора для API {{ er-name }} позволяет:
* назначать пользователям и [сервисным аккаунтам](../../../iam/concepts/users/service-accounts.md) роли на отправку событий гранулярно через заданный коннектор;
* прекращать отправку событий, [останавливая](../../operations/eventrouter/connector/stop.md) коннектор;
* группировать события перед отправкой в шину.
