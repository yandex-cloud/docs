---
title: '{{ assistant-api }}'
description: '{{ assistant-api }} — это инструмент создания AI-ассистентов.'
---

# {{ assistant-api }}

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} — это инструмент создания AI-ассистентов. С его помощью можно создать персонализированных помощников, реализовывать сценарий генеративного ответа с учетом информации из внешних источников (RAG, Retrieval Augmented Generation), а также сохранять контекст запросов к модели.

![ai-assistant](../../../_assets/foundation-models/ai-assistant.svg)

Вы можете создать своего AI-ассистента с помощью [{{ ml-sdk-full-name }}](../../sdk/index.md) или реализуя запросы к API на языке программирования.

Чтобы использовать {{ assistant-api }} в {{ foundation-models-full-name }}, необходимы [роли](../../security/index.md#service-roles) `ai.assistants.editor` и `ai.languageModels.user` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

## Из чего состоят AI-ассистенты {#content}

{{ assistant-api }} предоставляет несколько абстракций для реализации чат-ботов и AI-ассистентов. 

[_Ассистент_](../../assistants/api-ref/grpc/Assistant/index.md) определяет, к какой модели нужно обратиться, а также какие параметры и инструкции использовать. Это позволяет настроить модель один раз и использовать эти настройки в будущем без необходимости каждый раз передавать их.

Для хранения контекста истории общения используются [_треды_](../../threads/api-ref/grpc/index.md). Каждый тред — это отдельный диалог с пользователем. [_Запустив_](../../runs/api-ref/grpc/index.md) ассистента для треда, вы вызовете модель и передадите весь сохраненный в нем контекст. Промежуточные результаты генерации можно получить, [прослушивая](../../runs/api-ref/grpc/Run/listen.md) текущий запуск, а итоговый результат генерации будет добавлен к треду. 

{% note tip %}

По умолчанию при каждом запуске модель будет обрабатывать содержимое треда заново. Если в треде хранится большой контекст, а вы запускаете ассистента после каждого сообщения от пользователя, стоимость работы ассистента может стать существенной. Чтобы оптимизировать расходы, попробуйте ограничить размер передаваемого контекста с помощью параметра [`customPromptTruncationOptions`](../../runs/api-ref/grpc/Run/create.md) при запуске.

Подробнее о стоимости использования ассистентов см. [Правила тарификации ассистентов](../../pricing.md#rules-assistant).

{% endnote %}

### Работа с внешними источниками информации {#files}

Чтобы модель использовала внешние источники информации для ответов на запросы, вы можете загрузить файлы с дополнительной информацией с помощью [Files API](../../files/api-ref/grpc/index.md) и создать для них [_поисковый индекс_](../../searchindex/api-ref/grpc/SearchIndex/create.md). Загрузить можно до 1 000 файлов, максимальный размер каждого файла — 128 МБ. Один и тот же файл может содержаться в нескольких поисковых индексах сразу. На текущий момент поисковый индекс может содержать до 100 файлов.

Со всеми ограничениями {{ assistant-api }} можно ознакомиться в разделе [{#T}](../limits.md).

Для загрузки поддерживаются следующие [MIME-типы](https://en.wikipedia.org/wiki/Media_type): 

* `application/json`
* `application/msword`
* `application/pdf`
* `application/vnd.ms-excel`
* `application/vnd.ms-excel.sheet.2`
* `application/vnd.ms-excel.sheet.3`
* `application/vnd.ms-excel.sheet.4`
* `application/vnd.ms-excel.workspace.3`
* `application/vnd.ms-excel.workspace.4`
* `application/vnd.ms-outlook`
* `application/vnd.ms-powerpoint`
* `application/vnd.ms-project`
* `application/vnd.ms-word2006ml`
* `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`
* `application/vnd.openxmlformats-officedocument.wordprocessingml.document`
* `application/x-latex`
* `application/x-ms-owner`
* `application/xhtml+xml`
* `text/csv`
* `text/html`
* `text/markdown`
* `text/plain`
* `text/xml`
* `application/rtf`

{% note info %}

Время хранения загруженных файлов и поисковых индексов ограничено. Вы можете настроить его при загрузке файла с помощью параметра [ExpirationConfig](../../files/api-ref/grpc/File/create.md#yandex.cloud.ai.common.ExpirationConfig). По умолчанию файлы будут удалены, если в течение 7 дней они не используются.

{% endnote %}

При создании поискового индекса вы задаете тип поиска, для которого индекс будет использоваться. Поддерживаются полнотекстовый и векторный типы поиска. Скорость индексирования зависит от типа файлов, их размера и загрузки системы и может занять от нескольких секунд до нескольких часов. Индексация файлов выполняется [асинхронно](../index.md#working-mode). В ответ на запрос создания поискового индекса сервис вернет объект [Operation](../../../api-design-guide/concepts/async.md). По нему вы можете узнать статус операции создания поискового индекса.

Созданный поисковый индекс можно подключить к ассистенту. Тогда при запуске модель будет учитывать содержимое поискового индекса и отвечать, используя в первую очередь информацию из него. 

#### См. также {#see-also}

* [{#T}](../../operations/assistant/create.md)
* [{#T}](../../operations/assistant/create-with-searchindex.md)