---
title: '{{ datalens-full-name }} pricing policy'
description: This article covers the {{ datalens-name }} pricing policy.
editable: false
---

# {{ datalens-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## {{ datalens-name }} service plans {#effective-rules}

{{ datalens-full-name }} features service plans offering different service packages:

* **Community**: Suitable for small teams and non-profit projects.
* **Business**: Suitable for enterprise deployments and business scenarios.

The plan you choose covers your organization and can only be [changed](./settings/service-plan.md#change-service-plan) by its owner or administrator. You pay for all [active users](#active-users).

Service plans differ in [features](./concepts/service-plans-comparison.md) they offer and pricing.

## Prices for the Russia region {#prices}

The cost of using {{ datalens-name }} depends on the service plan you select and is calculated per active user per month.

**Active user** {#active-users}

A user is active and subject to billing if their actions have resulted in a query to a data source, e.g., they opened or edited a dashboard, chart, or dataset.

The number of billable users is calculated on a monthly basis: each month, the active users are counted anew. Public URLs to dashboards and charts work without authentication and do not contribute to active user count. You can look up user count in [{{ datalens-name }}](./operations/connection/create-usage-tracking.md) usage statistics.

**Business trial period** {#business-trial}

{{ datalens-name }} users can activate a 30-day trial of the _Business_ plan to test all its [features](./concepts/service-plans-comparison.md) for free. 

Rules of the _Business_ trial period:
* You can activate the trial period only once per {{ datalens-name }} instance.
* You cannot use the trial period if you previously activated the {{ datalens-name }} _Business_ plan.

To activate the _Business_ plan trial period, switch to the _Business_ service plan by following [this guide](./settings/service-plan.md##change-service-plan). Once the trial period ends, the second month of use will be charged to you proportionally to the remaining number of days.

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



{% include notitle [usd.md](../_pricing/datalens/usd.md) %}



{% cut "Cost calculation example" %}

Let’s assume an organization has 5 Business plan users of {{ datalens-name }} whose activity over three months was as follows:

* In June, `user_1`, `user_2`, and `user_3` were active. The fee for June will be:
  

  
  {% include [usd-example](../_pricing_examples/datalens/usd-users-1.md) %}


* In June, user_1, `user_2`, and `user_3` were active. The fee for July will be:


  
  {% include [usd-example](../_pricing_examples/datalens/usd-users-2.md) %}


* In August, `user_1`, `user_2`, `user_3`, `user_4`, and `user_5` were active. The fee for August will be:


  
  {% include [usd-example](../_pricing_examples/datalens/usd-users-3.md) %}


{% endcut %}

#### See also {#see-also}

* [Configuring a {{ datalens-name }} service plan](./settings/service-plan.md)
* [Service plan features](./concepts/service-plans-comparison.md)
* [Pricing and payment questions](./qa/pricing.md)