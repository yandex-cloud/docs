---
title: Technical support pricing
description: This article covers the support pricing policy.
editable: false
---

# Technical support pricing


{% note tip %}




For a cost calculation, use [our calculator](https://yandex.cloud/en/prices?state=a1e4dbe0c722#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat.md](../_includes/vat.md) %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The cost depends on the service plan you choose, which covers your organization and can only be changed by its owner or administrator. You can use one billing account to pay for technical support of multiple organizations that may have different support service plans. For the services available under various plans, see [Requesting technical support](overview.md).




Service plan | Basic           | Business                       | Premium
--- |-------------------|------------------------------|--------
 **Cost** | Free of charge | {{ sku|USD|support.organization.business.fixed_consumption.v1|string }} per month charged to the billing account selected at the time of service plan activation plus 5% of the organization's resource consumption cost, regardless of which billing account the resources are linked to. | Upon request


The support cost is calculated based on the [cost of consumed paid resources](../billing/pricing.md). If a billing account is awarded a [grant](../billing/concepts/bonus-account.md), it will be counted towards payment for the support plan.

### Basic {#base}

The basic service plan is provided to all {{ yandex-cloud }} users at no charge. It is suitable for personal and research projects.

### Business {#business}

This plan is good for business projects requiring 24/7 support.
The price is calculated based on the amount of resources consumed over the current reporting period (calendar month). For a cost calculation, use [our calculator](/prices#calculator) or read about the calculation methods in the sections below.

#### Service plan cost {#business-price}




{% include [usd.md](../_pricing/support/usd-business-2023.md) %}


Calculating the support fee (5% of the cost of consumed resources) includes your adjustments, subscriptions, and a committed volume of services under the billing account linked to your organization and paying for support services. When calculating the support fee (5% of the cost of consumed resources), the cost of {{ marketplace-name }} products is excluded. See [this example of cost calculation](#business-example-one-ba-cvos).

#### Example of calculating the cost for an organization whose resources are paid from a single billing account {#business-example-one-ba}




{% include [usd-support-one-ba](../_pricing_examples/support/usd-one-ba.md) %}


#### Example of calculating the cost for an organization whose resources are paid from two billing accounts {#business-example-two-ba}

If an organization with an activated support service plan uses resources paid from different billing accounts, the percentage part of the plan will be charged to each billing account according to the cost of consumed resources. The fixed part will be paid by only one account: the one specified when selecting the _Business_ service plan.




{% include [usd-support-two-ba](../_pricing_examples/support/usd-two-ba.md) %}



#### Example of calculating the cost for an organization whose resources are paid from a single billing account, with a committed volume of services included {#business-example-one-ba-cvos}




{% include [usd-support-one-ba](../_pricing_examples/support/usd-one-ba-cvos.md) %}



### Premium {#premium}

The [Premium plan](/support) includes all features of other plans and can be further enhanced to best suit your requirements. It may include troubleshooting tips for using {{ yandex-cloud }} services with third-party software, advice of a dedicated support engineer based on your {{ yandex-cloud }} usage scenario, and services of a personal technical manager.

To learn how much the _Premium_ plan may cost, contact your {{ yandex-cloud }} manager or [technical support]({{ link-console-support }}).


## How to change your service plan {#change-service-plan}

{% include [change-tariff](../_includes/support/change-pricing.md) %}
