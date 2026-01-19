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

## {{ datalens-name }} service plan {#effective-rules}

{{ datalens-full-name }} has a single service plan where access is free for individual users and teams are billed based on the number of [seats](#seats).

### Seats {#seats}

* Every {{ datalens-full-name }} user needs a seat, even if only to view or edit dashboards.
* Seats are issued automatically when new users first log in to {{ datalens-full-name }}.
* Seats can be managed by the administrator, see [this article](./settings/seats.md) for details.
* You can manage access to objects in {{ datalens-full-name }} using [roles and access permissions](./security/index.md); a seat does not provide access to objects.

{% note info %}

By default, seat auto-purchasing is enabled in the instance: a seat is immediately issued to a user upon their first login to {{ datalens-name }}. The administrator can [disable this option](./settings/seats.md#purchase-automatically) in the settings to only assign already available seats to new users. If there are no such seats, the administrator will have to manually issue seats to new users.

{% endnote %}

Seats are counted towards the month's total, regardless of user activity. If the instance contains more than one seat, the total charge is calculated as follows:

> Number of seats × Cost per seat

You may schedule a cut in the number of seats at any time; however, the change will take effect only on the first day of the following calendar month.

Technical support coverage is determined by the [{{ yandex-cloud }}](../support/overview.md) support plan you select.

### Trial period {#trial}

New {{ datalens-name }} users can take advantage of a 30-day trial period during which teamwork is free. At the end of the trial period, you will need to link a billing account to start paying for seats or reduce the consumption per instance to one seat.

You can only use the trial period once per {{ datalens-name }} instance: it activates automatically when you activate the instance. When exiting the trial, your first month's cost is prorated based on remaining days in the month.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The cost of using {{ datalens-name }} depends on the number of seats per instance. For individual users with a single seat in the instance, {{ datalens-name }} is available at no charge. If {{ datalens-name }} is used for teamwork, and your instance has more than one seat, each seat will be charged.



{% include notitle [usd.md](../_pricing/datalens/usd.md) %}



#### See also {#see-also}

* [Updated pricing policy as of December 1](./pricing-changes.md)
* [Pricing and payment questions](./qa/pricing.md)
* [Managing seats in {{ datalens-name }}](./settings/seats.md)

