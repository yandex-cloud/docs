---
title: Правила тарификации для {{ datalens-full-name }}
description: В статье содержатся правила тарификации сервиса {{ datalens-name }}.
editable: false
---

# Правила тарификации для {{ datalens-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## Тарифные планы {{ datalens-name }} {#effective-rules}

В сервисе {{ datalens-full-name }} действуют тарифные планы, которые различаются набором предоставляемых услуг:

* **Community** — подходит для небольших команд и некоммерческих проектов;
* **Business** — подходит для корпоративных внедрений и решения бизнес-задач.

Выбранный тарифный план распространяется на организацию и может быть [изменен](./settings/service-plan.md#change-service-plan) только владельцем или администратором организации. Оплата производится за всех [активных пользователей](#active-users). Подробнее о тарифах читайте в [блоге](https://yandex.cloud/ru/blog/posts/2024/03/datalens-tariffs).

Тарифные планы различаются своими возможностями и [стоимостью обслуживания](#prices).

**Тарифный план**  | **Community** | **Business**
------------------ |---------------|---------------
Создание [чартов в визарде](./concepts/chart/dataset-based-charts.md), [QL-чартов](./concepts/chart/ql-charts.md) и [дашбордов](./concepts/dashboard.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
Создание [чартов в Editor](./charts/editor/index.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)   
Подключение [API Connector](./operations/connection/create-api-connector.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)   
[Описание модели данных](./dataset/data-model.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
[Аналитические вычисления и SQL](./concepts/calculations/index.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
[Ролевая модель прав доступа](./security/roles.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
[Аутентификация](./security/add-new-user.md) | Яндекс ID, Яндекс 360 | Яндекс ID, Яндекс 360, корпоративные учетные записи / SSO
[Конструктор отчетов](./reports/index.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)   
[Стилизация интерфейса {{ datalens-name }}](./settings/ui-customization.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) 
[Безопасное встраивание чартов и дашбордов](./security/private-embedded-objects.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) 
[Контроль публикаций](./concepts/datalens-public.md#publication-disable) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)   
Статистика использования сервиса {{ datalens-name }} | Общая ([Light](./concepts/datalens-usage-analytics.md#light-dash)) | Расширенная ([Detailed](./concepts/datalens-usage-analytics.md#detailed-dash)) 
[SLA](https://yandex.ru/legal/cloud_sla_datalens) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)  
Техническая поддержка | [Базовый тариф](../support/pricing.md#base) (если у пользователя не подключен [Бизнес](../support/pricing.md#business) или [Премиум](../support/pricing.md#premium)) | [Тариф Бизнес](../support/pricing.md#business) (распространяется только на {{ datalens-name }}) и повышенный приоритет в рассмотрении обращений относительно тарифа Community

## Цены для региона Россия {#prices}

Стоимость использования {{ datalens-name }} зависит от выбранного тарифного плана.

{% note info %}

При переходе на тарифный план Business цена за первый месяц рассчитывается пропорционально оставшейся части месяца в момент перехода.

{% endnote %}

**Активный пользователь** {#active-users}

Пользователь считается активным и учитывается при тарификации, если его действия привели к запросу данных из источника: например, он открыл или редактировал дашборд, чарт или датасет.

Подсчет пользователей для тарификации ведется в рамках месяца — каждый месяц активные пользователи считаются заново, по факту активности. Публичные ссылки на дашборды и чарты работают без аутентификации и при подсчете активных пользователей не учитываются. Узнать количество пользователей можно в [статистике использования {{ datalens-name }}](./operations/connection/create-usage-tracking.md).

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

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/datalens/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/datalens/kzt.md) %}

{% endlist %}




#### См. также {#see-also}

* [Вопросы про тарификацию и оплату](./qa/pricing.md)