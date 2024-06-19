---
editable: false
---

# {{ datalens-full-name }} pricing



## Current pricing policy {#effective-rules}

You can use {{ datalens-full-name }} under the service plans that offer different service packages:

* **Community**: Suitable for small teams and non-profit projects.
* **Business**: Suitable for enterprise deployments and business scenarios.

The plan you choose covers your organization and can only be [changed](./settings/service-plan.md#change-service-plan) by its owner or administrator.

From April 23 to June 1, 2024, you will be able to test features of these service plans at no charge. This will help you choose a plan that best fits your needs. After that period, you will have to [pay for the service plan](#service-plan-cost) you choose.

You can find the {{ datalens-full-name }} features based on the service plan in the table below.

| **Service plan** | **Community** | **Business** |
------------------ |---------------|---------------
| Interactive dashboards | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Chart builder | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Data model and computations | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Role-based access management | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Authentication | Yandex ID | Yandex ID, corporate accounts / SSO¹ |
| [{{ datalens-name }} UI customization](./settings/ui-customization.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| [{{ datalens-name }} usage statistics](./operations/connection/create-usage-tracking.md) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| [Secure embedding for private objects](./dashboard/embedded-objects.md#private-embedding) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| [SLA](https://yandex.com/legal/cloud_sla_datalens) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| Technical support | [Basic plan](../support/pricing.md#base) (if the user does not have [Business](../support/pricing.md#business) or [Premium](../support/pricing.md#premium) enabled) | [Business plan](../support/pricing.md#business) (only applies to {{ datalens-name }}) and priority over the Community plan when processing support requests |

{% note info %}

¹ For existing customers who configured an identity federation and used a corporate account to log in to {{ datalens-name }} before April 22, 2024, enterprise authentication and SSO will be available for free as part of the _Community_ plan until December 31, 2024.

{% endnote %}

## Pricing policy as of June 1, 2024 {#service-plan-cost}

Starting June 1, 2024, {{ datalens-name }} billing will be based on the selected service plan.

{% note info %}

When switching to the _Business_ plan, the price for the first month is calculated proportionally to the remaining part of the month at the time of switching.

{% endnote %}

A user is active and subject to billing if their actions have resulted in a query to a data source, e.g., they opened or edited a dashboard, chart, or dataset. Public URLs to dashboards and charts work without authentication and do not contribute to the active user count.

## Prices for Russia {#prices}



{% include notitle [usd.md](../_pricing/datalens/usd.md) %}

