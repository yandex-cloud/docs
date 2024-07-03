---
editable: false
---

# Technical support pricing


## Prices for the Russia region {#prices}





{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

The cost depends on the service plan selected. The plan you choose covers your organization and can only be changed by its owner or administrator. You can use one billing account to pay for technical support of multiple organizations that may have different support service plans activated. Service packages under various service plans are described in [Requesting technical support](overview.md).




| Service plan | Basic | Business | Premium |
--- |----------------|------------------------------|--------
| **Cost** | Free of charge | {{ sku|USD|support.organization.business.fixed_consumption.v1|int|string }} per month from the billing account selected at the time of service plan activation and 5% of the organization's resource consumption cost, regardless of which billing account the organization's resources are linked to. | Contact us |


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




If a customer consumes $800 worth of resources a month, technical support will cost:
{{ sku|USD|support.organization.business.fixed_consumption.v1|int|string }} + $800 * 0.05 = $64.
This amount will be charged to a single billing account.


#### Example of calculating the cost for an organization whose resources are paid from two billing accounts {#business-example-two-ba}

If an organization with an activated support service plan uses resources paid from different billing accounts, the percentage portion of the plan cost will be charged to each billing account according to the cost of consumed resources. The fixed portion will be paid by one account only: the one specified when selecting the Business service plan.




An organization with the Business service plan activated pays for resources from different billing accounts:

* Account 1: Consumes $400 worth of resources a month.
* Account 2: Consumes $80 worth of resources a month.

The fixed amount will only be paid by one of the accounts, for example, Account 1.

The cost of support will be:

* {{ sku|USD|support.organization.business.fixed_consumption.v1|int|string }} + $400 * 0.05 = $44 for Account 1.
* $80 * 0.05 = $4 for Account 2.



### Premium {#premium}

The <q>Premium</q> plan includes all the services offered under the other service plans and can be supplemented based on your requirements.

To get an estimate of the Premium service plan cost, please contact your {{ yandex-cloud }} manager or [technical support]({{ link-console-support }}).
