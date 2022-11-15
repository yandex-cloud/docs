---
editable: false
---

# Правила тарификации {{ yandex-cloud }}

{% if product == "yandex-cloud" %}

В {{ yandex-cloud }} вы можете использовать ресурсы как тарифицируемых, так и нетарифицируемых сервисов.

## Нетарифицируемые сервисы {#free}

Расчет стоимости за использование следующих сервисов не производится:
* [{{ iam-full-name }}](../iam/pricing.md);
* [{{ resmgr-full-name }}](../resource-manager/pricing.md);
* [{{ certificate-manager-full-name }}](../certificate-manager/pricing.md);
* [{{ org-full-name }}](../organization/pricing.md);
* [{{ datalens-full-name }}](../datalens/pricing.md);
* [{{ forms-full-name }}](../forms/pricing.md);
* [{{ wiki-full-name }}](../wiki/pricing.md).

## Тарифы отдельных сервисов {#billable}

Стоимость тарифицируемых сервисов рассчитывается на основе количества потребленных ресурсов и времени потребления. Каждый сервис реализует собственную логику подсчета потребленных ресурсов.

Подробности о ценах {{ yandex-cloud }}, а также правила тарификации для всех сервисов можно найти на странице [Тарифы](https://cloud.yandex.ru/prices).

{% endif %}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) сервисы {{ yandex-cloud }} не тарифицируются.

{% endif %}