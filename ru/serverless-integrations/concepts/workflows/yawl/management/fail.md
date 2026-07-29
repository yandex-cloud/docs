---
title: Управляющий шаг Fail
description: Описание управляющего шага Fail.
---

# Fail

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Завершает запуск рабочего процесса с ошибкой. Если находится внутри [Foreach](foreach.md) или [Parallel](parallel.md), завершает весь запуск, а не только текущую ветку выполнения.

Имя поля | Тип | Обязательное | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | ---
`errorMessage` | `string` | Да | Да | Сообщение об ошибке.
