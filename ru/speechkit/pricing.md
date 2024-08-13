---
title: "Правила тарификации для {{ speechkit-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ speechkit-full-name }}."
editable: false
---

# Правила тарификации для {{ speechkit-name }}



{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## Из чего складывается стоимость использования {{ speechkit-short-name }} {#rules}

### Использование синтеза речи {#rules-tts}

Стоимость использования {{ speechkit-name }} для синтеза речи зависит от версии используемого API.

#### API v1 {#api-v1}

Для [API v1](tts/request.md) стоимость рассчитывается исходя из суммарного количества символов, которые были отправлены для генерации речи из текста за календарный месяц ([Отчетный период](../billing/concepts/glossary.md)).

#### API v3 {#api-v3}

Стоимость использования [API v3](tts-v3/api-ref/grpc/index.md) зависит от количества отправленных запросов на синтез. Стоимость рассчитывается за календарный месяц ([Отчетный период](../billing/concepts/glossary.md)).

По умолчанию запросы на синтез речи имеют ограничения — {{ tts-v3-count }} и {{ tts-v3-time }}. Для синтеза более длинных фраз можно использовать режим `unsafe_mode`. Тогда тарифицироваться будут каждые 250 символов, например:

* Запрос меньше 250 символов — одна единица тарификации.
* Запрос от 250 до 500 символов — две единицы тарификации.
* Запрос от 500 до 750 символов — три единицы тарификации.

#### Пустой запрос {#tts-empty-request}

Количество символов в запросе определяется с учетом пробелов и служебных символов. Стоимость пустого запроса зависит от версии API:

* Пустой запрос к API v1 тарифицируется как один символ.
* Пустой запрос к API v3 тарифицируется как одна единица тарификации.

#### Внутренние ошибки сервера {#tts-error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

### Использование распознавания речи {#rules-stt}

Стоимость использования {{ speechkit-name }} для распознавания речи зависит от типа распознавания и длительности распознанного аудио. Стоимость рассчитывается за календарный месяц ([Отчетный период](../billing/concepts/glossary.md)).

#### Потоковый режим распознавания {#rules-stt-streaming}

Стоимость использования {{ speechkit-name }} в режиме потокового распознавания рассчитывается по [правилам тарификации синхронного распознавания](#rules-stt-short).

#### Синхронное распознавание {#rules-stt-short}

Эти правила действуют при использовании [синхронного распознавания](stt/request.md) и распознавания [в потоковом режиме](stt/streaming.md) при использовании API v2 и API v3.

Единица тарификации — отрезок одноканального аудио длительностью 15 секунд. Отрезки меньшей длительности округляются в большую сторону (1 секунда превращается в 15 секунд).

{% note warning %}

В [потоковом режиме](stt/streaming.md) тарификация начинается с отправки [сообщения с настройками распознавания](stt/streaming.md#specification-msg). Даже если вы не отправляли аудио после этого сообщения, это будет считаться как использованная единица тарификации.

{% endnote %}

> **Примеры:**
>
> * 1 аудиофрагмент 37 секунд тарифицируется как 45 секунд.
>
>    **Объяснение:** аудио разбивается на 2 отрезка по 15 секунд и один отрезок 7 секунд. Длительность последнего отрезка будет округлена до 15 секунд. Итого, 3 отрезка по 15 секунд.
>
> * 2 аудиофрагмента по 5 и 8 секунд тарифицируются как 30 секунд.
>
>    **Объяснение:** длительность каждого аудио будет округлена до 15 секунд. Итого, 2 отрезка по 15 секунд.

#### Асинхронное распознавание {#rules-stt-long}

Эти правила действуют при использовании [асинхронного распознавания](stt/transcribation.md).

Единица тарификации — 1 секунда двухканального аудио. Отрезки меньшей длительности округляются в большую сторону. Количество каналов округляется до четного числа.

Минимум начисляется 15 секунд за каждые два канала. Аудио меньшей длительности тарифицируется, как 15 секунд.

**Примеры с округлением длительности аудио:**

Длительность | Количество каналов | Начислено секунд
--- | --- | ---
1 секунда | 1 | 15
1 секунда | 2 | 15
1 секунда | 3 | 30
15.5 секунд | 2 | 16
15.5 секунд | 4 | 32

#### Пустой запрос {#stt-empty-request}

Пустой запрос к любому типу распознавания равен стоимости одной единицы тарификации.

#### Внутренние ошибки сервера {#stt-error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Цены для региона Россия {#prices}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Синтез речи {#prices-tts}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/speechkit/rub-tts.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/speechkit/kzt-tts.md) %}

{% endlist %}



### {{ brand-voice-name }} {#brand-voice}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/speechkit/rub-brand.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/speechkit/kzt-brand.md) %}

{% endlist %}



### Распознавание речи {#prices-stt}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/speechkit/rub-stt.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/speechkit/kzt-stt.md) %}

{% endlist %}




## Примеры расчета стоимости {#price-example}

### Синтез речи с использованием API v1 {#price-example-tts-v1}

Стоимость использования {{ speechkit-short-name }} для синтеза речи с использованием API v1 со следующими параметрами:

* **Количество символов, отправленных за месяц:** 2023.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechkit-tts-v1](../_pricing_examples/speechkit/rub-speechkit-tts-v1.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechkit-tts-v1](../_pricing_examples/speechkit/kzt-speechkit-tts-v1.md) %}

{% endlist %}



### Синтез речи с использованием API v3 {#price-example-tts-v3}

Стоимость использования {{ speechkit-short-name }} для синтеза речи с использованием API v3 со следующими параметрами:

* **Количество отправленных запросов:** 3.
* **Количество символов в запросах:** 150, 300, 600.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechkit-tts-v3](../_pricing_examples/speechkit/rub-speechkit-tts-v3.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechkit-tts-v3](../_pricing_examples/speechkit/kzt-speechkit-tts-v3.md) %}

{% endlist %}



### Распознавание речи в потоковом режиме {#price-example-stt-streaming}

Стоимость использования {{ speechkit-short-name }} для распознавания речи в потоковом режиме со следующими параметрами:

* **Количество аудиофрагментов:** 2.
* **Длительность аудиофрагментов:** 5 секунд, 37 секунд.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechkit-stt-streaming](../_pricing_examples/speechkit/rub-speechkit-stt-streaming.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechkit-stt-streaming](../_pricing_examples/speechkit/kzt-speechkit-stt-streaming.md) %}

{% endlist %}



### Распознавание речи в синхронном режиме {#price-example-stt-short}

Стоимость использования {{ speechkit-short-name }} для распознавания речи в синхронном режиме со следующими параметрами:

* **Количество аудиофрагментов:** 2.
* **Длительность аудиофрагментов:** 5 секунд, 37 секунд.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechkit-stt-short](../_pricing_examples/speechkit/rub-speechkit-stt-short.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechkit-stt-short](../_pricing_examples/speechkit/kzt-speechkit-stt-short.md) %}

{% endlist %}



### Распознавание речи в асинхронном режиме {#price-example-stt-long}

Стоимость использования {{ speechkit-short-name }} для распознавания речи в асинхронном режиме со следующими параметрами:

* **Количество аудиофрагментов:** 4.
* **Длительность аудиофрагментов:** 5 секунд, 5 секунд, 15.5 секунд, 15.5 секунд.
* **Количество каналов в аудиофрагментах:** 1, 3, 2, 4.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechkit-stt-long](../_pricing_examples/speechkit/rub-speechkit-stt-long.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechkit-stt-long](../_pricing_examples/speechkit/kzt-speechkit-stt-long.md) %}

{% endlist %}



### Распознавание речи в асинхронном отложенном режиме {#price-example-stt-long-deferred}

Стоимость использования {{ speechkit-short-name }} для распознавания речи в асинхронном отложенном режиме со следующими параметрами:

* **Количество аудиофрагментов:** 3.
* **Длительность аудиофрагментов:** 2 секунды, 14 секунд, 19.5 секунд.
* **Количество каналов в аудиофрагментах:** 2, 3, 4.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechkit-stt-long-deferred](../_pricing_examples/speechkit/rub-speechkit-stt-long-deferred.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechkit-stt-long-deferred](../_pricing_examples/speechkit/kzt-speechkit-stt-long-deferred.md) %}

{% endlist %}


