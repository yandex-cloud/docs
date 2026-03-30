---
title: Pricing policy updates for {{ datalens-full-name }}
description: This article announces upcoming changes to the {{ datalens-name }} pricing policy.
editable: false
---

# Updated pricing policy for {{ datalens-full-name }}



Starting December 1, {{ datalens-full-name }} introduces a revised pricing policy. Under the new unified service plan, all users will gain access to expanded capabilities, including Neuroanalyst, reports, JavaScript-based customizations in Editor, background chart data export, UI styling, and more. The new plan will be offered free of charge for individual use and for a fee for team work.

* [New pricing policy](#new-rules)
* [Transition timeline](#timeline)
* [Discount](#discounts)

## New pricing policy {#new-rules}

### What will change? {#changes}

Pricing will be based on the number of _seats_ within one {{ datalens-full-name }} instance.

* Every {{ datalens-full-name }} user will need a seat, even if only to view or edit dashboards.
* Seats are issued automatically when new users first log in to {{ datalens-full-name }}.
* Seats can be managed by the administrator, see [below](#manage-seats) for details.
* While you can still manage access to objects in {{ datalens-full-name }} using [roles and access permissions](./security/index.md), a seat does not provide access to objects.

### Active users and seats {#difference}

According to the [pricing policy](./pricing-old.md) valid until December 1, 2025, you pay only for _active_ {{ datalens-name }} users. An active user is someone whose actions result in a query to a data source, e.g., opening or editing a dashboard, chart, or dataset.

However, the new [pricing policy](./pricing.md), due to come into effect on December 1, 2025, is going to charge for each seat no matter whether its user is active or not.

### Managing seats {#manage-seats}

Starting December 1, the seat management option will appear in {{ datalens-name }} settings.

{% note info %}

An administrator (a user with the `datalens.admin` role) will be able to enter {{ datalens-name }} settings and manage the list of seats at any time, even without a seat. However, other {{ datalens-name }} features will not be available to the administrator without a seat.

{% endnote %}

The administrator will be able to:

* View the number of seats in the instance, including available (unassigned) ones.
* View the list of users with seats.
* Reassign seats from user to user.
* Increase or decrease the number of seats in the instance.

By March 1, 2026, tools will be released for automatic revocation of inactive seats.

### Prices {#prices}

Within one instance, {{ datalens-name }} will be priced as follows:
* One seat: Free of charge.
* More than one seat: {{ sku|USD|datalens.users.v1|string }} per month per seat.

Seats are counted towards the month's total. If the instance contains more than one seat, the total charge is calculated as follows:

Number of seats × Cost per seat


You may schedule a cut in the number of seats at any time; however, the change will take effect only on the first day of the following month.

Technical support coverage is determined by the [{{ yandex-cloud }}](../support/overview.md) support plan you select.

## Transition timeline {#timeline}

The transition to the new service plan will be gradual.

#|
|| **User category** | **Dates** | **Terms of transition** || 
|| New users | November 17, 2025 |
* Activation of an instance with a 30-day trial period. Full access to all {{ datalens-name }} features without any team work restrictions.
* After 30 days, you either link a billing account and purchase seats for team work or scale down to a single seat.
* Following the end of the trial period, your seat charge for the first month will be calculated in proportion to the number of days left in the month. ||
|| ^ | March 1, 2026 | For seats, queries from [private embedded objects](./security/private-embedded-objects.md) are fixed as follows: 2,000 queries per seat. For more information, see [this section](./pricing.md#packet-queries). ||
|| **Community** plan users <br>(as of November 16, 2025) | December 1, 2025 |
* Transition to the new service plan with an extended trial period until March 1, 2026. Access to all {{ datalens-name }} features without any team work restrictions.
* Special terms apply for transition to a paid {{ datalens-name }} plan for team work; details [below](#discounts).
* Following the end of the trial period, your seat charge for the first month will be calculated in proportion to the number of days left in the month. ||
|| ^ | March 1, 2026 |
* You either link a billing account and purchase seats for team work or scale down to a single seat.
* For seats, queries from [private embedded objects](./security/private-embedded-objects.md) are fixed as follows: 2,000 queries per seat. For more information, see [this section](./pricing.md#packet-queries). ||
|| **Business** plan users <br>(as of November 16, 2025) | December 1, 2025 | Billing shifts from active users to seats. ||
|| ^ | March 1, 2026 | For seats, queries from [private embedded objects](./security/private-embedded-objects.md) are fixed as follows: 2,000 queries per seat. For more information, see [this section](./pricing.md#packet-queries). ||
|#

## Discount {#discounts}

As of November 16, 2025, special conditions apply to **Community** plan users.

If you switch to the **Business** plan before December 1, 2025 or end your trial period early between December 1 and December 31, you will get a 50% discount on all seats from that moment until the end of 2026.

If you complete your trial period early between January 1 and February 28, 2026, you will get a 20% discount on all seats from that moment until the end of 2026.

{% note info %}

Following the end of the trial period, your seat charge for the first month will be calculated in proportion to the number of days left in the month. 

{% endnote %}


#### See also {#see-also}

* [Configuring a {{ datalens-name }} service plan](./settings/service-plan.md)
* [Service plan features](./concepts/service-plans-comparison.md)
* [Pricing and payment questions](./qa/pricing.md)
