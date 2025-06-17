---
title: '{{ datalens-full-name }} pricing policy'
description: This article covers the {{ datalens-name }} pricing policy.
editable: false
---

# {{ datalens-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## {{ datalens-name }} service plans {#effective-rules}

{{ datalens-full-name }} features service plans offering different service packages:

* **Community**: Suitable for small teams and non-profit projects.
* **Business**: Suitable for enterprise deployments and business scenarios.

The plan you choose covers your organization and can only be [changed](./settings/service-plan.md#change-service-plan) by its owner or administrator. You pay for all [active users](#active-users).

Service plans offer different feature sets and [cost](#prices) differently.

**Service plan**  | **Community** | **Business**
------------------ |---------------|---------------
Creating [charts in wizard](./concepts/chart/dataset-based-charts.md), [QL charts](./concepts/chart/ql-charts.md), and [dashboards](./concepts/dashboard.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
JavaScript customizations in [Editor](./charts/editor/index.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)   
[Connecting to external APIs via Editor](./operations/connection/create-api-connector.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)   
[Data model description](./dataset/data-model.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
[Analytic calculations and SQL](./concepts/calculations/index.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
[Role-based access management](./security/roles.md) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg)   
[Authentication](./security/add-new-user.md) | Yandex ID, Yandex 360 | Yandex ID, Yandex 360, corporate accounts / SSO
[Reports for export and presentations](./reports/index.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)
[Prohibiting export of workbooks](./workbooks-collections/export-and-import.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)
[{{ datalens-name }} UI customization](./settings/ui-customization.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) 
[Secure chart and dashboard embedding](./security/private-embedded-objects.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) 
[Published content management](./concepts/datalens-public.md#publication-disable) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)   
{{ datalens-name }} usage statistics | General ([Light](./concepts/datalens-usage-analytics.md#light-dash)) | Advanced ([Detailed](./concepts/datalens-usage-analytics.md#detailed-dash)) 
[SLA](https://yandex.com/legal/cloud_sla_datalens) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg)  
Support | [Basic plan](../support/pricing.md#base) (if the user does not have [Business](../support/pricing.md#business) or [Premium](../support/pricing.md#premium) enabled) | [Business plan](../support/pricing.md#business) (only applies to {{ datalens-name }}) and priority over the Community plan when processing support requests

## Prices for the Russia region {#prices}

The cost of using {{ datalens-name }} depends on the service plan you select.

{% note info %}

If you change to the _Business_ plan, the price for the first month will be proportional to the remaining portion of the month as of the change date.

{% endnote %}

**Active user** {#active-users}

A user is active and subject to billing if their actions have resulted in a query to a data source, e.g., they opened or edited a dashboard, chart, or dataset.

The number of billable users is calculated on a monthly basis: each month, the active users are counted anew. Public URLs to dashboards and charts work without authentication and do not contribute to active user count. You can look up user count in [{{ datalens-name }}](./operations/connection/create-usage-tracking.md) usage statistics.

{% cut "Cost calculation example" %}

Let’s assume an organization has 5 Business plan users of {{ datalens-name }} whose activity over three months was as follows:

* In June, `user_1`, `user_2`, and `user_3` were active. The fee for June will be:
  

  
  {% include [usd-example](../_pricing_examples/datalens/usd-users-1.md) %}


* In June, user_1, `user_2`, and `user_3` were active. The fee for July will be:


  
  {% include [usd-example](../_pricing_examples/datalens/usd-users-2.md) %}


* In August, `user_1`, `user_2`, `user_3`, `user_4`, and `user_5` were active. The fee for August will be:


  
  {% include [usd-example](../_pricing_examples/datalens/usd-users-3.md) %}


{% endcut %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



{% include notitle [usd.md](../_pricing/datalens/usd.md) %}



#### See also {#see-also}

* [Pricing and payment questions](./qa/pricing.md)