---
editable: false
---

# Правила тарификации для {{ foundation-models-full-name }}



{{ foundation-models-full-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Сервис тарифицируется в соответствии с документом [Специальные условия использования](https://yandex.ru/legal/cloud_specialterms/?lang=ru#index__section_fk5_d4c_cgb). Детализация использования {{ yagpt-full-name }} доступна в {{ billing-name }} как использование ресурсов {{ foundation-models-full-name }}. 

В [консоли управления]({{ link-console-main }}) новым пользователям без [платежного аккаунта](../billing/concepts/billing-account.md) для тестирования доступны запросы к моделям:
* {{ yagpt-full-name }} — {{ gpt-freetier }} бесплатных запросов в час.
* {{ yandexart-name }} — {{ art-freetier }} бесплатных запросов в сутки.

## Из чего складывается стоимость использования {{ foundation-models-full-name }} {#rules}

### Единица тарификации {#unit}

Использование сервиса {{ foundation-models-name }} детализируется в единицах тарификации — _тарифицирующих юнитах_. Стоимость одного тарифицирующего юнита различается для генерации и векторизации текста.

### Генерация текста {#rules-generating}

Стоимость генерации текста рассчитывается из суммарного количества [токенов](concepts/yandexgpt/tokens.md) [промта](concepts/index.md#working-mode) и ответа и зависит от параметров запроса к {{ yagpt-full-name }}. Следующие параметры влияют на стоимость генерации текста:

* [модель](concepts/yandexgpt/models.md), к которой приходит запрос;
* [режим работы](concepts/index.md#working-mode) модели. 

Число [токенов](concepts/yandexgpt/tokens.md) в [промте](concepts/index.md) и ответе для одного и того же текста для разных моделей может отличаться.

Итоговое количество потребленных юнитов вычисляется на основе суммарного числа токенов промта и ответа и округляется до целого значения в большую сторону.

#### Токенизация {#rules-tokens}

Использование токенизатора (вызовы [TokenizerService](./text-generation/api-ref/grpc/TokenizerService.md) и методы [Tokenizer](./text-generation/api-ref/Tokenizer/index.md)) не тарифицируются.

#### Дообученные модели {#rules-tuned-generating}

Работа модели краткого пересказа тарифицируется по правилам {{ gpt-lite }}. Работа моделей, дообученных в {{ ml-platform-full-name }}, тарифицируется по правилам {{ gpt-pro }}.

### Классификация текста {#rules-text-classifier}

На стадии [Preview](../overview/concepts/launch-stages.md) использование классификаторов на базе {{ yagpt-name }} не тарифицируется.

### Векторизация текста {#rules-embedding}

Стоимость представления текста в виде векторов (получения эмбеддингов по тексту) зависит от объема текста, поданного на векторизацию.

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

> Стоимость использования {{ yagpt-full-name }} для генерации текста со следующими параметрами:
> * количество токенов в промте — 225
> * количество токенов в ответе — 525
> * модель {{ gpt-lite }}
> * синхронный режим работы модели
 
Расчет стоимости:
Количество токенов в промте и ответе: 225 + 525 = 750
Количество юнитов в 1 токене для модели {{ gpt-lite }} в синхронном режиме: 1
Общее количество юнитов в детализации потребления: 750


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  (0,20&nbsp;₽ / 1000 юнитов) × 750 юнитов = 0,15&nbsp;₽

- Расчет в тенге {#prices-kzt}

  (1&nbsp;₸ / 1000 юнитов) × 750 юнитов = 0,75&nbsp;₸

{% endlist %}



> Стоимость использования {{ yagpt-full-name }} для генерации текста со следующими параметрами:
> * количество токенов в промте — 115
> * количество токенов в ответе — 1500
> * модель {{ gpt-pro }}
> * асинхронный режим работы модели


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Количество токенов в промте и ответе: 115 + 1500 = 1615
  Цена за 1000 токенов для модели {{ gpt-pro }} в асинхронном режиме: 0,60 ₽
  Количество юнитов в 1 токене для модели {{ gpt-pro }} в асинхронном режиме: 3
  Общее количество юнитов в детализации потребления: 1615 × 3 = 4845

  Итого: (0,60&nbsp;₽ / 1000 токенов) × 1615 токенов = 0,969&nbsp;₽, округляя до целого значения, 0,97&nbsp;₽.

- Расчет в тенге {#prices-kzt}

  Количество токенов в промте и ответе: 115 + 1500 = 1615
  Цена за 1000 токенов для модели {{ gpt-pro }} в асинхронном режиме: 3,00&nbsp;₸
  Количество юнитов в 1 токене для модели {{ gpt-pro }} в асинхронном режиме: 3
  Общее количество юнитов в детализации потребления: 1615 × 3 = 4845

  Итого: (3,00&nbsp;₸ / 1000 токенов) × 1615 токенов = 4,845&nbsp;₸, округляя до целого значения, 4,85&nbsp;₸.

{% endlist %}



> Стоимость использования {{ yagpt-full-name }} для генерации текста со следующими параметрами:
> * количество токенов в промте — 1020
> * количество токенов в ответе — 30
> * модель {{ gpt-pro }}, дообученная в {{ ml-platform-name }}
> * синхронный режим работы модели
 

{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Количество токенов в промте и ответе: 1020 + 30 = 1050
  Цена за 1000 токенов для модели, дообученной в {{ ml-platform-name }}, в синхронном режиме: 1,20 ₽
  Количество юнитов в 1 токене для модели, дообученной в {{ ml-platform-name }}, в синхронном режиме: 6
  Общее количество юнитов в детализации потребления: 1050 × 6 = 6300

  Итого: (0,20&nbsp;₽ / 1000 юнитов) × 6300 юнитов = 1,26&nbsp;₽ **или** (1,20&nbsp;₽ / 1000 токенов) × 1050 токенов = 1,26&nbsp;₽.

- Расчет в тенге {#prices-kzt}

  Количество токенов в промте и ответе: 1020 + 30 = 1050
  Цена за 1000 токенов для модели, дообученной в {{ ml-platform-name }}, в синхронном режиме: 6,00 ₸
  Количество юнитов в 1 токене для модели, дообученной в {{ ml-platform-name }}, в синхронном режиме: 6
  Общее количество юнитов в детализации потребления: 1050 × 6 = 6300

  Итого: (1,00&nbsp;₸ / 1000 юнитов) × 6300 юнитов = 6,30&nbsp;₸ **или** (6,00&nbsp;₸ / 1000 токенов) × 1050 токенов = 6,30&nbsp;₸.

{% endlist %}



### Пример расчета векторизации текста {#price-example-embedding}

> Стоимость использования {{ yagpt-name }} для векторизации текста со следующими параметрами:
> * число токенов в запросе — 2000
> * коэффициент использования векторизации текста — 1,0


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 2000 × 1,0 × (0,01&nbsp;₽ / 1000) = 0,02&nbsp;₽
  >
  > Итого: 0,02&nbsp;₽.
 
  Где:
  * 0,01&nbsp;₽ — стоимость обработки 1000 токенов.
  * 0,01&nbsp;₽ / 1000 — стоимость обработки 1 токена.

- Расчет в тенге {#prices-kzt}

  > 2000 × 1,0 × (0,05&nbsp;₸ / 1000) = 0,10&nbsp;₸
  >
  > Итого: 10&nbsp;₸.
 
  Где:
  * 0,05&nbsp;₸ — стоимость обработки 1000 токенов.
  * 0,05&nbsp;₸ / 1000 — стоимость обработки 1 токена.

{% endlist %}


