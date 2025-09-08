---
title: Интеграционный шаг FoundationModelsCall
description: В статье описаны поля для интеграционного шага FoundationModelsCall.
---

# FoundationModelsCall

Интеграция с [{{ foundation-models-full-name }}](../../../../../foundation-models/). На данный момент поддерживается только интеграция с [{{ yagpt-full-name }}](../../../../../foundation-models/concepts/generation/index.md) для генерации текста.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Да | Нет | Нет | Идентификатор вызываемой модели.
`generate` | [FoundationModelsCallGenerate](#FoundationModelsCallGenerate) | Да | Нет | Нет | Конфигурация действия `generate` — генерация текста.

## Объект FoundationModelsCallGenerate {#FoundationModelsCallGenerate}

Поля `json` и `messages` — взаимоисключающие, можно указать или JSON-строку, или явно перечислить сообщения.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`temperature` | `double` | Нет | `0` | Нет | Чем выше температура, тем более креативными и случайными будут ответы модели. Принимает значения от 0 (включительно) до 1 (включительно). 
`maxTokens` | `int64` | Да | Нет | Нет | Максимальное число токенов генерации. Позволит ограничить ответ модели, если это необходимо.
`json` | `string` | Нет | `""` | Да | Контекст для модели в виде JSON-строки. Подробнее см. описание поля `messages` в [документации {{ foundation-models-name }}](../../../../../foundation-models/operations/generation/create-prompt.md#request).
`messages` | [FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage)[] | Нет | `""` | Нет | Контекст для модели в виде явного перечисления входных сообщений.

## Объект FoundationModelsCallGenerateMessage {#FoundationModelsCallGenerateMessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`role` | `string` | Да | Нет | Да | Идентификатор отправителя сообщения. Подробнее см. [TextGeneration.completion](../../../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).
`text` | `string` | Да | Нет | Да | Текст сообщения. Подробнее см. [TextGeneration.completion](../../../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).