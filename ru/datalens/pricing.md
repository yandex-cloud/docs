---
title: Правила тарификации для {{ datalens-full-name }}
description: В статье содержатся правила тарификации сервиса {{ datalens-name }}.
editable: false
---

# Правила тарификации для {{ datalens-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Тарифные планы {{ datalens-name }} {#effective-rules}

В сервисе {{ datalens-full-name }} действуют тарифные планы, которые различаются набором предоставляемых услуг:

* **Community** — подходит для небольших команд и некоммерческих проектов;
* **Business** — подходит для корпоративных внедрений и решения бизнес-задач.

Выбранный тарифный план распространяется на организацию и может быть [изменен](./settings/service-plan.md#change-service-plan) только владельцем или администратором организации. Оплата производится за всех [активных пользователей](#active-users). Подробнее о тарифах читайте в [блоге](https://yandex.cloud/ru/blog/posts/2024/03/datalens-tariffs).

Тарифные планы различаются своими [возможностями](./concepts/service-plans-comparison.md) и стоимостью обслуживания.

## Цены для региона Россия {#prices}

Стоимость использования {{ datalens-name }} зависит от выбранного тарифного плана и рассчитывается за каждого активного пользователя в месяц.

**Активный пользователь** {#active-users}

Пользователь считается активным и учитывается при тарификации, если его действия привели к запросу данных из источника: например, он открыл или редактировал дашборд, чарт или датасет.

Подсчет пользователей для тарификации ведется в рамках месяца — каждый месяц активные пользователи считаются заново, по факту активности. Публичные ссылки на дашборды и чарты работают без аутентификации и при подсчете активных пользователей не учитываются. Узнать количество пользователей можно в [статистике использования {{ datalens-name }}](./operations/connection/create-usage-tracking.md).

**Пробный период Business** {#business-trial}

Пользователи {{ datalens-name }} могут включить пробный период тарифа Business — 30 дней, в течение которых можно бесплатно тестировать все [возможности](./concepts/service-plans-comparison.md) тарифа. 

Правила пробного периода Business:
* можно использовать один раз в рамках одного экземпляра {{ datalens-name }};
* ранее не был подключен тариф {{ datalens-name }} Business.

Чтобы включить пробный период тарифа Business, измените свой тарифный план на Business [по инструкции](./settings/service-plan.md##change-service-plan). По окончании пробного периода цена за второй месяц использования будет пропорциональна оставшемуся числу дней.

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/datalens/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/datalens/kzt.md) %}

{% endlist %}




{% cut "Пример расчета стоимости" %}

В организации 5 пользователей, которые в течение трех месяцев по-разному пользовались сервисом {{ datalens-name }} с подключенным тарифом Business:

* В июне активными были `пользователь_1`, `пользователь_2` и `пользователь_3`. Плата за июнь составит:
  
  
  {% list tabs group=pricing %}

  - Расчет в рублях {#prices-rub}

    {% include [rub-example](../_pricing_examples/datalens/rub-users-1.md) %}

  - Расчет в тенге {#prices-kzt}

    {% include [kzt-example](../_pricing_examples/datalens/kzt-users-1.md) %}
  
  {% endlist %}



* В июле активными были `пользователь_2` и `пользователь_3`. Плата за июль составит:

  
  {% list tabs group=pricing %}

  - Расчет в рублях {#prices-rub}

    {% include [rub-example](../_pricing_examples/datalens/rub-users-2.md) %}

  - Расчет в тенге {#prices-kzt}

    {% include [kzt-example](../_pricing_examples/datalens/kzt-users-2.md) %}
  
  {% endlist %}



* В августе активными были `пользователь_1`, `пользователь_2`, `пользователь_3`, `пользователь_4` и `пользователь_5`. Плата за август составит:

  
  {% list tabs group=pricing %}

  - Расчет в рублях {#prices-rub}

    {% include [rub-example](../_pricing_examples/datalens/rub-users-3.md) %}

  - Расчет в тенге {#prices-kzt}

    {% include [kzt-example](../_pricing_examples/datalens/kzt-users-3.md) %}
  
  {% endlist %}



{% endcut %}

#### См. также {#see-also}

* [Настройка тарифного плана {{ datalens-name }}](./settings/service-plan.md)
* [Возможности тарифных планов](./concepts/service-plans-comparison.md)
* [Вопросы про тарификацию и оплату](./qa/pricing.md)