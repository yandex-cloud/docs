---
title: Отправка событий в шину {{ er-full-name }}
description: В разделе описаны способы отправки событий в шину {{ er-name }} напрямую и с помощью коннекторов.
keywords:
  - eventrouter
  - event router
  - шина
  - Bus
  - Event Bus
  - шина событий
  - коннектор
  - правило
---

# Отправка событий в шину

События могут отправляться в [шину](./bus.md) следующими способами:

Способ отправки в шину  | Способ формирования событий  | Группирование сообщений
--- | --- | ---
[Отправка](../../operations/eventrouter/bus/data-put.md) напрямую с помощью метода API [put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) | Пользователь самостоятельно подготавливает отправляемые события | Нет
Отправка через [коннектор](../../concepts/eventrouter/connector.md) с типом источника `Таймер` | Пользователь указывает данные, которые будут передаваться в шину, в настройках коннектора | Нет
[Отправка](../../operations/eventrouter/bus/data-send.md) через коннектор с типом источника `API {{ er-name }}` с помощью метода API [send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) | Пользователь самостоятельно подготавливает отправляемые события | Да
Отправка через коннектор с типом источника `{{ yds-full-name }}` | События поступают из [потока данных](../../../data-streams/concepts/glossary.md#stream-concepts) | Нет
Отправка через коннектор с типом источника `{{ message-queue-full-name }}` | События поступают из [очереди сообщений](../../../message-queue/concepts/queue.md) | Да

## См. также {#see-also}

* [{#T}](../../operations/eventrouter/bus/data-put.md)
* [{#T}](../../operations/eventrouter/bus/data-send.md)
