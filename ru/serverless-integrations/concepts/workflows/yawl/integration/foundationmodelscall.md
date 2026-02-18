---
title: Интеграционный шаг FoundationModelsCall
description: В статье описаны поля для интеграционного шага FoundationModelsCall.
---

# FoundationModelsCall

Интеграция с [{{ foundation-models-full-name }}](../../../../../ai-studio/).

Поля `generate`, `classify`, `fewShotClassify` и `vision` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Да | Нет | Нет | Идентификатор вызываемой модели.
`generate` | [FoundationModelsGenerate](#FoundationModelsGenerate) | Нет | Нет | Нет | Конфигурация действия `generate` — генерации текста.
`classify` | [FoundationModelsClassify](#FoundationModelsClassify) | Нет | Нет | Нет | Конфигурация действия `classify` — дообученной классификации.
`fewShotClassify` | [FoundationModelsFewShotClassify](#FoundationModelsFewShotClassify) | Нет | Нет | Нет | Конфигурация действия `fewShotClassify` — классификации по промпту.
`vision` | [FoundationModelsVision](#FoundationModelsVision) | Нет | Нет | Нет | Конфигурация действия `vision` — работы с изображениями.

## Объект FoundationModelsGenerate {#FoundationModelsGenerate}

Поля `json` и `messages` — взаимоисключающие, можно использовать только одно из них. Поля `jsonSchema` и `jsonObject` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`temperature` | `number` | Да | `0.3` | Нет | Чем выше температура, тем более креативными и случайными будут ответы модели. Принимает значения от 0 (включительно) до 1 (включительно). 
`maxTokens` | `integer` | Да | `5.0` | Нет | Максимальное число токенов генерации. Позволит ограничить ответ модели, если это необходимо.
`json` | `string` | Нет | `""` | Да | Контекст для модели в виде JSON-строки. Подробнее см. описание поля `messages` в [документации {{ foundation-models-name }}](../../../../../ai-studio/operations/generation/create-prompt.md#request).
`messages` | [FoundationModelsGenerate.Messages[]](#FoundationModelsGenerateMessages) | Нет | `[]` | Нет | Контекст для модели в виде явного перечисления входных сообщений.
`reasoningOptions` | [FoundationModelsGenerate.ReasoningOptions](#FoundationModelsGenerateReasoningOptions) | Нет | Нет  | Нет | Режим рассуждений. Подробнее см. в [документации {{ foundation-models-name }}](../../../../../ai-studio/concepts/generation/chain-of-thought.md).
`jsonSchema` | `string` | Нет | Нет | Да | Ответ модели в виде JSON-схемы.
`jsonObject` | `boolean` | Нет | Нет | Нет | Если значение `true`, модель возвращает ответ в виде JSON-объекта. Иначе — ответ форматируется с помощью разметки Markdown. Подробнее см. в [документации {{ foundation-models-name }}](../../../../../ai-studio/concepts/generation/structured-output.md).

## Объект FoundationModelsGenerate.Messages {#FoundationModelsGenerateMessages}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`messages` | [FoundationModelsGenerate.Message](#FoundationModelsGenerateMessage) | Да | Нет | Да | Входные сообщения.

## Объект FoundationModelsGenerate.Message {#FoundationModelsGenerateMessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`role` | `string` | Да | Нет | Нет | Идентификатор отправителя сообщения. Доступные значения: `system`, `assistant`, и `user`. Подробнее см. [TextGeneration.completion](../../../../../ai-studio/text-generation/api-ref/TextGeneration/completion.md).
`text` | `string` | Да | Нет | Да | Текст сообщения. Подробнее см. [TextGeneration.completion](../../../../../ai-studio/text-generation/api-ref/TextGeneration/completion.md).

## Объект FoundationModelsGenerate.ReasoningOptions {#FoundationModelsGenerateReasoningOptions}

#|
|| **Имя поля** | **Тип** | **Обязательное** | **Значение по умолчанию** | **Поддерживается [шаблонизация](../../templating.md)** | **Описание** ||
|| `mode` | `string` | Да | `REASONING_MODE_UNSPECIFIED` | Нет | Возможные статусы режима рассуждений:
* `REASONING_MODE_UNSPECIFIED` — не задан;
* `DISABLED` — выключен;
* `ENABLED_HIDDEN` — включен. ||
|#

## Объект FoundationModelsClassify {#FoundationModelsClassify}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`text` | `string` | Да | Нет | Да | Текстовое описание сообщения.

## Объект FoundationModelsFewShotClassify {#FoundationModelsFewShotClassify}

Поля `labelsJson` и `labelsArray` — взаимоисключающие, можно использовать только одно из них. Поля `samplesJson` и `samplesArray` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`taskDescription` | `string` | Да | Нет | Да | Текстовое описание задания для классификатора.
`text`            | `string` | Да | Нет | Да | Текстовое описание сообщения.
`labelsJson`      | `string` | Нет | Нет | Да | Классы в виде JSON-объекта.
`labelsArray`     | [FoundationModelsFewShotClassify.Labels[]](#FoundationModelsFewShotClassifyLabels) | Нет | Нет | Нет | Классы в виде массива.
`samplesJson`     | `string` | Нет | Нет | Да | Примеры запросов в виде JSON-объекта.
`samplesArray`    | [FoundationModelsFewShotClassify.Samples[]](#FoundationModelsFewShotClassifySamples) | Нет | Нет | Нет | Примеры запросов в виде массива.

## Объект FoundationModelsFewShotClassify.Labels {#FoundationModelsFewShotClassifyLabels}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`labels` | `string` | Да | Нет | Да | Классы.

## Объект FoundationModelsFewShotClassify.Samples {#FoundationModelsFewShotClassifySamples}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`samples` | [FoundationModelsFewShotClassify.Sample](#FoundationModelsFewShotClassifySample) | Да | Нет | Нет | Примеры запросов.

## Объект FoundationModelsFewShotClassify.Sample {#FoundationModelsFewShotClassifySample}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`text` | `string` | Да | Нет | Да | Текстовое описание сообщения.
`label` | `string` | Да | Нет | Да | Класс.

## Объект FoundationModelsVision {#FoundationModelsVision}

Поля `json` и `messages` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`temperature` | `number` | Да | `0.3` | Нет | Чем выше температура, тем более креативными и случайными будут ответы модели. Принимает значения от 0 (включительно) до 1 (включительно). 
`maxTokens` | `integer` | Да | `5.0` | Нет | Максимальное число токенов генерации. Позволит ограничить ответ модели, если это необходимо.
`json` | `string` | Нет | `""` | Да | Контекст для модели в виде JSON-строки. Подробнее см. описание поля `messages` в [документации {{ foundation-models-name }}](../../../../../ai-studio/operations/generation/create-prompt.md#request).
`messages` | [FoundationModelsVision.Messages[]](#FoundationModelsVisionMessages) | Нет | `[]` | Нет | Контекст для модели в виде явного перечисления входных сообщений.

## Объект FoundationModelsVision.Messages {#FoundationModelsVisionMessages}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`messages` | [FoundationModelsVision.Message](#FoundationModelsVisionMessage) | Да | Нет | Да | Входные сообщения.

## Объект FoundationModelsVision.Message {#FoundationModelsVisionMessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`role` | `string` | Да | Нет | Нет | Идентификатор отправителя сообщения. Доступные значения: `system`, `assistant`, и `user`. Подробнее см. [TextGeneration.completion](../../../../../ai-studio/text-generation/api-ref/TextGeneration/completion.md). Если поле `images` не пустое, необходимо указать `role: user`.
`text` | `string` | Да | Нет | Да | Текст сообщения. Подробнее см. [TextGeneration.completion](../../../../../ai-studio/text-generation/api-ref/TextGeneration/completion.md).
`images` | [FoundationModelsVision.Image](#FoundationModelsVisionImage) | Нет | Нет | Нет | Изображения, которые будут добавлены в сообщение.

## FoundationModelsVision.Image {#FoundationModelsVisionImage}

Поля `base64` и `file` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`base64` | `string` | Нет | Нет | Да | Изображение в формате [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
`file` | [FoundationModelsVision.File](#FoundationModelsVisionFile) | Нет | Нет | Нет | Изображение из указанного источника.

## FoundationModelsVision.File {#FoundationModelsVisionFile}

Поля `url` и `objectStorage` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`url` | `string` | Нет | Нет | Да | Публичный URL, по которому доступно изображение.
`objectStorage` | [FoundationModelsVision.ObjectStorage](FoundationModelsVisionObjectStorage) | Нет | Нет | Нет | Изображение из [бакета](../../../../../storage/concepts/bucket.md) {{ objstorage-name }}.

## FoundationModelsVision.ObjectStorage {#FoundationModelsVisionObjectStorage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Да | Нет | Нет | Имя бакета {{ objstorage-name }}, в котором находится изображение.
`object` | `string` | Да | Нет | Да | Имя объекта с изображением (например, `prefix/subprefix/image.png`).
