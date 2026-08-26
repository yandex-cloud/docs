---
title: Правила тарификации для {{ captcha-full-name }}
description: В статье содержатся правила тарификации сервиса {{ captcha-name }}.
editable: false
---

# Правила тарификации для {{ captcha-full-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 4
      sm: 4
      md: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=c6e16cc61f51#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: ../_assets/console-icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2f26fqvaoddbr0ld1a
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: ../_assets/console-icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ captcha-full-name }} {#rules}

Тарифицируются [запросы к API {{ captcha-name }}](./quickstart.md#check-answer) по адресу `https://{{ captcha-domain }}/validate`. Тарифицируются только [корректные запросы](concepts/validation.md#service-response), на которые API вернул статус `ok`. Для этого запросы должны удовлетворять следующим условиям:

* Сервис {{ captcha-name }} определил запрос как исходящий от человека, а не от робота;
* Переданы корректные значения `secret` и `token`;
* Уникальный `token` выдан не более 10 минут назад.

{% note info %}

Использование {{ captcha-name }} не тарифицируется, если сервис работает в [ограниченном режиме](concepts/restricted-mode).

{% endnote %}

Примеры расчета стоимости использования {{ captcha-name }}:

1. Пользователь прошел капчу, что привело к корректному запросу `/validate` с сервера — тарифицируется.

1. Пользователь отправил пустой или некорректный `token`, что привело к некорректному запросу `/validate` — не тарифицируется.

1. Разработчик бэкенда допустил ошибку и отправил некорректный `secret` или `token` в ответном запросе `/validate`. API вернет ошибку в поле `message` — не тарифицируется.

1. Злоумышленник прошел капчу и, получив `token`, отправил его 10 раз в течение первой минуты. API вернет статус `ok` только на первый запрос, и тарифицируется также только первый запрос.

1. Злоумышленник прошел капчу и, получив `token`, отправил его 10 раз спустя 10 минут. API вернет статус `failed` на все запросы. Ни один из них не тарифицируется.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|smart-captcha }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>

Оплачивается фактическое количество запросов. Итоговая стоимость вычисляется ступенчато: первые (100 000 - 10 000) запросов в месяц по одной цене, последующие запросы — по другой цене.

Период тарификации — календарный месяц. 
  
{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}

{% include [prices-difference](../_includes/prices-difference.md) %}

{% include [rub-smartcaptcha](../_pricing_examples/smartcaptcha/rub-smartcaptcha.md) %}



