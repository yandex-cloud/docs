---
editable: false
---

# Правила тарификации для {{ datalens-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## Тарифные планы {{ datalens-name }} {#effective-rules}

В сервисе {{ datalens-full-name }} действуют тарифные планы, которые различаются набором предоставляемых услуг:

* **Community** — подходит для небольших команд и некоммерческих проектов;
* **Business** — подходит для корпоративных внедрений и решения бизнес-задач.

Выбранный тарифный план распространяется на организацию и может быть [изменен](./settings/service-plan.md#change-service-plan) только владельцем или администратором организации. Подробнее о тарифах читайте в [блоге](https://yandex.cloud/ru/blog/posts/2024/03/datalens-tariffs).

Тарифные планы различаются своими возможностями и [стоимостью обслуживания](#prices).

**Тарифный план**  | **Community** | **Business**
------------------ |---------------|---------------
Интерактивные дашборды | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
Конструктор чартов | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
Модель данных и вычисления | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
Ролевая модель прав доступа | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
Аутентификация | Яндекс ID | Яндекс ID, корпоративные учетные записи / SSO¹
[Стилизация интерфейса {{ datalens-name }}](./settings/ui-customization.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) 
[Статистика использования сервиса {{ datalens-name }}](./operations/connection/create-usage-tracking.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) 
[Безопасное встраивание непубличных объектов](./security/private-embedded-objects.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) 
[SLA](https://yandex.ru/legal/cloud_sla_datalens) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)  
Техническая поддержка | [Базовый тариф](../support/pricing.md#base) (если у пользователя не подключен [Бизнес](../support/pricing.md#business) или [Премиум](../support/pricing.md#premium)) | [Тариф Бизнес](../support/pricing.md#business) (распространяется только на {{ datalens-name }}) и повышенный приоритет в рассмотрении обращений относительно тарифа Community

{% note info %}

¹ Для текущих клиентов, которые настроили федерацию удостоверений и использовали корпоративный аккаунт для входа в {{ datalens-name }} до 22 апреля 2024 года, корпоративная аутентификация и SSO будут доступны бесплатно в рамках тарифа Community до 31 декабря 2024 года.

{% endnote %}

## Цены для региона Россия {#prices}

Стоимость использования {{ datalens-name }} зависит от выбранного тарифного плана.

{% note info %}

При переходе на тарифный план Business цена за первый месяц рассчитывается пропорционально оставшейся части месяца в момент перехода.

{% endnote %}

Пользователь считается активным и учитывается при тарификации, если его действия привели к запросу данных из источника: например, он открыл или редактировал дашборд, чарт или датасет. Публичные ссылки на дашборды и чарты работают без аутентификации и при подсчете активных пользователей не учитываются. Узнать количество пользователей можно в [статистике использования {{ datalens-name }}](./operations/connection/create-usage-tracking.md).

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/datalens/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/datalens/kzt.md) %}

{% endlist %}


