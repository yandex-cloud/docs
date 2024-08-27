---
title: "Правила тарификации для {{ captcha-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ captcha-name }}."
editable: false
---

# Правила тарификации для {{ captcha-full-name }}



{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## Из чего складывается стоимость использования {{ captcha-full-name }} {#rules}

Тарифицируются [запросы к API {{ captcha-name }}](./quickstart.md#check-answer) по адресу `https://smartcaptcha.yandexcloud.net/validate`. Тарифицируются только [корректные запросы](concepts/validation.md#service-response), на которые API вернул статус `ok`. Для этого запросы должны удовлетворять следующим условиям:

* Сервис {{ captcha-name }} определил запрос как исходящий от человека, а не от робота;
* Переданы корректные значения `secret` и `token`;
* Уникальный `token` выдан не более 10 минут назад.

{% note info %}

Использование {{ captcha-name }} не тарифицируется, если сервис работает в [ограниченном режиме](concepts/restricted-mode).

{% endnote %}

Примеры расчета стоимости использования {{ captcha-name }}:

1. Пользователь прошел капчу, что привело к корректному запросу `/validate` с сервера - тарифицируется.

1. Пользователь отправил пустой или некорректный `token`, что привело к некорректному запросу `/validate` - не тарифицируется.

1. Разработчик бэкэнда допустил ошибку и отправил некорректный `secret` или `token` в ответном запросе `/validate`. API вернет ошибку в поле `message` - не тарифицируется.

1. Злоумышленник прошел капчу и, получив `token`, отправил его 10 раз в течение первой минуты. API вернет статус `ok` только на первый запрос, и тарифицируется также только первый запрос.

1. Злоумышленник прошел капчу и, получив `token`, отправил его 10 раз спустя 10 минут. API вернет статус `failed` на все запросы. Ни один из них не тарифицируется.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/smartcaptcha/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/smartcaptcha/kzt.md) %}

{% endlist %}


