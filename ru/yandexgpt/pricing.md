---
editable: false
---

# Правила тарификации для {{ yagpt-full-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{{ yagpt-full-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md) и является частью сервиса {{ foundation-models-full-name }}. Сервис тарифицируется в соответствии с документом [Специальные условия использования](https://yandex.ru/legal/cloud_specialterms/?lang=ru#index__section_fk5_d4c_cgb). Детализация использования {{ yagpt-full-name }} доступна в {{ billing-name }} как использование ресурсов {{ foundation-models-full-name }}. 

В [консоли управления]({{ link-console-main }}/link/yandexgpt) новым пользователям без [платежного аккаунта](../billing/concepts/billing-account.md) доступно {{ gpt-freetier }} бесплатных запросов в час.

## Из чего складывается стоимость использования {{ yagpt-full-name }} {#rules}

### Единица тарификации {#unit}

Единица тарификации — это один тарифицирующий юнит. Стоимость одного тарифицирующего юнита при генерации и векторизации текста отличается.

### Генерация текста {#rules-generating}

Стоимость генерации текста рассчитывается из суммарного количества [токенов](concepts/tokens.md) [промта](concepts/index.md#working-mode) и ответа и зависит от параметров запроса к {{ yagpt-full-name }}. Следующие параметры влияют на стоимость генерации текста:

* [модель](concepts/models.md), к которой приходит запрос;
* [режим работы](concepts/index.md#working-mode) модели. 

Число [токенов](concepts/tokens.md) в [промте](concepts/index.md) и ответе для одного и того же текста для разных моделей может отличаться.

Количество тарифицирующих юнитов вычисляется на основе суммарного числа токенов промта и ответа и округляется до целого значения в большую сторону после применения коэффициента.

#### Дообученные модели {#rules-tuned-generating}

Работа модели краткого пересказа тарифицируется по правилам {{ gpt-lite }}. Работа моделей, дообученных в {{ ml-platform-full-name }}, тарифицируется по правилам {{ gpt-pro }}.

### Векторизация текста {#rules-embedding}

Стоимость представления текста в виде векторов (получения эмбеддингов по тексту) зависит от объема текста, поданного на векторизацию. 

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


{% include [rub-generating.md](../_pricing/yandexgpt/rub-generating_new.md) %}




### Векторизация текста в {{ yagpt-full-name }} {#pricing-embedding}


{% include [rub-embedding.md](../_pricing/yandexgpt/rub-embedding.md) %}



