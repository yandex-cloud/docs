---
title: Обработка ошибок в API {{ yandex-cloud }}
description: Из статьи вы узнаете, как обрабатываются ошибки в API {{ yandex-cloud }}.
alternate:
  - href: ru/api-design-guide/concepts/errors.md
    type: text/markdown
    title: Markdown version
---

# Обработка ошибок в API {{ yandex-cloud }}

Если операция завершилась успешно, сервер возвращает клиенту статус OK. Если в ходе выполнения операции возникла ошибка, сервер возвращает сообщение с описанием ошибки.

{% include [errors-handling](../../_includes/errors-handling.md) %}

## Обработка ошибок в асинхронных вызовах {#async-errors}

При вызове асинхронных операций сервер возвращает объект [Operation](operation.md). В случае возникновения ошибки, сообщение `Status` будет добавлено в объект `Operation` в поле `error`.
