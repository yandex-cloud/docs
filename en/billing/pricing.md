---
editable: false
---

# {{ yandex-cloud }} pricing policy

In {{ yandex-cloud }}, you can use resources of both billable and non-billable services.

## Non-billable services {#free}

The following services are always free of charge:
* [{{ iam-full-name }}](../iam/pricing.md).
* [{{ resmgr-full-name }}](../resource-manager/pricing.md).
* [{{ certificate-manager-full-name }}](../certificate-manager/pricing.md).
{% if product == "yandex-cloud" %}* [{{ org-full-name }}](../organization/pricing.md).{% endif %}
* [{{ datalens-full-name }}](../datalens/pricing.md){% if product == "yandex-cloud" %}.{% endif %}{% if product == "cloud-il" %}.{% endif %}
{% if product == "yandex-cloud" %}* [{{ forms-full-name }}](../forms/pricing.md).{% endif %}
{% if product == "yandex-cloud" %}* [{{ wiki-full-name }}](../wiki/pricing.md).{% endif %}

## Fees for individual services {#billable}

Billable service costs are calculated based on the resources consumed and time used. Each service implements its own logic for calculating the volume of resources consumed.

For more information about {{ yandex-cloud }} pricing as well as pricing rules for all services, see the [Pricing]({{ link-cloud-calculator }}) page.
