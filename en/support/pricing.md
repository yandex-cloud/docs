---
editable: false
---

# Technical support pricing


## Prices for the Russia region {#prices}





{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

The cost depends on the service plan selected. The plan you choose covers your organization and can only be changed by its owner or administrator. You can use one billing account to pay for technical support of multiple organizations that may have different support service plans activated. Service packages under various service plans are described in [Requesting technical support](overview.md).




| Service plan | Basic | Business | Premium |
--- |----------------|------------------------------|--------
| **Cost** | Free of charge | {{ sku|USD|support.organization.business.fixed_consumption.v1|string }} per month from the billing account selected at the time of service plan activation and 5% of the organization's resource consumption cost, regardless of which billing account the organization's resources are linked to. | Contact us |


{% note info %}

* All prices are shown without VAT. The cost of support is calculated based on the [cost of paid resources consumed](../billing/pricing.md). If a billing account is awarded a [grant](../billing/concepts/bonus-account.md), it will be counted towards payment for the support plan.

{% endnote %}

### Basic {#base}

The basic service plan is provided to all {{ yandex-cloud }} users at no separate charge. It is suitable for personal and research projects.

### Business {#business}

This plan is good for business projects requiring 24/7 support.
The price is calculated based on the amount of resources consumed over the current reporting period (calendar month). To calculate the cost of using the service, use [our calculator](/prices#calculator) or see the calculation methods in the sections below.

#### Service plan cost {#business-price}




{% include [usd.md](../_pricing/support/usd-business-2023.md) %}


#### Example of calculating the cost for an organization whose resources are paid from a single billing account {#business-example-one-ba}




{% include [usd-support-one-ba](../_pricing_examples/support/usd-one-ba.md) %}


#### Example of calculating the cost for an organization whose resources are paid from two billing accounts {#business-example-two-ba}

If an organization with an activated support service plan uses resources paid from different billing accounts, the percentage portion of the plan cost will be charged to each billing account according to the cost of consumed resources. The fixed portion will be paid by one account only: the one specified when selecting the Business service plan.




{% include [usd-support-two-ba](../_pricing_examples/support/usd-two-ba.md) %}



### Premium {#premium}

The [Premium plan](/support) covers all services of other plans and can be further enhanced to best suit your requirements. It may include troubleshooting recommendations for interactions of {{ yandex-cloud }} services with third-party software, consulting sessions with a dedicated support engineer based on your {{ yandex-cloud }} usage scenario, and services of a personal technical manager.

For a cost estimate for the Premium plan, please contact your {{ yandex-cloud }} manager or [technical support]({{ link-console-support }}).
