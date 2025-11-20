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

{% include [prices-nds-note](../_includes/prices-nds-note.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### {{ model-gallery-name }} {#rules-generating}

Стоимость работы с моделями {{ model-gallery-name }} зависит от:
* [режима работы модели](concepts/generation/index.md#working-mode);
* количества входящих и исходящих [токенов](concepts/generation/tokens.md). Число [токенов](concepts/generation/tokens.md) в одном и том же тексте для разных моделей может отличаться.

Использование моделей {{ model-gallery-name }} [детализируется в {{ billing-name }}](../billing/operations/check-charges.md) в единицах тарификации — _юнитах_. Итоговое количество потребленных юнитов округляется до целого значения в большую сторону.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating-units.md](../_pricing/yandexgpt/rub-generating_new_units.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating-units.md](../_pricing/yandexgpt/kzt-generating_new_units.md) %}

{% endlist %}



#### Использование моделей базового инстанса {#text-sync-async}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-generating_new.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-generating_new.md) %}

{% endlist %}



{#example-generating}

{% cut "Расчет стоимости работы модели в синхронном режиме" %}

> Параметры запроса:
> * Количество токенов в промпте — 225.
> * Количество токенов в ответе — 525.
> * Модель — {{ gpt-lite }}.
> * Синхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-lite](../_pricing_examples/ai-studio/rub-generating-lite.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-lite](../_pricing_examples/ai-studio/kzt-generating-lite.md) %}

{% endlist %}



{% endcut %}

{% cut "Расчет стоимости работы модели в асинхронном режиме" %}

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

#### Использования моделей в пакетном режиме {#batch}

При использовании моделей в пакетном режиме минимальная стоимость запуска — 200 000 токенов.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-generating-batch.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-generating-batch.md) %}

{% endlist %}



#### Работы выделенных инстансов {#rules-dedicated}

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

Стоимость представления текста в виде [векторов](./concepts/embeddings.md) (получения эмбеддингов по тексту) зависит от объема текста, поданного на векторизацию. Создание эмбеддингов [детализируется в {{ billing-name }}](../billing/operations/check-charges.md) в _юнитах векторизации_. 


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-embedding-units.md](../_pricing/yandexgpt/rub-embedding_units.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-embedding-units.md](../_pricing/yandexgpt/kzt-embedding_units.md) %}

{% endlist %}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-embedding.md](../_pricing/yandexgpt/rub-embedding.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-embedding.md](../_pricing/yandexgpt/kzt-embedding.md) %}

{% endlist %}



{#price-example-embedding}

{% cut "Расчет стоимости векторизации текста" %}

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

#### Использование ассистентов и текстовых агентов {#rules-assistant}

Использование {{ assistant-api }}, {{ responses-api }} и хранение файлов и поисковых индексов не тарифицируется. Потребленные токены оплачиваются по правилам и тарифам [моделей](#rules-generating) {{ model-gallery-name }}. 

#### Использование голосовых агентов {#rules-voice-agents}

Стоимость использования голосовых агентов состоит из стоимости распознавания речи (входящее аудио), стоимости синтеза речи (исходящее аудио) и стоимости генерации текста с помощью модели speech-realtime-250923.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-speech-realtime.md](../_pricing/yandexgpt/rub-speech-realtime.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-speech-realtime.md](../_pricing/yandexgpt/kzt-speech-realtime.md) %}

{% endlist %}



{#price-example-voice-assistant}

{% cut "Расчет стоимости использования голосового агента" %}

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

#### Использование инструментов в агентах {#rules-tools}

Вызов инструментов {{ assistant-api }} не тарифицируется. 

Вызов инструмента поиска по файлам File Search в текстовых и голосовых агентах не тарифицируется.

Вызов инструмента поиска в интернете Web Search в текстовых и голосовых агентах не тарифицируется до 17 ноября 2025 года. 


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-embedding.md](../_pricing/yandexgpt/rub-tools.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-embedding.md](../_pricing/yandexgpt/kzt-tools.md) %}

{% endlist %}



### {{ mcp-hub-name }} {#mcp-hub}

{% include [note-preview](../_includes/note-preview.md) %}

На стадии Preview [MCP-серверы](./concepts/mcp-hub/index.md#servers) не тарифицируются. При этом может оплачиваться использование инструментов, создаваемых в MCP-серверах. Например, [вызовы функций](../functions/pricing.md#invoke) {{ sf-full-name }}.

При работе с внешними API, такими как [Контур.Фокус](./concepts/mcp-hub/templates.md#kontur) или [amoCRM](./concepts/mcp-hub/templates.md#amocrm), оплата использования производится партнеру напрямую.

### Внутренние ошибки сервера {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

