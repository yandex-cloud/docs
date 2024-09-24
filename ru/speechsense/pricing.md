---
editable: false
---

# Правила тарификации для {{ speechsense-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## Из чего складывается стоимость использования {{ speechsense-name }} {#rules}

При анализе аудиозаписей диалогов стоимость использования сервиса {{ speechsense-name }} зависит от длительности двухканальных аудиофайлов. Единица тарификации — 1 секунда двухканального аудио.

При анализе текстовых диалогов стоимость использования сервиса зависит от количества символов в диалоге. Единица тарификации — 10 символов. Количество символов в каждом диалоге округляется до десятков в большую сторону. В расчете учитываются все символы диалога. 

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Анализ аудиозаписей диалогов {#speech}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/speechsense/rub-speechsense.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/speechsense/kzt-speechsense.md) %}

{% endlist %}



### Анализ текстовых диалогов {#text}

{% note warning %}

Цена, указанная ниже, начнет действовать с 10 сентября 2024 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/speechsense/rub-text-dialogs.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/speechsense/kzt-text-dialogs.md) %}

{% endlist %}



### Пример расчета стоимости анализа аудиозаписей {#price-example}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechsense](../_pricing_examples/speechsense/rub-speechsense.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechsense](../_pricing_examples/speechsense/kzt-speechsense.md) %}

{% endlist %}



