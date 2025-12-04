---
title: Pricing policy updates for {{ datalens-full-name }}
description: This article announces upcoming changes to the {{ datalens-name }} pricing policy.
editable: false
---

# Updated pricing policy for {{ datalens-full-name }}

Starting December 1, {{ datalens-full-name }} introduces a revised pricing policy. Under the new unified service plan, all users will gain access to expanded capabilities, including Neuroanalyst, reports, JavaScript-based customizations in Editor, background chart data export, UI styling, and more. The new plan will be offered free of charge for individual use and for a fee for team work.

## New pricing policy {#new-rules}

Billing will be based on the number of desktops users will get within one {{ datalens-full-name }} instance. One desktop grants full access to all {{ datalens-name }} features to one user.

You can assign desktops to particular {{ datalens-name }} instance users; mechanisms for auto-purchasing, auto-assignment, and reassignment of desktops are soon to come. Users without a desktop will not be able to use {{ datalens-name }}.

Within one instance, {{ datalens-name }} will be priced as follows:
* One desktop: Free of charge.
* Two or more desktops: $8.249997 per desktop per month.

Desktop charges are not written off in one go but daily throughout the month according to the formula:

$(Number_of_desktops × Cost_per_desktop) / Number_of_days_in_the_month$


You may schedule a cut in the number of desktops at any time; however, the change will take effect only on the first day of the following month.

Technical support coverage is determined by the [{{ yandex-cloud }} support plan](../support/overview.md) you select.

{% note info %}

Under the [current pricing policy](./pricing.md), you pay only for _active {{ datalens-name }} users_. An active user is someone whose actions result in a query to a data source, e.g., opening or editing a dashboard, chart, or dataset. The new pricing policy, however, is going to charge for each desktop no matter whether its user is active or not.

{% endnote %}

## Transition timeline {#timeline}

The transition to the new service plan will be gradual.

#|
|| **User category** | **Dates** | **Terms of transition** || 
|| New users | November 17, 2025 | Activation of an instance with a 30-day trial period. Access to all {{ datalens-name }} features without any team work restrictions. <br>After 30 days, you either link a billing account and purchase desktops for team work or scale down to a single desktop. ||
|| ^ | March 1, 2026 | For desktops, queries to [private embedded objects](./security/private-embedded-objects.md) are fixed as follows: 2,000 queries per desktop. ||
|| **Community** plan users <br>(as of November 16, 2025) | December 1, 2025 | Transition to the new service plan with an extended trial period until March 1, 2026. Access to all {{ datalens-name }} features without any team work restrictions. <br>Special terms apply for transition to a paid {{ datalens-name }} plan for team work; details [below](#discounts). ||
|| ^ | March 1, 2026 | You either link a billing account and purchase desktops for team work or scale down to a single desktop. <br>For desktops, queries to [private embedded objects](./security/private-embedded-objects.md) are fixed as follows: 2,000 queries per desktop. ||
|| **Business** plan users <br>(as of November 16, 2025) | December 1, 2025 | Billing shifts from active users to desktops. Desktop auto-purchase and auto-assignment to new users will be on by default. ||
|| ^ | March 1, 2026 | For desktops, queries to [private embedded objects](./security/private-embedded-objects.md) are fixed as follows: 2,000 queries per desktop. ||
|#

## Discount {#discounts}

As of November 16, 2025, special conditions apply to **Community** plan users. If you link a billing account and switch to a paid plan before the end of 2025, you will get a 50% discount on all desktops from the transition date until the end of 2026.

#### See also {#see-also}

* [Configuring a {{ datalens-name }} service plan](./settings/service-plan.md)
* [Service plan features](./concepts/service-plans-comparison.md)
* [Pricing and payment questions](./qa/pricing.md)
