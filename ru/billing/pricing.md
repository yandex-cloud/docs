---
editable: false
---

# Правила тарификации {{ yandex-cloud }}

В {{ yandex-cloud }} вы можете использовать ресурсы как тарифицируемых, так и нетарифицируемых сервисов.

## Нетарифицируемые сервисы {#free}

Расчет стоимости за использование следующих сервисов не производится:
* [{{ iam-full-name }}](../iam/pricing.md);
* [{{ resmgr-full-name }}](../resource-manager/pricing.md);
* [{{ certificate-manager-full-name }}](../certificate-manager/pricing.md);
{% if product == "yandex-cloud" %}* [{{ org-full-name }}](../organization/pricing.md);{% endif %}
* [{{ datalens-full-name }}](../datalens/pricing.md){% if product == "yandex-cloud" %};{% endif %}{% if product == "cloud-il" %}.{% endif %}
{% if product == "yandex-cloud" %}* [{{ forms-full-name }}](../forms/pricing.md);{% endif %}
{% if product == "yandex-cloud" %}* [{{ wiki-full-name }}](../wiki/pricing.md).{% endif %}

## Тарифы отдельных сервисов {#billable}

Стоимость тарифицируемых сервисов рассчитывается на основе количества потребленных ресурсов и времени потребления. Каждый сервис реализует собственную логику подсчета потребленных ресурсов.

Подробности о ценах {{ yandex-cloud }}, а также правила тарификации для всех сервисов можно найти на странице [Тарифы]({{ link-cloud-calculator }}).
