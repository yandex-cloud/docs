---
title: Интеграционный шаг ContainerCall
description: В статье описаны поля для интеграционного шага ContainerCall.
---

# ContainerCall

Вызов контейнера [{{ serverless-containers-full-name }}](../../../../../serverless-containers/).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`containerId` | `string` | Да | Нет | Нет | Идентификатор контейнера.
`path` | `string` | Нет | `""` | Да | Путь запроса.
`method` | `enum` | Нет | `GET` | Да | HTTP-метод запроса.
`body` | `string` | Нет | `""` | Да | Тело запроса.
`headers` | `map<string, string>` | Нет | `{}` | Да — в значениях заголовков | Заголовки запроса.
`query` | `map<string, string>` | Нет | `{}` | Да — в значениях query-параметров | Query-параметры запроса.