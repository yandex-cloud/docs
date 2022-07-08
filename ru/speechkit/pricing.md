---
editable: false
---

# Правила тарификации для {{ speechkit-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ speechkit-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## Из чего складывается стоимость использования {{ speechkit-short-name }} {#rules}

### Использование синтеза речи {#rules-tts}

Стоимость использования SpeechKit для синтеза речи зависит от версии используемого API. Для [API v1](tts/request.md) стоимость рассчитывается исходя из суммарного количества символов, которые были отправлены для генерации речи из текста за календарный месяц ([Отчетный период](../billing/concepts/glossary#period)).

{% include [pricing-symbol-count](../_includes/pricing-symbol-count.md) %}

Стоимость использования [API v3](new-v3/api-ref/grpc/index.md) зависит от количества отправленных запросов на синтез. Запросы на синтез речи имеют ограничения — {{ tts-v3-count }} и {{ tts-v3-time }}. 

### Использование распознавания речи {#rules-stt}

Стоимость использования {{ speechkit-name }} для распознавания речи зависит от типа распознавания и длительности распознанного аудио. Стоимость рассчитывается за календарный месяц ([Отчетный период]{% if lang == "ru" %}(https://cloud.yandex.ru/docs/billing/concepts/glossary){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/docs/billing/concepts/glossary){% endif %}).

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

## Цены {#prices}

### Синтез речи {#prices-tts}

{% if region == "ru"%}

{% include [rub.md](../_pricing/speechkit/rub-tts.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/speechkit/kzt-tts.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/speechkit/usd-tts.md) %}

{% endif %}

#### Brand Voice {#brand-voice}

{% if region == "ru"%}

{% include [rub.md](../_pricing/speechkit/rub-brand.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/speechkit/kzt-brand.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/speechkit/usd-brand.md) %}

{% endif %}

### Хостинг моделей Brand Voice {#hosting-brand-voice}

{% if region == "ru"%}

{% include [rub.md](../_pricing/speechkit/rub-hosting.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/speechkit/kzt-hosting.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/speechkit/usd-hosting.md) %}

{% endif %}

### Распознавание речи {#prices-stt}

{% if region == "ru"%}

{% include [rub.md](../_pricing/speechkit/rub-stt.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/speechkit/kzt-stt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/speechkit/usd-stt.md) %}

{% endif %}

{% endif %}
