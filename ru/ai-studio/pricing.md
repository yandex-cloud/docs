---
title: Правила тарификации для {{ foundation-models-full-name }}
description: В статье содержатся правила тарификации сервиса {{ foundation-models-name }}.
editable: false
---

# Правила тарификации для {{ foundation-models-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ foundation-models-full-name }} {#rules}

Использование сервиса {{ foundation-models-name }} [детализируется в {{ billing-name }}](../billing/operations/check-charges.md) в единицах тарификации — _тарифицирующих юнитах_. Стоимость одного тарифицирующего юнита различается для [генерации](concepts/generation/index.md), [векторизации](./concepts/embeddings.md) и [выделенных инстансов](concepts/generation/dedicated-instance.md).

### Генерация текста {#rules-generating}

Стоимость генерации текста рассчитывается из суммарного количества [токенов](concepts/generation/tokens.md) [промта](concepts/generation/index.md#working-mode) и ответа и зависит от параметров запроса к моделям генерации. Следующие параметры влияют на стоимость генерации текста:

* [Модель](concepts/generation/models.md), к которой приходит запрос.
* [Режим работы](concepts/generation/index.md#working-mode) модели.

Число [токенов](concepts/generation/tokens.md) в [промте](concepts/index.md) и ответе для одного и того же текста для разных моделей может отличаться.

При использовании моделей в пакетном режиме минимальная стоимость запуска — 200 000 токенов.

Итоговое количество потребленных юнитов вычисляется на основе суммарного числа токенов промта и ответа и округляется до целого значения в большую сторону.

#### Токенизация {#rules-tokens}

Использование токенизатора (вызовы [TokenizerService](./text-generation/api-ref/grpc/Tokenizer/index.md) и методы [Tokenizer](./text-generation/api-ref/Tokenizer/index.md)) не тарифицируются.

#### Дообученные модели {#rules-tuned-generating}

На стадии [Preview](../overview/concepts/launch-stages.md) процесс дообучения моделей не тарифицируется. Использование дообученных моделей тарифицируется по правилам базовой модели:

* Работа дообученной модели {{ gpt-lite }} тарифицируется по правилам {{ gpt-lite }}.
* Работа дообученной модели {{ llama }} 8B тарифицируется по правилам {{ llama }} 8B^1^.

^1^ {{ meta-disclaimer }}

### Выделенные инстансы {#rules-dedicated}

Стоимость работы выделенного инстанса зависит от модели и выбранной конфигурации. Работа выделенного инстанса тарифицируется посекундно с округлением до тарифицирующего юнита в большую сторону. При этом время обслуживания оборудования и развертывания модели не тарифицируется.

_{{ price-per-hour-count-per-second }}_

### Классификация текста {#rules-text-classifier}

Стоимость классификации текста зависит от используемой модели классификации и количества переданных [токенов](concepts/generation/tokens.md).

* При классификации с помощью {{ gpt-lite }} единицей тарификации является 1 запрос до 1 000 токенов.
* При классификациях с помощью {{ gpt-pro }} и дообученных классификаторов единицей тарификации является 1 запрос до 250 токенов.

Запросы, содержащие тексты меньше единицы тарификации, округляются в большую сторону до ближайшего целого. Тексты большего объема тарифицируются как несколько запросов с округлением в большую сторону.

> Например, классификация текста длиной 770 токенов с помощью {{ gpt-lite }} будет тарифицироваться как один запрос (одна единица тарификации).
> Тот же самый текст длиной 770 токенов при классификации с помощью {{ gpt-pro }} или дообученного классификатора будет тарифицироваться как четыре запроса.

### Векторизация текста {#rules-embedding}

Стоимость представления текста в виде [векторов](./concepts/embeddings.md) (получения эмбеддингов по тексту) зависит от объема текста, поданного на векторизацию. 

### Использование ассистентов и текстовых агентов {#rules-assistant}

Использование {{ assistant-api }}, Responses API и хранение файлов не тарифицируется, но работа моделей оплачивается по правилам [генерации текста](#rules-generating). 

### Использование голосовых агентов {#rules-voice-assistant}

Стоимость использования голосовых агентов состоит из стоимости распознавания речи (входящее аудио), стоимости синтеза речи (исходящее аудио) и стоимости генерации текста с помощью модели speech-realtime-250923.

_{{ price-per-hour-count-per-second }}_

### Генерация изображений {#rules-image-generation}

Использование {{ yandexart-name }} тарифицируется за каждый запрос на генерацию. При этом запросы не идемпотентны, поэтому два запроса с идентичными параметрами и промтом генерации считаются двумя самостоятельными запросами.

### Внутренние ошибки сервера {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Генерация текста {#pricing-generating}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating-units.md](../_pricing/yandexgpt/rub-generating_new_units.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating-units.md](../_pricing/yandexgpt/kzt-generating_new_units.md) %}

{% endlist %}



#### Стоимость использования моделей в синхронном и асинхронном режиме {#text-sync-async}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-generating_new.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-generating_new.md) %}

{% endlist %}



#### Стоимость использования моделей в пакетном режиме {#batch}

При использовании моделей в пакетном режиме минимальная стоимость запуска — 200 000 токенов.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-generating-batch.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-generating-batch.md) %}

{% endlist %}



#### Выделенные инстансы {#dedicated}

_{{ price-per-hour-count-per-second }}_


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-dedicated.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-dedicated.md) %}

{% endlist %}



### Классификация текста {#pricing-classifier}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-classifier.md](../_pricing/yandexgpt/rub-classifier.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-classifier.md](../_pricing/yandexgpt/kzt-classifier.md) %}

{% endlist %}



### Векторизация текста {#pricing-embedding}


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



### Использование голосовых агентов {#voice-assistant}

_Цена указывается за 1 минуту использования, тарификация посекундная._


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-speech-realtime.md](../_pricing/yandexgpt/rub-speech-realtime.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-speech-realtime.md](../_pricing/yandexgpt/kzt-speech-realtime.md) %}

{% endlist %}



### Генерация изображений {#pricing-image-generation}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-embedding.md](../_pricing/yandexgpt/rub-image.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-embedding.md](../_pricing/yandexgpt/kzt-image.md) %}

{% endlist %}



### {{ mcp-hub-name }} {#mcp-hub}

{% include [note-preview](../_includes/note-preview.md) %}

На стадии Preview [MCP-серверы](./concepts/mcp-hub/index.md#servers) не тарифицируются. При этом может оплачиваться использование инструментов, создаваемых в MCP-серверах. Например, [вызовы функций](../functions/pricing.md#invoke) {{ sf-full-name }}.

При работе с внешними API, такими как [Контур.Фокус](./concepts/mcp-hub/templates.md#kontur) или [amoCRM](./concepts/mcp-hub/templates.md#amocrm), оплата использования производится партнеру напрямую.

## Примеры расчета стоимости использования {{ gpt-lite }} и {{ gpt-pro }} {#price-examples}

### Примеры расчета генерации текста {#price-example-generating}

#### Пример 1 {#example-generating-1}

Стоимость использования {{ gpt-lite }} для генерации текста со следующими параметрами:

* Количество токенов в промте — 225.
* Количество токенов в ответе — 525.
* Модель {{ gpt-lite }}.
* Синхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-lite](../_pricing_examples/ai-studio/rub-generating-lite.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-lite](../_pricing_examples/ai-studio/kzt-generating-lite.md) %}

{% endlist %}



#### Пример 2 {#example-generating-2}

Стоимость использования {{ gpt-pro }} для генерации текста со следующими параметрами:

* Количество токенов в промте — 115.
* Количество токенов в ответе — 1500.
* Модель {{ gpt-pro }}.
* Асинхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-pro](../_pricing_examples/ai-studio/rub-generating-pro.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-pro](../_pricing_examples/ai-studio/kzt-generating-pro.md) %}

{% endlist %}



#### Пример 3 {#example-generating-3}

Стоимость использования {{ gpt-pro }} и {{ ml-platform-name }} для генерации текста со следующими параметрами:

* Количество токенов в промте — 1020.
* Количество токенов в ответе — 30.
* Модель {{ gpt-pro }}, дообученная в {{ ml-platform-name }}.
* Синхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-pro-ml](../_pricing_examples/ai-studio/rub-generating-pro-ml.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-pro-ml](../_pricing_examples/ai-studio/kzt-generating-pro-ml.md) %}

{% endlist %}



### Пример расчета векторизации текста {#price-example-embedding}

Стоимость использования {{ foundation-models-full-name }} для векторизации текста со следующим параметром:

* Число токенов в запросе — 2000.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-embedding-k1](../_pricing_examples/ai-studio/rub-embedding-k1.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-embedding-k1](../_pricing_examples/ai-studio/kzt-embedding-k1.md) %}

{% endlist %}




## Пример расчета стоимости использования голосовых агентов {#price-example-voice-assistant}

Стоимость использования голосового агента speech-realtime-250923 со следующими параметрами:

* Входящее аудио — 30 секунд.
* Исходящее аудио — 1 минута.
* Число токенов в запросе — 2000.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-voice-assistant-pro](../_pricing_examples/ai-studio/rub-voice-assistant-pro.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-voice-assistant-pro](../_pricing_examples/ai-studio/kzt-voice-assistant-pro.md) %}

{% endlist %}


