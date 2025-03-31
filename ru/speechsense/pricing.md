---
title: Правила тарификации для {{ speechsense-full-name }}
description: В статье содержатся правила тарификации сервиса {{ speechsense-name }}.
editable: false
---

# Правила тарификации для {{ speechsense-full-name }}



{% note tip %}


Чтобы рассчитать стоимость аналитики [текстового диалога](https://yandex.cloud/ru/prices?state=719a3e32f3dd#calculator) и [аудиодиалога](https://yandex.cloud/ru/prices?state=82a33349cfc5#calculator), воспользуйтесь калькулятором на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

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


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/speechsense/rub-text-dialogs.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/speechsense/kzt-text-dialogs.md) %}

{% endlist %}



### Пример расчета стоимости анализа аудиозаписей {#price-example-speech}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechsense](../_pricing_examples/speechsense/rub-speechsense.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechsense](../_pricing_examples/speechsense/kzt-speechsense.md) %}

{% endlist %}



### Пример расчета стоимости анализа текстовых диалогов {#price-example-text}

#### Пример 1 {#example-1}

Пусть за месяц использования {{ speechsense-name }} было проанализировано 90 000 015 символов. Количество символов в каждом диалоге округляется до десятков в большую сторону, значит тарифицироваться будет 90 000 020 символов или 90 000,02 тысяч символов.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechsense-text-100k](../_pricing_examples/speechsense/rub-speechsense-text-100k.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechsense-text-100k](../_pricing_examples/speechsense/kzt-speechsense-text-100k.md) %}

{% endlist %}



#### Пример 2 {#example-2}

Пусть за месяц использования {{ speechsense-name }} было проанализировано 150 000 023 символа. Количество символов в каждом диалоге округляется до десятков в большую сторону, значит тарифицироваться будет 150 000 030 символов или 150 000,03 тысяч символов.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechsense-text-500k](../_pricing_examples/speechsense/rub-speechsense-text-500k.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechsense-text-500k](../_pricing_examples/speechsense/kzt-speechsense-text-500k.md) %}

{% endlist %}



#### Пример 3 {#example-3}

Пусть за месяц использования {{ speechsense-name }} было проанализировано 685 000 000 символов или 685 000 тысяч символов.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-speechsense-text-1M](../_pricing_examples/speechsense/rub-speechsense-text-1M.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-speechsense-text-1M](../_pricing_examples/speechsense/kzt-speechsense-text-1M.md) %}

{% endlist %}



