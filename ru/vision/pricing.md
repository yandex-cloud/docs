---
editable: false
---

# Правила тарификации для {{ vision-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ vision-short-name }} {#rules}

Сервис {{ vision-short-name }} предоставляет [возможности для анализа](concepts/index.md#features) изображений.

Каждый выполненный анализ изображения для любой из возможностей — одна _единица_ тарификации:

* Если в запросе передано несколько изображений — каждое будет тарифицироваться отдельно.
* Если вы запросили дважды распознать текст для одного изображения — это будет две единицы тарификации. Это полезно, если текст [на языках из разных языковых моделей](operations/ocr/text-detection.md#multiple-languages), например на арабском и иврите.
* Учитывается только выполненный анализ. С вас не снимут деньги, если сервер не работал или вы задали неправильную конфигурацию в запросе.

Возможности [обнаружение лиц](concepts/face-detection/index.md) и [классификация изображений](concepts/classification/index.md) сейчас находятся на [стадии Preview](../overview/concepts/launch-stages), поэтому их использование не тарифицируется.

{% note warning %}

[Распознавание шаблонов](concepts/ocr/template-recognition.md) также находится на [стадии Preview](../overview/concepts/launch-stages) и не тарифицируется дополнительно, но его использование тарифицируется [по правилам для распознавания текста](#prices).

{% endnote %}

## Цены {#prices}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/vision/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/vision/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/vision/usd.md) %}

{% endif %}