---
editable: false
---

# Правила тарификации

{% if product == "yandex-cloud" %}

В {{ yandex-cloud }} вы можете использовать ресурсы как тарифицируемых, так и нетарифицируемых сервисов.

## Нетарифицируемые сервисы {#free}

Расчет стоимости за использование сервисов [Yandex Identity and Access Management](../iam/pricing.md) и [Yandex Resource Manager](../resource-manager/pricing.md) не производится.

## Тарифы отдельных сервисов {#billable}

Стоимость тарифицируемых сервисов рассчитывается на основе количества потребленных ресурсов и времени потребления. Каждый сервис реализует собственную логику подсчета потребленных ресурсов.

Подробности о ценах {{ yandex-cloud }}, а также правила тарификации для всех сервисов можно найти на странице [Тарифы](https://cloud.yandex.ru/prices).

{% endif %}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) сервисы {{ yandex-cloud }} не тарифицируются.

{% endif %}