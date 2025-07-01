---
title: Тарифные планы {{ datalens-full-name }}
description: В статье содержится сравнение тарифных планов сервиса {{ datalens-name }}.
editable: false
---

# Тарифные планы {{ datalens-full-name }}

В сервисе {{ datalens-full-name }} действуют тарифные планы, которые различаются набором предоставляемых услуг:

* **Community** — подходит для небольших команд и некоммерческих проектов;
* **Business** — подходит для корпоративных внедрений и решения бизнес-задач.

Выбранный тарифный план распространяется на организацию и может быть [изменен](../settings/service-plan.md#change-service-plan) только владельцем или администратором организации. Оплата производится за всех [активных пользователей](../pricing.md#active-users). Подробнее о тарифах читайте в [блоге](https://yandex.cloud/ru/blog/posts/2024/03/datalens-tariffs).

Тарифные планы различаются своими возможностями и [стоимостью обслуживания](../pricing.md#prices).

**Тарифный план**  | **Community** | **Business**
------------------ |---------------|---------------
Создание [чартов в визарде](./chart/dataset-based-charts.md), [QL-чартов](./chart/ql-charts.md) и [дашбордов](./dashboard.md) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)   
JavaScript-кастомизации в [Editor](../charts/editor/index.md) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)   
[Подключение к внешним API через Editor](../operations/connection/create-api-connector.md) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)   
[Описание модели данных](../dataset/data-model.md) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)   
[Аналитические вычисления и SQL](./calculations/index.md) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)   
[Ролевая модель прав доступа](../security/roles.md) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)   
[Аутентификация](../security/add-new-user.md) | Яндекс ID, Яндекс 360 | Яндекс ID, Яндекс 360, корпоративные учетные записи / SSO
[Отчеты для экспорта и презентаций](../reports/index.md) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
[Возможность запретить экспорт воркбуков](../workbooks-collections/export-and-import.md) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
[Стилизация интерфейса {{ datalens-name }}](../settings/ui-customization.md) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) 
[Безопасное встраивание чартов и дашбордов](../security/private-embedded-objects.md) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) 
[Контроль публикаций](./datalens-public.md#publication-disable) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)   
Статистика использования сервиса {{ datalens-name }} | Общая ([Light](./datalens-usage-analytics.md#light-dash)) | Расширенная ([Detailed](./datalens-usage-analytics.md#detailed-dash)) 
[SLA](https://yandex.ru/legal/cloud_sla_datalens) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)  
Техническая поддержка | [Базовый тариф](../../support/pricing.md#base) (если у пользователя не подключен [Бизнес](../../support/pricing.md#business) или [Премиум](../../support/pricing.md#premium)) | [Тариф Бизнес](../../support/pricing.md#business) (распространяется только на {{ datalens-name }}) и повышенный приоритет в рассмотрении обращений относительно тарифа Community

#### См. также {#see-also}

* [Правила тарификации](../pricing.md)
* [Вопросы про тарификацию и оплату](../qa/pricing.md)