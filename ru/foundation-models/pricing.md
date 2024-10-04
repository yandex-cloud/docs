---
editable: false
---

# Правила тарификации для {{ foundation-models-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [not-charged-foundation-models](../_includes/pricing/price-formula/not-charged-foundation-models.md) %}

## Из чего складывается стоимость использования {{ foundation-models-full-name }} {#rules}

### Единица тарификации {#unit}

Использование сервиса {{ foundation-models-name }} детализируется в единицах тарификации — _тарифицирующих юнитах_. Стоимость одного тарифицирующего юнита различается для [генерации](./concepts/yandexgpt/index.md) и [векторизации](./concepts/embeddings.md) текста.

### Генерация текста {#rules-generating}

Стоимость генерации текста рассчитывается из суммарного количества [токенов](concepts/yandexgpt/tokens.md) [промта](concepts/index.md#working-mode) и ответа и зависит от параметров запроса к {{ yagpt-full-name }}. Следующие параметры влияют на стоимость генерации текста:

* [Модель](concepts/yandexgpt/models.md), к которой приходит запрос.
* [Режим работы](concepts/index.md#working-mode) модели.

Число [токенов](concepts/yandexgpt/tokens.md) в [промте](concepts/index.md) и ответе для одного и того же текста для разных моделей может отличаться.

Итоговое количество потребленных юнитов вычисляется на основе суммарного числа токенов промта и ответа и округляется до целого значения в большую сторону.

#### Токенизация {#rules-tokens}

Использование токенизатора (вызовы [TokenizerService](./text-generation/api-ref/grpc/TokenizerService.md) и методы [Tokenizer](./text-generation/api-ref/Tokenizer/index.md)) не тарифицируются.

#### Дообученные модели {#rules-tuned-generating}

Работа моделей, дообученных в {{ ml-platform-full-name }}, тарифицируется по правилам {{ gpt-pro }}.

### Классификация текста {#rules-text-classifier}

На стадии [Preview](../overview/concepts/launch-stages.md) использование классификаторов на базе {{ yagpt-name }} не тарифицируется.

### Векторизация текста {#rules-embedding}

Стоимость представления текста в виде [векторов](./concepts/embeddings.md) (получения эмбеддингов по тексту) зависит от объема текста, поданного на векторизацию.

### Генерация изображений {#rules-image-generation}

На стадии [Preview](../overview/concepts/launch-stages.md) использование {{ yandexart-name }} не тарифицируется.

### Внутренние ошибки сервера {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Генерация текста в {{ yagpt-full-name }} {#pricing-generating}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating-units.md](../_pricing/yandexgpt/rub-generating_new_units.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating-units.md](../_pricing/yandexgpt/kzt-generating_new_units.md) %}

{% endlist %}

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-generating.md](../_pricing/yandexgpt/rub-generating_new.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-generating.md](../_pricing/yandexgpt/kzt-generating_new.md) %}

{% endlist %}



### Векторизация текста в {{ yagpt-full-name }} {#pricing-embedding}


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



## Примеры расчета стоимости использования {{ yagpt-full-name }} {#price-examples}

### Примеры расчета генерации текста {#price-example-generating}

#### Пример 1 {#example-generating-1}

Стоимость использования {{ yagpt-full-name }} для генерации текста со следующими параметрами:

* Количество токенов в промте — 225.
* Количество токенов в ответе — 525.
* Модель {{ gpt-lite }}.
* Синхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-lite](../_pricing_examples/foundation-models/rub-generating-lite.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-lite](../_pricing_examples/foundation-models/kzt-generating-lite.md) %}

{% endlist %}



#### Пример 2 {#example-generating-2}

Стоимость использования {{ yagpt-full-name }} для генерации текста со следующими параметрами:

* Количество токенов в промте — 115.
* Количество токенов в ответе — 1500.
* Модель {{ gpt-pro }}.
* Асинхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-pro](../_pricing_examples/foundation-models/rub-generating-pro.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-pro](../_pricing_examples/foundation-models/kzt-generating-pro.md) %}

{% endlist %}



#### Пример 3 {#example-generating-3}

Стоимость использования {{ yagpt-full-name }} для генерации текста со следующими параметрами:

* Количество токенов в промте — 1020.
* Количество токенов в ответе — 30.
* Модель {{ gpt-pro }}, дообученная в {{ ml-platform-name }}.
* Синхронный режим работы модели.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-generating-pro-ml](../_pricing_examples/foundation-models/rub-generating-pro-ml.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-generating-pro-ml](../_pricing_examples/foundation-models/kzt-generating-pro-ml.md) %}

{% endlist %}



### Пример расчета векторизации текста {#price-example-embedding}

Стоимость использования {{ yagpt-full-name }} для векторизации текста со следующим параметром:

* Число токенов в запросе — 2000.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-embedding-k1](../_pricing_examples/foundation-models/rub-embedding-k1.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-embedding-k1](../_pricing_examples/foundation-models/kzt-embedding-k1.md) %}

{% endlist %}




