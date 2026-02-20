---
title: Правила тарификации для {{ foundation-models-full-name }}
description: В статье содержатся правила тарификации сервиса {{ foundation-models-name }}.
editable: false
---

# Правила тарификации для {{ foundation-models-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### {{ model-gallery-name }} {#rules-model-gallery}

{% note warning %}

Описанные ниже правила тарификации и цены на модели базового инстанса и пакетную обработку данных действуют до 3 марта 2026 года. С 3 марта будут действовать [новые правила тарификации](#rules-new) и новые цены. 

{% endnote %}

Стоимость работы с моделями {{ model-gallery-name }} зависит от:
* [режима работы модели](concepts/generation/index.md#working-mode);
* количества входящих и исходящих [токенов](concepts/generation/tokens.md). Число [токенов](concepts/generation/tokens.md) в одном и том же тексте для разных моделей может отличаться. [Пример расчета](#example-generating) стоимости обработки одного и того же текста в синхронном режиме с помощью разных моделей.

Использование моделей {{ model-gallery-name }} [детализируется в {{ billing-name }}](../billing/operations/check-charges.md) в единицах тарификации — _юнитах_. Итоговое количество потребленных юнитов округляется до целого значения в большую сторону.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating-units.md](../_pricing/yandexgpt/rub-generating_new_units.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating-units.md](../_pricing/yandexgpt/kzt-generating_new_units.md) %}

{% endlist %}



#### Использование моделей базового инстанса до 3 марта 2026 года {#text-sync-async}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-generating_new.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-generating_new.md) %}

{% endlist %}



{#example-generating}

{% cut "Пример расчета стоимости работы модели в синхронном режиме" %}

> Параметры запроса:
> * Инструкция: «Проанализируй предоставленный текст и выполни его комплексную грамотную редактуру. Твоя задача — устранить любые грамматические, орфографические, стилистические и пунктуационные ошибки, не изменяя при этом исходного смысла и структуры высказывания. Сохраняй оригинальный порядок слов и не вноси дополнительных уточнений, пояснений или переформулировок, которые могут изменить тон или содержание текста. Внесённые правки должны быть минимально необходимыми для того, чтобы предложение стало корректным с точки зрения русского языка. Также убедись, что все слова употреблены в нормативной форме, а знаки препинания соответствуют литературным стандартам»
> * Текст запроса: «Нейрасети оптемезируют бизнес-працесы розгружают техпадержку ускаряют праверку документов аналис и абработку данных генирируют отчёты за минуты и прогназируют спрос.»
> * Ответ модели: «Нейросети оптимизируют бизнес‑процессы: разгружают техподдержку, ускоряют проверку документов, анализ и обработку данных, генерируют отчёты за минуты и прогнозируют спрос.»
> Количество символов на вход: 782


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-sync](../_pricing_examples/ai-studio/rub-generating-sync.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-sync](../_pricing_examples/ai-studio/kzt-generating-sync.md) %}

{% endlist %}



{% endcut %}

{% cut "Пример расчета стоимости работы модели в асинхронном режиме" %}

> Параметры запроса:
> * Количество токенов в промпте — 115.
> * Количество токенов в ответе — 1500.
> * Модель {{ gpt-pro }}.
> * Асинхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-pro](../_pricing_examples/ai-studio/rub-generating-pro.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-pro](../_pricing_examples/ai-studio/kzt-generating-pro.md) %}

{% endlist %}



{% endcut %}

#### Использование моделей в пакетном режиме до 3 марта 2026 года {#batch}

При использовании моделей в пакетном режиме минимальная стоимость запуска — 200 000 токенов.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-generating-batch.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-generating-batch.md) %}

{% endlist %}



#### Использование моделей {{ model-gallery-name }} с 3 марта 2026 года {#rules-new}

{% note warning %}

Описанные правила тарификации и цены на модели базового инстанса и пакетный режим работы моделей вступают в силу с 3 марта 2026 года.

{% endnote %}

Стоимость использования моделей зависит от [режима работы](concepts/generation/index.md#working-mode) и количества [токенов](concepts/generation/tokens.md) разных типов потребления:

* входящие токены запроса;
* исходящие токены ответа модели;
* кешированные токены, если часть информации используется повторно без дополнительных вычислений, например инструкция для модели;
* токены инструментов, переданные в модель в результате вызова какого-либо [инструмента](./concepts/agents/index.md#tools).

Кеширование включается автоматически в тех случаях, когда это возможно и применимо. Кеширование не гарантируется и не применяется к исходящим токенам.

К токенам инструментов относятся все некешированные токены, хранящиеся в истории сообщений на момент передачи результатов работы инструмента. Токены инструментов вычисляются только для встроенных инструментов {{ ai-studio-name }} и не распространяются на результаты работы пользовательских функций. [Обращение к инструментам ](#rules-tools) оплачивается отдельно.

##### Синхронный режим работы моделей {#common-instance-sync}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-common-sync](../_pricing/ai-studio/rub-common-instance-sync.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-common-sync](../_pricing/ai-studio/kzt-common-instance-sync.md) %}

{% endlist %}



##### Асинхронный режим работы моделей {#common-instance-async}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-common-sync](../_pricing/ai-studio/rub-common-instance-async.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-common-sync](../_pricing/ai-studio/kzt-common-instance-async.md) %}

{% endlist %}



#### Пакетный режим работы моделей {#batch-instance}

При использовании моделей в пакетном режиме минимальная стоимость запуска — 200 000 токенов.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/ai-studio/rub-batch-instance.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/ai-studio/kzt-batch-instance.md) %}

{% endlist %}



#### Работа выделенных инстансов {#rules-dedicated}

Стоимость работы выделенного инстанса зависит от модели и выбранной конфигурации. Работа выделенного инстанса тарифицируется посекундно с округлением до юнита в большую сторону. При этом время обслуживания оборудования и развертывания модели не тарифицируется.

_{{ price-per-hour-count-per-second }}_


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-dedicated.md) %}

{% endlist %}



#### Дообучение модели {#rules-tuned-generating}

На стадии [Preview](../overview/concepts/launch-stages.md) процесс дообучения моделей не тарифицируется. Дообученная модель {{ gpt-lite }} тарифицируется как базовая модель {{ gpt-lite }}.

#### Токенизация текста {#rules-tokens}

Использование токенизатора (вызовы [TokenizerService](./text-generation/api-ref/grpc/Tokenizer/index.md) и методы [Tokenizer](./text-generation/api-ref/Tokenizer/index.md)) не тарифицируются.

#### Векторизация текста {#rules-embedding}

Стоимость представления текста в виде [векторов](./concepts/embeddings.md) (получения эмбеддингов по тексту) зависит от объема текста, поданного на векторизацию. Создание эмбеддингов [детализируется в {{ billing-name }}](../billing/operations/check-charges.md) в _юнитах векторизации_. 1 юнит равен 1 токену.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-embedding.md](../_pricing/ai-studio/rub-embedding.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-embedding.md](../_pricing/ai-studio/kzt-embedding.md) %}

{% endlist %}



{#price-example-embedding}

{% cut "Пример расчета стоимости векторизации текста" %}

> Стоимость векторизации текста в 2000 токенов составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-embedding-k1](../_pricing_examples/ai-studio/rub-embedding-k1.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-embedding-k1](../_pricing_examples/ai-studio/kzt-embedding-k1.md) %}

{% endlist %}



{% endcut %}

#### Классификации текста {#rules-text-classifier}

Стоимость классификации текста зависит от используемой модели классификации и количества переданных [токенов](concepts/generation/tokens.md).

* При классификации с помощью {{ gpt-lite }} единицей тарификации является 1 запрос до 1 000 токенов.
* При классификациях с помощью {{ gpt-pro }} и дообученных классификаторов единицей тарификации является 1 запрос до 250 токенов.

Запросы, содержащие тексты меньше единицы тарификации, округляются в большую сторону до ближайшего целого. Тексты большего объема тарифицируются как несколько запросов с округлением в большую сторону.

> Например, классификация текста длиной 770 токенов с помощью {{ gpt-lite }} будет тарифицироваться как один запрос (одна единица тарификации).
> Тот же самый текст длиной 770 токенов при классификации с помощью {{ gpt-pro }} или дообученного классификатора будет тарифицироваться как четыре запроса.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-classifier.md](../_pricing/yandexgpt/rub-classifier.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-classifier.md](../_pricing/yandexgpt/kzt-classifier.md) %}

{% endlist %}



#### Генерация изображений {#rules-image-generation}

Использование {{ yandexart-name }} тарифицируется за каждый запрос на генерацию. При этом запросы не идемпотентны, поэтому два запроса с идентичными параметрами и промптом генерации считаются двумя самостоятельными запросами.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-embedding.md](../_pricing/yandexgpt/rub-image.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-embedding.md](../_pricing/yandexgpt/kzt-image.md) %}

{% endlist %}



### {{ agents-atelier-name }} {#rules-agent}

#### Голосовые агенты {#rules-voice-agents}

Стоимость использования голосовых агентов складывается из:

* стоимости распознавания речи (входящее аудио);
* стоимости синтеза речи (исходящее аудио);
* стоимости генерации текста с помощью [модели speech-realtime-250923](#text-sync-async);
* стоимости [вызова инструментов](#rules-tools).


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-speech-realtime.md](../_pricing/yandexgpt/rub-speech-realtime.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-speech-realtime.md](../_pricing/yandexgpt/kzt-speech-realtime.md) %}

{% endlist %}



{#price-example-voice-assistant}

{% cut "Пример расчета стоимости использования голосового агента" %}

> Стоимость использования голосового агента за сессию общей длительностью 60 секунд, в которой:
> * Входящее аудио — 60 секунд.
> * Исходящее аудио — 20 секунд.
> * Число сгенерированных токенов — 2000.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-voice-assistant-pro](../_pricing_examples/ai-studio/rub-voice-assistant-pro.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-voice-assistant-pro](../_pricing_examples/ai-studio/kzt-voice-assistant-pro.md) %}

{% endlist %}



{% endcut %}

#### Текстовые агенты {#rules-assistant}

Стоимость использования текстовых агентов складывается из:

* потребления токенов по правилам и тарифам [моделей {{ model-gallery-name }}](#rules-generating);
* стоимости [вызова инструментов](#rules-tools).

#### Вызов инструментов в агентах {#rules-tools}

{% note info %}

Стоимость вызовов инструмента поиска по файлам File Search изменится 12 марта 2026 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-tools](../_pricing/ai-studio/rub-tools.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-tools](../_pricing/ai-studio/kzt-tools.md) %}

{% endlist %}



### {{ ai-search-name }} {#ai-search}

До 12 марта 2026 года хранение поисковых индексов и файлов, загруженных в {{ ai-studio-name }}, не тарифицируется.

{% note info %}

Правила тарификации ниже вступают в силу 12 марта 2026 года.

{% endnote %}

Размер поискового индекса округляется до целого числа ГБ в большую сторону.


{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-index-storage.md](../_pricing/ai-studio/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-index-storage.md](../_pricing/ai-studio/kzt-storage.md) %}

{% endlist %}



### {{ mcp-hub-name }} {#mcp-hub}

{% include [note-preview](../_includes/note-preview.md) %}

На стадии Preview [MCP-серверы](./concepts/mcp-hub/index.md#servers) не тарифицируются. При этом может оплачиваться использование инструментов, создаваемых в MCP-серверах. Например, [вызовы функций]({{ link-docs }}/functions/pricing.md#invoke) {{ sf-full-name }}.

При работе с внешними API, такими как [Контур.Фокус](./concepts/mcp-hub/templates.md#kontur) или [amoCRM](./concepts/mcp-hub/templates.md#amocrm), оплата использования производится партнеру напрямую.

### Внутренние ошибки сервера {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

