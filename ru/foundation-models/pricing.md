---
editable: false
---

# Правила тарификации для {{ foundation-models-full-name }}

{{ foundation-models-full-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Сервис тарифицируется в соответствии с документом [Специальные условия использования](https://yandex.ru/legal/cloud_specialterms/?lang=ru#index__section_fk5_d4c_cgb). Детализация использования {{ yagpt-full-name }} доступна в {{ billing-name }} как использование ресурсов {{ foundation-models-full-name }}. 

В [консоли управления]({{ link-console-main }}/link/yandexgpt) новым пользователям без [платежного аккаунта](../billing/concepts/billing-account.md) для тестирования доступны запросы к моделям:
* {{ yagpt-full-name }} — {{ gpt-freetier }} бесплатных запросов в час.
* {{ yandexart-name }} — {{ art-freetier }} бесплатных запросов в сутки.

## Из чего складывается стоимость использования {{ foundation-models-full-name }} {#rules}

### Единица тарификации {#unit}

Единица тарификации — это один тарифицирующий юнит. Стоимость одного тарифицирующего юнита при генерации и векторизации текста отличается.

### Генерация текста {#rules-generating}

Стоимость генерации текста рассчитывается из суммарного количества [токенов](concepts/yandexgpt/tokens.md) [промта](concepts/index.md#working-mode) и ответа и зависит от параметров запроса к {{ yagpt-full-name }}. Следующие параметры влияют на стоимость генерации текста:

* [модель](concepts/yandexgpt/models.md), к которой приходит запрос;
* [режим работы](concepts/index.md#working-mode) модели. 

Число [токенов](concepts/yandexgpt/tokens.md) в [промте](concepts/index.md) и ответе для одного и того же текста для разных моделей может отличаться.

Количество тарифицирующих юнитов вычисляется на основе суммарного числа токенов промта и ответа и округляется до целого значения в большую сторону после применения коэффициента.

#### Дообученные модели {#rules-tuned-generating}

Работа модели краткого пересказа тарифицируется по правилам {{ gpt-lite }}. Работа моделей, дообученных в {{ ml-platform-full-name }}, тарифицируется по правилам {{ gpt-pro }}.

### Векторизация текста {#rules-embedding}

Стоимость представления текста в виде векторов (получения эмбеддингов по тексту) зависит от объема текста, поданного на векторизацию. 

### Генерация изображений {#rules-image-generation}

На стадии [Preview](../overview/concepts/launch-stages.md) использование {{ yandexart-name }} не тарифицируется.

### Внутренние ошибки сервера {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Примеры расчета стоимости использования {{ yagpt-full-name }} {#price-examples}


### Пример расчета векторизации текста {#price-example-embedding}

> Стоимость использования {{ yagpt-name }} для векторизации текста со следующими параметрами:
> * число токенов в запросе — 2000
> 
> Расчет стоимости:
> 
> 2000 × 1,0 × (0,01&nbsp;₽ / 1000) = 0,02&nbsp;₽
>
> Итого: 0,02&nbsp;₽.
 
Где:
* 2000 — число токенов в запросе.
* 1,0 — коэффициент использования векторизации текста.
* 0,01&nbsp;₽ — стоимость обработки 1000 токенов. 
* 0,01&nbsp;₽ / 1000 — стоимость обработки 1 токена. 


## Цены {#prices}


### Генерация текста в {{ yagpt-full-name }} {#pricing-generating}

{% note warning %}

Цены, представленные ниже, начнут действовать 25 марта 2024 года.

{% endnote %}


{% include [rub-generating.md](../_pricing/yandexgpt/rub-generating_new.md) %}




### Векторизация текста в {{ yagpt-full-name }} {#pricing-embedding}


{% include [rub-embedding.md](../_pricing/yandexgpt/rub-embedding.md) %}



