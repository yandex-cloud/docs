---
title: Создать RAG-ассистента для поиска с указанием метаданных файлов и индексов
description: Следуя этой инструкции, с помощью {{ assistant-api }} вы сможете создать персонализированного ассистента, учитывающего информацию из внешних источников, для которых заданы метаданные на уровне файлов и индексов.
---

# Создать AI-ассистента для RAG с сохранением метаданных исходных файлов и индексов

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} — это функциональность {{ foundation-models-name }} для создания [AI-ассистентов](../../concepts/assistant/index.md). С его помощью можно создать персонализированных помощников, реализовывать сценарий генеративного ответа с учетом информации из внешних источников ([RAG](https://ru.wikipedia.org/wiki/Генерация,_дополненная_поиском), Retrieval Augmented Generation), присваивая файлам-источникам и поисковым индексам наборы [метаданных](../../concepts/assistant/index.md#labels), которые позволят более эффективно ориентироваться во внешних источниках.

Получать информацию из базы знаний AI-ассистентам позволяет [инструмент](../../concepts/assistant/tools/vector-store.md) VectorStore.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Создайте ассистента {#create-assistant}

{% list tabs group=programming_language %}

- SDK {#sdk}

  Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который для ответов использует информацию из файлов. В примере будет создан индекс для векторного поиска и реализован простейший вариант чата. Поисковому индексу и файлам-источникам будет присвоен набор метаданных, содержащий обобщенную информацию о них.

  1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}
  1. Создайте файл `search-assistant.py` и добавьте в него следующий код:

      {% include [searchindex-assistant-labels](../../../_includes/foundation-models/examples/searchindex-assistant-labels.md) %}

      Где:

      * `mypath` — переменная, содержащая путь к директории, в которой сохранены скачанные ранее файлы. Например: `/Users/myuser/tours-example/`.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 search-assistant.py
      ```

      В примере реализован простейший вариант чата: вводите с клавиатуры запросы ассистенту и получайте ответы на них. Чтобы прекратить диалог, введите `exit`.

      {% cut "Примерный результат выполнения" %}

      {% include [assistant-labels-output](../../../_untranslatable/foundation-models/assistant-labels-output.md) %}

      {% endcut %}

      В свойстве `run.text` AI-ассистент вернул ответ модели, который был сгенерирован с использованием загруженной базы знаний. Свойство `run.citations` содержит [ссылки на источники](../../concepts/assistant/index.md#citations) — информацию об использованных при генерации ответа файлах базы знаний и поисковых индексах, в том числе, [метаданные](../../concepts/assistant/index.md#labels) файлов-источников (свойство `citation.sources.file.labels`) и индексов (свойство `citation.sources.search_index.labels`).

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* [{#T}](./create-with-websearch.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)